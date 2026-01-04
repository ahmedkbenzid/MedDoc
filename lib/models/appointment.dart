// lib/models/appointment.dart

class Appointment {
  final String id;
  final String patientName;
  final DateTime time;
  final String message;
  final String status;

  Appointment({
    required this.id,
    required this.patientName,
    required this.time,
    required this.message,
    required this.status,
  });

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id']?.toString() ?? '',
      patientName: map['patient_name'] ?? 'Patient',
      time: map['time'] != null
          ? DateTime.parse(map['time'])
          : DateTime.now(),
      message: map['message'] ?? '',
      status: map['status'] ?? 'pending',
    );
  }
}
