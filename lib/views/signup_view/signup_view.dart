import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/fonts.dart';
import 'package:flutter_application_1/consts/images.dart';
import 'package:flutter_application_1/consts/strings.dart';
import 'package:flutter_application_1/res/components/custom_button.dart';
import 'package:flutter_application_1/res/components/custum_textfield.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 40),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.imgSignup,
                    width: 200,
                  ),
                  10.heightBox,
                  AppStyles.bold(title: AppStrings.signupNow, size: AppSizes.size18, alignment: TextAlign.center),
                ],
            ),
            30.heightBox,
            Expanded(
              child: Form(
                child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustumTextfield(hint: AppStrings.fullname),
                    10.heightBox,
                    CustumTextfield(hint: AppStrings.email),
                    10.heightBox,
                    CustumTextfield(hint: AppStrings.password),
                    20.heightBox,
                    CustomButton(buttonText: AppStrings.signup, onTap: () {}),
                    20.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppStyles.normal(title: AppStrings.alreadyHaveAccount),
                        8.widthBox,
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: AppStyles.bold(title: AppStrings.login),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
