// lib/services/appointment_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/appointment.dart';

class AppointmentService {
  final SupabaseClient _supabase = Supabase.instance.client;
  
  // Récupérer l'UUID du docteur connecté
  String? get _currentDoctorId => _supabase.auth.currentUser?.id;

  /// Récupérer tous les rendez-vous du docteur
  Future<List<Appointment>> getAgenda() async {
    if (_currentDoctorId == null) {
      throw Exception('Utilisateur non connecté');
    }
    
    final response = await _supabase
        .from('appointments')
        .select()
        .eq('doctor_id', _currentDoctorId!)
        .order('time', ascending: true);

    final List data = response as List;
    return data.map((e) => Appointment.fromMap(Map<String, dynamic>.from(e))).toList();
  }

  /// Récupérer toutes les demandes en attente
  Future<List<Appointment>> getRequests() async {
    if (_currentDoctorId == null) {
      throw Exception('Utilisateur non connecté');
    }
    
    final response = await _supabase
        .from('appointments')
        .select()
        .eq('doctor_id', _currentDoctorId!)
        .eq('status', 'pending')
        .order('time', ascending: true);

    final List data = response as List;
    return data.map((e) => Appointment.fromMap(Map<String, dynamic>.from(e))).toList();
  }

  /// Mettre à jour le status (accepted / refused)
  Future<void> updateStatus(String appointmentId, String status) async {
    await _supabase
        .from('appointments')
        .update({'status': status})
        .eq('id', appointmentId);
  }

  /// Replanifier un rendez-vous
  Future<void> reschedule(String appointmentId, DateTime newTime) async {
    await _supabase
        .from('appointments')
        .update({'time': newTime.toIso8601String()})
        .eq('id', appointmentId);
  }
}
