import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/models/reminder.dart';
import 'package:flutter_application_1/services/reminder_service.dart';
import 'package:velocity_x/velocity_x.dart';

class AddReminderView extends StatefulWidget {
  final Reminder? reminder;

  const AddReminderView({super.key, this.reminder});

  @override
  State<AddReminderView> createState() => _AddReminderViewState();
}

class _AddReminderViewState extends State<AddReminderView> {
  final TextEditingController _patientController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  DateTime? _selectedDateTime;
  final ReminderService _service = ReminderService();

  @override
  void initState() {
    super.initState();
    if (widget.reminder != null) {
      _patientController.text = widget.reminder!.patientName;
      _messageController.text = widget.reminder!.message;
      _selectedDateTime = widget.reminder!.dateTime;
    }
  }

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );
    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime ?? DateTime.now()),
    );
    if (time == null) return;

    setState(() {
      _selectedDateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    });
  }

  void _saveReminder() async {
    if (_patientController.text.isEmpty || _messageController.text.isEmpty || _selectedDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Veuillez remplir tous les champs")));
      return;
    }

    final reminder = Reminder(
      id: widget.reminder?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      patientName: _patientController.text,
      message: _messageController.text,
      dateTime: _selectedDateTime!,
    );

    if (widget.reminder != null) {
      await _service.updateReminder(reminder);
    } else {
      await _service.addReminder(reminder);
    }

    Navigator.pop(context, true); // Retourne true pour rafraîchir la liste
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.reminder != null ? "Edit Reminder" : "Add Reminder"),
        backgroundColor: AppColors.blueColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _patientController,
              decoration: const InputDecoration(labelText: "Patient Name"),
            ),
            10.heightBox,
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(labelText: "Message"),
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDateTime != null
                        ? "Date & Time: ${_selectedDateTime.toString()}"
                        : "Select Date & Time",
                  ),
                ),
                TextButton(onPressed: _pickDateTime, child: const Text("Pick")),
              ],
            ),
            20.heightBox,
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.blueColor),
              onPressed: _saveReminder,
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
