import 'doctor.dart';
import 'patient.dart';

enum AppointmentStatus { pending, accepted, refused, completed } // attention: 'refused' et non 'rejected'

class Appointment {
  final String id;
  final Doctor doctor;
  final Patient patient;
  final DateTime dateTime;
  final String message;
  AppointmentStatus status;

  Appointment({
    required this.id,
    required this.doctor,
    required this.patient,
    required this.dateTime,
    this.message = '',
    this.status = AppointmentStatus.pending,
  });
}
