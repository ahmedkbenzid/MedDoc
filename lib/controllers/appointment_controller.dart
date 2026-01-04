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
    appointments.value = [
      {
        'docName': 'Dr. John Smith',
        'docSpeciality': 'Cardiologist',
        'date': 'Wednesday, Jun 23, 2021 | 02:00 PM',
        'status': 'Confirmed',
        'reason': 'Regular checkup',
        'paymentMethod': 'VISA',
        'totalAmount': 65.00,
      },
      {
        'docName': 'Dr. Sarah Johnson',
        'docSpeciality': 'Dentist',
        'date': 'Thursday, Jun 24, 2021 | 10:00 AM',
        'status': 'Pending',
        'reason': 'Tooth pain',
        'paymentMethod': 'Cash',
        'totalAmount': 50.00,
      },
      {
        'docName': 'Dr. Michael Brown',
        'docSpeciality': 'Orthopedic',
        'date': 'Friday, Jun 25, 2021 | 03:00 PM',
        'status': 'Confirmed',
        'reason': 'Back pain',
        'paymentMethod': 'MasterCard',
        'totalAmount': 80.00,
      },
      {
        'docName': 'Dr. Emily Davis',
        'docSpeciality': 'Dermatologist',
        'date': 'Monday, Jun 28, 2021 | 11:00 AM',
        'status': 'Cancelled',
        'reason': 'Skin rash',
        'paymentMethod': 'PayPal',
        'totalAmount': 45.00,
      },
    ];
  }

  // Ajouter un nouveau rendez-vous
  void addAppointment({
    required String docName,
    required String docSpeciality,
    required String date,
    required String reason,
    required String paymentMethod,
    required double totalAmount,
  }) {
    final newAppointment = {
      'docName': docName,
      'docSpeciality': docSpeciality,
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
