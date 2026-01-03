import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/consts/fonts.dart';
import 'patient_detail_view.dart';

class PatientListView extends StatelessWidget {
  const PatientListView({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock patients list
    final patients = List.generate(
      10,
      (index) => {
        'name': 'Patient ${index + 1}',
        'lastVisit': '2026-01-${10 + index}',
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: AppStyles.bold(
          title: "Dossiers Patients",
          color: AppColors.whiteColor,
          size: 18,
        ),
        backgroundColor: AppColors.blueColor,
      ),
      body: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) {
          final patient = patients[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              title: AppStyles.bold(title: patient['name']!),
              subtitle: AppStyles.normal(
                title: "Dernière consultation: ${patient['lastVisit']!}",
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PatientDetailView(
                      patientName: patient['name']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
