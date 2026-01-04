import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/message.dart';

class ChatService {
  final supabase = Supabase.instance.client;

  // UUID exact du docteur (celui utilisé dans Supabase)
  final String doctorId = '11111111-1111-1111-1111-111111111111';

  /// 🔹 Récupérer tous les messages d’un patient
  Future<List<Message>> getMessages(String patientId) async {
    final response = await supabase
        .from('messages')
        .select()
        .eq('doctor_id', doctorId)
        .eq('patient_id', patientId)
        .order('created_at', ascending: true);

    final List data = response as List;

    return data.map((e) => Message.fromMap(Map<String, dynamic>.from(e))).toList();
  }

  /// 🔹 Récupérer le dernier message par patient
  Future<List<Map<String, dynamic>>> getPatientsLastMessage() async {
    final response = await supabase
        .from('messages')
        .select()
        .eq('doctor_id', doctorId)
        .order('created_at', ascending: false);

    final allMessages = (response as List).map((e) => Map<String, dynamic>.from(e)).toList();

    // garder uniquement le dernier message par patient
    final Map<String, Map<String, dynamic>> latestByPatient = {};
    for (final msg in allMessages) {
      final patientId = msg['patient_id']?.toString() ?? 'unknown';
      if (!latestByPatient.containsKey(patientId)) {
        latestByPatient[patientId] = msg;
      }
    }

    return latestByPatient.values.toList();
  }

  /// 🔹 Envoyer un message
  Future<void> sendMessage({
    required String patientId,
    required String patientName,
    required String content,
  }) async {
    await supabase.from('messages').insert({
      'doctor_id': doctorId,
      'patient_id': patientId,
      'patient_name': patientName,
      'content': content,
      'is_read': false,
    });
  }
}
