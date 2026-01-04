import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/res/components/custom_button.dart';
import 'package:flutter_application_1/res/components/custum_textfield.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:get/get.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _oldPasswordController. dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateOldPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your old password';
    }
    return null;
  }

  String? _validateNewPassword(String?  value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a new password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    if (value == _oldPasswordController.text) {
      return 'New password must be different from old password';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your new password';
    }
    if (value != _newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> _handleChangePassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        // First, verify the old password by attempting to sign in
        final currentUser = _authService.getCurrentUser();
        if (currentUser == null || currentUser.email == null) {
          throw Exception('No user logged in');
        }

        // Try to sign in with old password to verify it
        final signInResult = await _authService. signIn(
          email: currentUser. email!,
          password: _oldPasswordController.text,
        );

        if (signInResult['success'] != true) {
          Get.snackbar(
            'Error',
            'Old password is incorrect',
            backgroundColor:  Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
          setState(() => _isLoading = false);
          return;
        }

        // Update password in Supabase
        final result = await _authService.updatePassword(_newPasswordController.text);

        setState(() => _isLoading = false);

        if (result['success']) {
          Get.snackbar(
            'Success',
            'Password changed successfully',
            backgroundColor: Colors. green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
          Get.back(); // Go back to settings
        } else {
          Get.snackbar(
            'Error',
            result['message'] ?? 'Failed to change password',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition. BOTTOM,
          );
        }
      } catch (e) {
        setState(() => _isLoading = false);
        Get.snackbar(
          'Error',
          'An error occurred:  $e',
          backgroundColor: Colors. red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        title: AppStyles.bold(
          title: AppStrings.changepwd,
          size: AppSizes.size18,
          color: AppColors.whiteColor,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.heightBox,
              AppStyles.bold(
                title: "Change Your Password",
                size: AppSizes.size20,
                color: AppColors. textColor,
              ),
              10.heightBox,
              AppStyles.normal(
                title: "Enter your old password and choose a new one",
                color: AppColors.textColor. withOpacity(0.6),
              ),
              30.heightBox,
              AppStyles.bold(title: "Old Password"),
              8.heightBox,
              CustumTextfield(
                hint: "Enter old password",
                textController: _oldPasswordController,
                obscureText: true,
                validator: _validateOldPassword,
              ),
              20.heightBox,
              AppStyles.bold(title: "New Password"),
              8.heightBox,
              CustumTextfield(
                hint: "Enter new password",
                textController: _newPasswordController,
                obscureText: true,
                validator: _validateNewPassword,
              ),
              20.heightBox,
              AppStyles.bold(title: "Confirm New Password"),
              8.heightBox,
              CustumTextfield(
                hint: "Confirm new password",
                textController: _confirmPasswordController,
                obscureText: true,
                validator:  _validateConfirmPassword,
              ),
              40.heightBox,
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                      buttonText: "Change Password",
                      onTap: _handleChangePassword,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}