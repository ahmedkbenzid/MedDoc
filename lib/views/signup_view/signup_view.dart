import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/consts/fonts.dart';
import 'package:flutter_application_1/consts/images.dart';
import 'package:flutter_application_1/consts/strings.dart';
import 'package:flutter_application_1/controllers/auth_controller.dart';
import 'package:flutter_application_1/res/components/custom_button.dart';
import 'package:flutter_application_1/res/components/custum_textfield.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authController = Get.put(AuthController());
  String userType = 'patient'; // Default selection

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      await _authController.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        fullName: _fullNameController.text.trim(),
        userType: userType,
      );
    }
  }

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
                key: _formKey,
                child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustumTextfield(
                      hint: AppStrings.fullname,
                      textController: _fullNameController,
                      validator: _authController.validateFullName
                    ),
                    10.heightBox,
                    CustumTextfield(
                      hint: AppStrings.email,
                      textController: _emailController,
                      validator: _authController.validateEmail
                    ),
                    10.heightBox,
                    CustumTextfield(
                      hint: AppStrings.password,
                      textController: _passwordController,
                      validator: _authController.validatePassword
                    ),
                    20.heightBox,
                    // User type selection
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppStyles.bold(title: "I am a: "),
                        Radio<String>(
                          value: 'patient',
                          groupValue: userType,
                          onChanged: (String? value) {
                            setState(() {
                              userType = value!;
                            });
                          },
                          activeColor: AppColors.blueColor,
                        ),
                        AppStyles.normal(title: "Patient"),
                        20.widthBox,
                        Radio<String>(
                          value: 'doctor',
                          groupValue: userType,
                          onChanged: (String? value) {
                            setState(() {
                              userType = value!;
                            });
                          },
                          activeColor: AppColors.blueColor,
                        ),
                        AppStyles.normal(title: "Doctor"),
                      ],
                    ),
                    20.heightBox,
                    Obx(() => _authController.isLoading.value
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            buttonText: AppStrings.signup,
                            onTap: _handleSignup,
                          )),
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
