import 'package:get/get.dart';

class AppointmentController extends GetxController {
  // Liste observable des rendez-vous
  var appointments = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Charger les rendez-vous existants (exemples)
    _loadSampleAppointments();
  }

  void _loadSampleAppointments() {
    appointments.value = [];
  }

  // Ajouter un nouveau rendez-vous
  void addAppointment({
    required String docName,
    required String docSpeciality,
    String docImage = '',
    required String date,
    required String reason,
    required String paymentMethod,
    required double totalAmount,
    String? doctorId, // Ajouter un ID unique pour le médecin
  }) {
    final newAppointment = {
      'docName': docName,
      'docSpeciality': docSpeciality,
      'docImage': docImage,
      'date': date,
      'status': 'Confirmed',
      'reason': reason,
      'paymentMethod': paymentMethod,
      'totalAmount': totalAmount,
      'doctorId': doctorId ?? docName, // Utiliser le nom comme ID si non fourni
    };

    appointments.insert(0, newAppointment); // Ajouter au début de la liste
  }

  // Vérifier si un rendez-vous existe déjà avec ce médecin
  bool hasAppointmentWithDoctor(String doctorId) {
    return appointments.any((appointment) => 
      appointment['doctorId'] == doctorId && 
      appointment['status'] != 'Cancelled'
    );
  }

  // Annuler un rendez-vous
  void cancelAppointment(int index) {
    if (index < appointments.length) {
      appointments[index]['status'] = 'Cancelled';
      appointments.refresh();
    }
  }

  // Supprimer un rendez-vous
  void deleteAppointment(int index) {
    if (index < appointments.length) {
      appointments.removeAt(index);
    }
  }
}
