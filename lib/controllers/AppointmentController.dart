import 'package:get/get.dart';
import '../models/appointment.dart';

class AppointmentController extends GetxController {
  RxList<Appointment> appointments = <Appointment>[].obs;

  void acceptAppointment(Appointment appointment) {
    appointment.status = AppointmentStatus.accepted;
    appointments.refresh(); // met à jour l'UI
  }

  void refuseAppointment(Appointment appointment) {
    appointment.status = AppointmentStatus.refused;
    appointments.refresh(); // met à jour l'UI
  }

  // Ajouter d'autres méthodes plus tard si besoin
}
