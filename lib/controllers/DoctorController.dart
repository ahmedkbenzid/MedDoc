import 'package:get/get.dart';
import '../models/doctor.dart';

class DoctorController extends GetxController {
  // Liste des docteurs
  var doctors = <Doctor>[].obs;

  // Méthode pour ajouter un nouveau doctor
  void addDoctor(Doctor doctor) {
    doctors.add(doctor);
  }

  // Méthode pour mettre à jour le profil
  void updateDoctor(String doctorId, Doctor updatedDoctor) {
    int index = doctors.indexWhere((d) => d.id == doctorId);
    if (index != -1) {
      doctors[index] = updatedDoctor;
    }
  }

  // Méthode pour obtenir un docteur par ID
  Doctor? getDoctorById(String doctorId) {
    return doctors.firstWhereOrNull((d) => d.id == doctorId);
  }

  // Ajouter ou modifier les services d'un doctor
  void updateServices(String doctorId, List<String> newServices) {
    Doctor? doctor = getDoctorById(doctorId);
    if (doctor != null) {
      doctor.services = newServices;
      doctors.refresh(); // pour mettre à jour la vue
    }
  }

  // Ajouter ou modifier les horaires de travail
  void updateWorkingHours(String doctorId, Map<String, String> newHours) {
    Doctor? doctor = getDoctorById(doctorId);
    if (doctor != null) {
      doctor.workingHours = newHours;
      doctors.refresh();
    }
  }
}
