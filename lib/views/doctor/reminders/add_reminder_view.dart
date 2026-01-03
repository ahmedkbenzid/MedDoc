import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class AddReminderView extends StatefulWidget {
  final String? patientName;
  final String? message;
  final String? dateTime;

  const AddReminderView({super.key, this.patientName, this.message, this.dateTime});

  @override
  State<AddReminderView> createState() => _AddReminderViewState();
}

class _AddReminderViewState extends State<AddReminderView> {
  final TextEditingController _patientController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _patientController.text = widget.patientName ?? '';
    _messageController.text = widget.message ?? '';
    if (widget.dateTime != null) {
      _selectedDateTime = DateTime.tryParse(widget.dateTime!);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.patientName != null ? "Edit Reminder" : "Add Reminder"),
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
                TextButton(
                  onPressed: _pickDateTime,
                  child: const Text("Pick"),
                ),
              ],
            ),
            20.heightBox,
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.blueColor),
              onPressed: () {
                // Pour l'instant juste un snack bar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Reminder saved (mock)")),
                );
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
