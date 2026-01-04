import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/consts/lists.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter_application_1/views/settings_view/change_password_view.dart';
import 'package:flutter_application_1/views/settings_view/terms_condition_view.dart';
import 'package:flutter_application_1/views/login_view/login_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final AuthService _authService = AuthService();
  User? currentUser;
  String userName = "Username";
  String userEmail = "user_email@gmail.com";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    currentUser = _authService.getCurrentUser();
    if (currentUser != null) {
      setState(() {
        userName = currentUser!.userMetadata? ['full_name'] ?? "Username";
        userEmail = currentUser!.email ?? "user_email@gmail.com";
      });
    }
  }

  void _handleSettingsTap(int index) async {
    switch (index) {
      case 0: // Change Password
        Get.to(() => const ChangePasswordView());
        break;
      case 1: // Terms & Conditions
        Get. to(() => const TermsConditionsView());
        break;
      case 2: // Sign Out
        Get. to(() => const LoginView());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.blueColor,
        title: AppStyles.bold(
          title: AppStrings.settings,
          size: AppSizes. size18,
          color: AppColors.whiteColor
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(child: Image.asset(AppAssets.imgSignup)),
              title: AppStyles. bold(title: userName),
              subtitle: AppStyles. normal(title: userEmail),
            ),
            const Divider(),
            20.heightBox,
            // Changed ListView to Column with List. generate
            ... List.generate(
              settingsList.length, 
              (index) => ListTile(
                onTap: () => _handleSettingsTap(index),
                leading: Icon(settingsListIcons[index], color: AppColors.blueColor),
                title: AppStyles. bold(title: settingsList[index]),
                trailing: Icon(
                  Icons.arrow_forward_ios, 
                  size: 16, 
                  color: AppColors.textColor. withOpacity(0.5)
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}