import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/reminder.dart';

class ReminderService {
  final supabase = Supabase.instance.client;

  Future<List<Reminder>> getReminders() async {
    final doctorId = supabase.auth.currentUser?.id;
    if (doctorId == null) throw Exception('User not authenticated');

    final response = await supabase
        .from('reminders') // table "reminders"
        .select()
        .eq('doctor_id', doctorId)
        .order('datetime', ascending: true);

    final List data = response as List;
    return data.map((e) => Reminder.fromMap(Map<String, dynamic>.from(e))).toList();
  }

  Future<void> addReminder({
    required String patientName,
    required String message,
    required DateTime dateTime,
  }) async {
    try {
      final doctorId = supabase.auth.currentUser?.id;
      if (doctorId == null) throw Exception('User not authenticated');

      await supabase.from('reminders').insert({
        'doctor_id': doctorId,
        'patient_name': patientName,
        'message': message,
        'datetime': dateTime.toIso8601String(),
      });
    } catch (e) {
      print('Error adding reminder: $e');
      rethrow;
    }
  }

  Future<void> updateReminder(Reminder reminder) async {
    try {
      await supabase
          .from('reminders')
          .update(reminder.toMap())
          .eq('id', reminder.id);
    } catch (e) {
      print('Error updating reminder: $e');
      rethrow;
    }
  }

  Future<void> deleteReminder(String id) async {
    await supabase.from('reminders').delete().eq('id', id);
  }
}
