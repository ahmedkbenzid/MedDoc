import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/fonts.dart';
import 'package:flutter_application_1/consts/images.dart';
import 'package:flutter_application_1/consts/strings.dart';
import 'package:flutter_application_1/controllers/auth_controller.dart';
import 'package:flutter_application_1/res/components/custom_button.dart';
import 'package:flutter_application_1/res/components/custum_textfield.dart';
import 'package:flutter_application_1/views/home_view/home.dart';
import 'package:flutter_application_1/views/home_view/doc_home.dart';
import 'package:flutter_application_1/views/signup_view/signup_view.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authController = Get.put(AuthController());
  String userType = 'patient'; // Default selection

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final result = await _authController.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (result != null && result['success']) {
        final userTypeFromDb = result['userType'];
        
        // Navigate based on user type from database
        if (userTypeFromDb == 'doctor') {
          Get.offAll(() => const DocHome());
        } else {
          Get.offAll(() => const Home());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  resizeToAvoidBottomInset: true,
  body: SafeArea(
    child: Column(
      children: [

        // 🔹 Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppStyles.bold(
                title: "MedDoc",
                color: AppColors.blueColor,
                size: AppSizes.size34,
              ),
              const Icon(Icons.menu),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // 🔹 Main content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [

                // Logo + welcome
                Image.asset(
                  AppAssets.imgLogin,
                  width: 200,
                ),
                10.heightBox,
                AppStyles.bold(
                  title: AppStrings.welcomeBack,
                  size: AppSizes.size18,
                ),
                AppStyles.bold(title: AppStrings.weAreExcited),

                30.heightBox,

                // 🔹 Form
                Form(
                  child: Column(
                    children: [
                      CustumTextfield(hint: AppStrings.email),
                      10.heightBox,
                      CustumTextfield(hint: AppStrings.password),
                      20.heightBox,

                      // User type
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppStyles.bold(title: "I am a: "),
                          Radio<String>(
                            value: 'patient',
                            groupValue: userType,
                            onChanged: (value) {
                              setState(() => userType = value!);
                            },
                            activeColor: AppColors.blueColor,
                          ),
                          AppStyles.normal(title: "Patient"),
                          20.widthBox,
                          Radio<String>(
                            value: 'doctor',
                            groupValue: userType,
                            onChanged: (value) {
                              setState(() => userType = value!);
                            },
                            activeColor: AppColors.blueColor,
                          ),
                          AppStyles.normal(title: "Doctor"),
                        ],
                      ),

                      10.heightBox,

                      Align(
                        alignment: Alignment.centerRight,
                        child: AppStyles.normal(
                          title: AppStrings.forgetPassword,
                        ),
                      ),

                      20.heightBox,

                      CustomButton(
                        buttonText: AppStrings.login,
                        onTap: () {
                          if (userType == 'doctor') {
                            Get.to(() => const DocHome());
                          } else {
                            Get.to(() => const Home());
                          }
                        },
                      ),

                      20.heightBox,

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppStyles.normal(
                            title: AppStrings.dontHaveAccount,
                          ),
                          8.widthBox,
                          GestureDetector(
                            onTap: () {
                              Get.to(() => SignupView());
                            },
                            child: AppStyles.bold(
                              title: AppStrings.signup,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

}
}
