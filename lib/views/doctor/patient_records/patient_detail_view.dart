import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/consts/fonts.dart';

class PatientDetailView extends StatelessWidget {
  final String patientName;

  const PatientDetailView({super.key, required this.patientName});

  @override
  Widget build(BuildContext context) {
    // Mock patient details
    final details = {
      'Adresse': '123 Rue de la Santé',
      'Téléphone': '+216 12 345 678',
      'Maladies': 'Hypertension, Diabète',
      'Traitements': 'Médicaments A, B',
      'Assurance': 'CNAM',
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(patientName),
        backgroundColor: AppColors.blueColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: details.entries.map((entry) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                title: AppStyles.bold(title: entry.key),
                subtitle: AppStyles.normal(title: entry.value),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
