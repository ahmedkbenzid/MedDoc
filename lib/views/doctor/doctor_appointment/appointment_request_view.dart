import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/appointment.dart';
import 'package:flutter_application_1/services/appointment_service.dart';

class AppointmentRequestView extends StatefulWidget {
  const AppointmentRequestView({super.key});

  @override
  State<AppointmentRequestView> createState() => _AppointmentRequestViewState();
}

class _AppointmentRequestViewState extends State<AppointmentRequestView> {
  final AppointmentService service = AppointmentService();

  Future<void> _reschedule(Appointment appt) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date == null) return;

    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return;

    final newDate = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    await service.reschedule(appt.id, newDate);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Appointment Requests")),
      body: FutureBuilder<List<Appointment>>(
        future: service.getRequests(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final requests = snapshot.data!;
          if (requests.isEmpty) return const Center(child: Text("No requests"));

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final req = requests[index];

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(req.patientName),
                  subtitle: Text(req.message),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check, color: Colors.green),
                        onPressed: () async {
                          await service.updateStatus(req.id, 'accepted');
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () async {
                          await service.updateStatus(req.id, 'refused');
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.schedule, color: Colors.orange),
                        onPressed: () => _reschedule(req),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
