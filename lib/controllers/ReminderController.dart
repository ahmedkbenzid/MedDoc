import 'package:get/get.dart';
import '../models/appointment.dart';
import 'dart:async';

class ReminderController extends GetxController {
  // Liste des rendez-vous à surveiller pour les rappels
  var appointments = <Appointment>[].obs;

  // Intervalle de vérification pour les rappels (ex: toutes les minutes)
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startReminderCheck();
  }

  // Ajouter un rendez-vous pour le suivi
  void addAppointment(Appointment appointment) {
    appointments.add(appointment);
  }

  // Démarre la vérification périodique
  void _startReminderCheck() {
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      _checkReminders();
    });
  }

  // Vérifie les rendez-vous et envoie les rappels si nécessaire
  void _checkReminders() {
    final now = DateTime.now();
    for (var appointment in appointments) {
      if (appointment.status == AppointmentStatus.accepted) {
        final difference = appointment.dateTime.difference(now).inMinutes;
        if (difference == 60) { // 1 heure avant
          _sendReminder(appointment);
        }
      }
    }
  }

  // Simulation de l'envoi de rappel
  void _sendReminder(Appointment appointment) {
    print("Reminder: Appointment with Dr. ${appointment.doctor.name} for patient ${appointment.patient.fullName} at ${appointment.dateTime}");
    // Ici tu peux intégrer des notifications locales, SMS ou e-mail
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
