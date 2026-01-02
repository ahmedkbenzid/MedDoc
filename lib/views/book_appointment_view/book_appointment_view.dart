import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/consts/fonts.dart';
import 'package:flutter_application_1/res/components/custom_button.dart';
import 'package:flutter_application_1/res/components/custum_textfield.dart';
import 'package:flutter_application_1/views/appointment_view/appointment_view.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class BookAppointmentView extends StatelessWidget {
  const BookAppointmentView({super.key});

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
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              AppStyles.bold(title: "Select Appointment day"),
              5.heightBox,
              const CustumTextfield(hint: "Select day"),
              10.heightBox,
              AppStyles.bold(title: "Select Appointment time"),
              5.heightBox,
              const CustumTextfield(hint: "Select time"),
              20.heightBox,
              AppStyles.bold(title: "Phone Number:"),
              5.heightBox,
              const CustumTextfield(hint: "Enter your phone number"),
              10.heightBox,
              AppStyles.bold(title: "Full Name:"),
              5.heightBox,
              const CustumTextfield(hint: "Enter your name"),
              10.heightBox,
              AppStyles.bold(title: "Message:"),
              5.heightBox,
              const CustumTextfield(hint: "Enter your message"),
          
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomButton(
          onTap: (){
            Get.to(()=> AppointmentView());
          } , 
          buttonText: "Confirm your appointment",
        ),
      ),
    );
  }
}