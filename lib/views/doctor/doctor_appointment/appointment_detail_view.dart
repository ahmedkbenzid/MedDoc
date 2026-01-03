import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/consts/fonts.dart';
import 'package:velocity_x/velocity_x.dart';


class AppointmentDetailView extends StatelessWidget {
  final Map<String, String> appointment;

  const AppointmentDetailView({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppStyles.bold(title: appointment['patient']!, color: AppColors.whiteColor, size: 18),
        backgroundColor: AppColors.blueColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppStyles.bold(title: "Patient Name:"),
            AppStyles.normal(title: appointment['patient']!),
            10.heightBox,
            AppStyles.bold(title: "Appointment Time:"),
            AppStyles.normal(title: appointment['time']!),
            10.heightBox,
            AppStyles.bold(title: "Message:"),
            AppStyles.normal(title: appointment['message']!),
          ],
        ),
      ),
    );
  }
}
