import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/consts/fonts.dart';
import 'appointment_detail_view.dart';

class AgendaView extends StatelessWidget {
  const AgendaView({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for appointments
    final appointments = List.generate(
      5,
      (index) => {
        'patient': 'Patient ${index + 1}',
        'time': '10:${index + 1}0 AM',
        'message': 'Check-up details...',
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: AppStyles.bold(title: "Agenda", color: AppColors.whiteColor, size: 18),
        backgroundColor: AppColors.blueColor,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appt = appointments[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AppointmentDetailView(appointment: appt),
                  ),
                );
              },
              leading: CircleAvatar(
                backgroundColor: AppColors.blueColor,
                child: Icon(Icons.person, color: AppColors.whiteColor),
              ),
              title: AppStyles.bold(title: appt['patient']!),
              subtitle: AppStyles.normal(title: appt['time']!),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
          );
        },
      ),
    );
  }
}
