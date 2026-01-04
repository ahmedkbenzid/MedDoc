import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/appointment.dart';
import 'package:flutter_application_1/services/appointment_service.dart';
import 'appointment_detail_view.dart';

class AgendaView extends StatelessWidget {
  AgendaView({super.key});

  final AppointmentService service = AppointmentService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agenda")),
      body: FutureBuilder<List<Appointment>>(
        future: service.getAgenda(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final agenda = snapshot.data!;
          if (agenda.isEmpty) return const Center(child: Text("No appointments"));

          return ListView.builder(
            itemCount: agenda.length,
            itemBuilder: (context, index) {
              final appt = agenda[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(appt.patientName),
                  subtitle: Text(appt.time.toString()),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AppointmentDetailView(appointment: appt),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
