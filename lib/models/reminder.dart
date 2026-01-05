class Reminder {
  final String id;
  final String patientName;
  final String message;
  final DateTime dateTime;

  Reminder({
    required this.id,
    required this.patientName,
    required this.message,
    required this.dateTime,
  });

  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(
      id: map['id'] ?? '',
      patientName: map['patient_name'] ?? 'Patient',
      message: map['message'] ?? '',
      dateTime: map['datetime'] != null
          ? DateTime.parse(map['datetime'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patient_name': patientName,
      'message': message,
      'datetime': dateTime.toIso8601String(),
    };
  }
}
