class Message {
  final String id;
  final String doctorId;
  final String patientId;
  final String patientName;
  final String content;
  final DateTime createdAt;
  bool isRead;

  Message({
    required this.id,
    required this.doctorId,
    required this.patientId,
    required this.patientName,
    required this.content,
    required this.createdAt,
    this.isRead = false,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id']?.toString() ?? '',
      doctorId: map['doctor_id']?.toString() ?? '',
      patientId: map['patient_id']?.toString() ?? '',
      patientName: map['patient_name']?.toString() ?? 'Patient',
      content: map['content']?.toString() ?? '',
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'].toString())
          : DateTime.now(),
      isRead: map['is_read'] ?? false,
    );
  }
}
