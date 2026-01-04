// lib/services/appointment_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/appointment.dart';

class AppointmentService {
  final supabase = Supabase.instance.client;
  final String doctorId = '11111111-1111-1111-1111-111111111111'; // UUID du docteur

  /// Récupérer tous les rendez-vous du docteur
  Future<List<Appointment>> getAgenda() async {
    final response = await supabase
        .from('appointments')
        .select()
        .eq('doctor_id', doctorId)
        .order('time', ascending: true);

    final List data = response as List;
    return data.map((e) => Appointment.fromMap(Map<String, dynamic>.from(e))).toList();
  }

  /// Récupérer toutes les demandes en attente
  Future<List<Appointment>> getRequests() async {
    final response = await supabase
        .from('appointments')
        .select()
        .eq('doctor_id', doctorId)
        .eq('status', 'pending')
        .order('time', ascending: true);

    final List data = response as List;
    return data.map((e) => Appointment.fromMap(Map<String, dynamic>.from(e))).toList();
  }

  /// Mettre à jour le status (accepted / refused)
  Future<void> updateStatus(String appointmentId, String status) async {
    await supabase
        .from('appointments')
        .update({'status': status})
        .eq('id', appointmentId);
  }

  /// Replanifier un rendez-vous
  Future<void> reschedule(String appointmentId, DateTime newTime) async {
    await supabase
        .from('appointments')
        .update({'time': newTime.toIso8601String()})
        .eq('id', appointmentId);
  }
}
