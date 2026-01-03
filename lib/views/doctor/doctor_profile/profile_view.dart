import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/consts/fonts.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'edit_profile_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppStyles.bold(title: "My Profile", color: AppColors.whiteColor, size: 18),
        backgroundColor: AppColors.blueColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: AppColors.whiteColor),
            onPressed: () {
              Get.to(() => const EditProfileView());
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.blueColor,
                child: Icon(Icons.person, size: 50, color: AppColors.whiteColor),
              ),
            ),
            10.heightBox,
            AppStyles.bold(title: "Dr. John Doe", size: 18),
            AppStyles.normal(title: "Cardiologist", size: 14, color: AppColors.textColor.withOpacity(0.7)),
            20.heightBox,
            AppStyles.bold(title: "Working Hours", size: 16),
            AppStyles.normal(title: "Mon - Fri | 09:00 AM - 05:00 PM"),
            10.heightBox,
            AppStyles.bold(title: "Services", size: 16),
            AppStyles.normal(title: "Cardiology consultations, Heart check-ups"),
            10.heightBox,
            AppStyles.bold(title: "Contact", size: 16),
            AppStyles.normal(title: "+216 55 333 000"),
            AppStyles.normal(title: "dr.john@example.com"),
            10.heightBox,
            AppStyles.bold(title: "Address", size: 16),
            AppStyles.normal(title: "123 Medical Street, Tunis, Tunisia"),
          ],
        ),
      ),
    );
  }
}
