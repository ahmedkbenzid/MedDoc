class Patient {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String gender;
  final DateTime birthDate;
  final String address;
  final String healthInfo; // Allergies, chronic diseases, etc.

  Patient({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.gender,
    required this.birthDate,
    required this.address,
    required this.healthInfo,
  });
}
