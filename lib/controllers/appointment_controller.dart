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
    };

    appointments.insert(0, newAppointment); // Ajouter au début de la liste
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
