import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/reminder.dart';

class ReminderService {
  final supabase = Supabase.instance.client;

  Future<List<Reminder>> getReminders() async {
    final response = await supabase
        .from('reminders') // table "reminders"
        .select()
        .order('datetime', ascending: true);

    final List data = response as List;
    return data.map((e) => Reminder.fromMap(Map<String, dynamic>.from(e))).toList();
  }

  Future<void> addReminder(Reminder reminder) async {
    await supabase.from('reminders').insert(reminder.toMap());
  }

  Future<void> updateReminder(Reminder reminder) async {
    await supabase
        .from('reminders')
        .update(reminder.toMap())
        .eq('id', reminder.id);
  }

  Future<void> deleteReminder(String id) async {
    await supabase.from('reminders').delete().eq('id', id);
  }
}
