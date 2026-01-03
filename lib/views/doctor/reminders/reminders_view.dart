import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/consts/fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'add_reminder_view.dart';

class RemindersView extends StatelessWidget {
  const RemindersView({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock list of reminders
    final reminders = List.generate(
      5,
      (index) => {
        'patient': 'Patient ${index + 1}',
        'message': 'N’oubliez pas votre rendez-vous',
        'datetime': '2026-01-0${index + 1} 10:00 AM',
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: AppStyles.bold(
          title: "Reminders",
          color: AppColors.whiteColor,
          size: 18,
        ),
        backgroundColor: AppColors.blueColor,
      ),
      body: ListView.builder(
        itemCount: reminders.length,
        itemBuilder: (context, index) {
          final reminder = reminders[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              title: AppStyles.bold(title: reminder['patient']!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppStyles.normal(title: reminder['message']!),
                  2.heightBox,
                  Text(reminder['datetime']!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddReminderView(
                        patientName: reminder['patient']!,
                        message: reminder['message']!,
                        dateTime: reminder['datetime']!,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.blueColor,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddReminderView(),
            ),
          );
        },
      ),
    );
  }
}
