import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/appointment.dart';

class AppointmentDetailView extends StatelessWidget {
  final Appointment appointment;

  const AppointmentDetailView({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appointment.patientName)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Patient: ${appointment.patientName}"),
            Text("Date: ${appointment.time}"),
            Text("Message: ${appointment.message}"),
            Text("Status: ${appointment.status}"),
          ],
        ),
      ),
    );
  }
}
