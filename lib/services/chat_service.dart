import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/message.dart';

class ChatService {
  final supabase = Supabase.instance.client;

  // Récupérer l'UUID du docteur connecté
  String? get _currentDoctorId => supabase.auth.currentUser?.id;

  /// 🔹 Récupérer tous les messages d’un patient
  Future<List<Message>> getMessages(String patientId) async {
    if (_currentDoctorId == null) {
      throw Exception('Utilisateur non connecté');
    }

    final response = await supabase
        .from('messages')
        .select()
        .eq('doctor_id', _currentDoctorId!)
        .eq('patient_id', patientId)
        .order('created_at', ascending: true);

    final List data = response as List;

    return data.map((e) => Message.fromMap(Map<String, dynamic>.from(e))).toList();
  }

  /// 🔹 Récupérer le dernier message par patient
  Future<List<Map<String, dynamic>>> getPatientsLastMessage() async {
    if (_currentDoctorId == null) {
      throw Exception('Utilisateur non connecté');
    }

    final response = await supabase
        .from('messages')
        .select()
        .eq('doctor_id', _currentDoctorId!)
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
    if (_currentDoctorId == null) {
      throw Exception('Utilisateur non connecté');
    }

    await supabase.from('messages').insert({
      'doctor_id': _currentDoctorId!,
      'patient_id': patientId,
      'patient_name': patientName,
      'content': content,
      'is_read': false,
    });
  }
}
