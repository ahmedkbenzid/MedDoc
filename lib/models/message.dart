class Message {
  final String id;
  final String doctorId;
  final String patientId;
  final String content;
  final DateTime dateTime;
  bool isRead;

  Message({
    required this.id,
    required this.doctorId,
    required this.patientId,
    required this.content,
    required this.dateTime,
    this.isRead = false,
  });
}
