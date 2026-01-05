import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/consts/fonts.dart';
import 'package:flutter_application_1/models/reminder.dart';
import 'package:flutter_application_1/services/reminder_service.dart';
import 'add_reminder_view.dart';

class RemindersView extends StatefulWidget {
  const RemindersView({super.key});

  @override
  State<RemindersView> createState() => _RemindersViewState();
}

class _RemindersViewState extends State<RemindersView> {
  final ReminderService _service = ReminderService();
  late Future<List<Reminder>> _remindersFuture;

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  void _loadReminders() {
    _remindersFuture = _service.getReminders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppStyles.bold(title: "Reminders", color: AppColors.whiteColor, size: 18),
        backgroundColor: AppColors.blueColor,
      ),
      body: FutureBuilder<List<Reminder>>(
        future: _remindersFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final reminders = snapshot.data!;
          if (reminders.isEmpty) return const Center(child: Text("No reminders"));

          return ListView.builder(
            itemCount: reminders.length,
            itemBuilder: (context, index) {
              final r = reminders[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  title: AppStyles.bold(title: r.patientName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppStyles.normal(title: r.message),
                      2.heightBox,
                      Text(r.dateTime.toString(), style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => AddReminderView(reminder: r)),
                      );
                      if (result == true) _loadReminders(); // recharge la liste
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.blueColor,
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddReminderView()),
          );
          if (result == true) _loadReminders();
        },
      ),
    );
  }
}
