import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/consts/fonts.dart';

class AppointmentRequestView extends StatefulWidget {
  const AppointmentRequestView({super.key});

  @override
  State<AppointmentRequestView> createState() => _AppointmentRequestViewState();
}

class _AppointmentRequestViewState extends State<AppointmentRequestView> {
  late List<Map<String, String>> requests;

  @override
  void initState() {
    super.initState();
    // Mock data for requests
    requests = List.generate(
      5,
      (index) => {
        'patient': 'Patient ${index + 1}',
        'time': '11:${index + 1}0 AM',
        'message': 'Request for consultation',
      },
    );
  }

  Future<void> _showActionDialog(
      BuildContext context, String action, Map<String, String> req) async {
    if (action == "Reschedule") {
      DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
      );
      if (selectedDate != null) {
        TimeOfDay? selectedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (selectedTime != null) {
          // Mettre à jour la demande dans la liste
          setState(() {
            req['time'] =
                "${selectedDate.toLocal().toString().split(' ')[0]} ${selectedTime.format(context)}";
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "${req['patient']} appointment rescheduled to ${req['time']}"),
            ),
          );
        }
      }
    } else {
      // Accept or Refuse
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("$action Appointment"),
          content: Text(
              "Are you sure you want to $action ${req['patient']}'s appointment?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  requests.remove(req); // Supprimer la demande
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        "${req['patient']}'s appointment ${action.toLowerCase()}ed"),
                  ),
                );
              },
              child: const Text("Confirm"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppStyles.bold(
          title: "Appointment Requests",
          color: AppColors.whiteColor,
          size: 18,
        ),
        backgroundColor: AppColors.blueColor,
        elevation: 0,
      ),
      body: requests.isEmpty
          ? Center(
              child: AppStyles.normal(
                  title: "No more requests", color: AppColors.textColor),
            )
          : ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final req = requests[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: AppStyles.bold(title: req['patient']!),
                    subtitle: AppStyles.normal(
                        title: "${req['time']} - ${req['message']}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.check, color: Colors.green),
                          onPressed: () =>
                              _showActionDialog(context, "Accept", req),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () =>
                              _showActionDialog(context, "Refuse", req),
                        ),
                        IconButton(
                          icon: const Icon(Icons.schedule, color: Colors.orange),
                          onPressed: () =>
                              _showActionDialog(context, "Reschedule", req),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
