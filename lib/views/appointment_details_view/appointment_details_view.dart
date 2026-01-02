import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/consts/fonts.dart';

class AppointmentDetailsView extends StatelessWidget {
  const AppointmentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.blueColor,
        title: AppStyles.bold(
          title: "Doctor Name",
          size: AppSizes.size18,
          color: AppColors.whiteColor
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppStyles.bold(title: "Select Appointment day"),
            5.heightBox,
            AppStyles.normal(title: "Selected day"),
            10.heightBox,
            AppStyles.bold(title: "Select Appointment time"),
            5.heightBox,
            AppStyles.normal(title: "Selected time"),
            20.heightBox,
            AppStyles.bold(title: "Phone Number:"),
            5.heightBox,
            AppStyles.normal(title: "22 222 222"),
            10.heightBox,
            AppStyles.bold(title: "Full Name:"),
            5.heightBox,
            AppStyles.normal(title: "Patient name"),
            10.heightBox,
            AppStyles.bold(title: "Message:"),
            5.heightBox,
            AppStyles.normal(title: "Massage "),
          
          ],
        ),
      ),
    );
  }
}