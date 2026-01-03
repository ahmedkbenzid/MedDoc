import 'package:get/get.dart';
import '../models/patient.dart';
import '../models/appointment.dart';

class PatientController extends GetxController {
  // Liste des patients
  var patients = <Patient>[].obs;

  // Dictionnaire pour retrouver les rendez-vous par patient
  var appointmentsByPatient = <String, List<Appointment>>{}.obs;

  // Ajouter un patient
  void addPatient(Patient patient) {
    patients.add(patient);
    appointmentsByPatient[patient.id] = [];
  }

  // Ajouter un rendez-vous pour un patient
  void addAppointmentForPatient(String patientId, Appointment appointment) {
    if (appointmentsByPatient.containsKey(patientId)) {
      appointmentsByPatient[patientId]!.add(appointment);
      appointmentsByPatient.refresh();
    }
  }

  // Récupérer les rendez-vous d'un patient
  List<Appointment> getAppointments(String patientId) {
    return appointmentsByPatient[patientId] ?? [];
  }

  // Mettre à jour les infos du patient
  void updatePatient(Patient updatedPatient) {
    int index = patients.indexWhere((p) => p.id == updatedPatient.id);
    if (index != -1) {
      patients[index] = updatedPatient;
      patients.refresh();
    }
  }
}
