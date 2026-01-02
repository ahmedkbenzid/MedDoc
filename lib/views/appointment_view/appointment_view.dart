import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/consts/fonts.dart';
import 'package:flutter_application_1/consts/images.dart';
import 'package:flutter_application_1/views/appointment_details_view/appointment_details_view.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class AppointmentView extends StatelessWidget {
  const AppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.blueColor,
        title: AppStyles.bold(
          title: "Appointments",
          size: AppSizes.size18,
          color: AppColors.whiteColor
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (
            BuildContext context, int index) { 
              return ListTile(
                onTap: () {
                  Get.to(() => AppointmentDetailsView());
                },
                leading: CircleAvatar(
                  child: Image.asset(AppAssets.imgSignup),
                ),
                title: AppStyles.bold(title: "Doctor Name"),
                subtitle: AppStyles.normal(title: "Appointment time", color: AppColors.textColor.withOpacity(0.5)),
              );
            },
        ),
      ),
    );
  }
}