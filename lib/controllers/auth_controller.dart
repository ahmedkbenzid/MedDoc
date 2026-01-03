import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  final isLoading = false.obs;

  // Validate email
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!EmailValidator.validate(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Validate password
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Validate full name
  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  // Sign up method
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    required String userType,
  }) async {
    isLoading.value = true;
    
    final result = await _authService.signUp(
      email: email,
      password: password,
      fullName: fullName,
      userType: userType,
    );

    isLoading.value = false;

    if (result['success']) {
      Get.snackbar(
        'Success',
        result['message'],
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 4),
      );
      Get.back(); // Navigate back to login
    } else {
      Get.snackbar(
        'Error',
        result['message'],
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Sign in method
  Future<Map<String, dynamic>?> signIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    
    final result = await _authService.signIn(
      email: email,
      password: password,
    );

    isLoading.value = false;

    if (result['success']) {
      return result;
    } else {
      Get.snackbar(
        'Login Failed',
        result['message'],
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  // Resend verification email
  Future<void> resendVerificationEmail(String email) async {
    final result = await _authService.resendVerificationEmail(email);
    
    Get.snackbar(
      result['success'] ? 'Success' : 'Error',
      result['message'],
      backgroundColor: result['success'] ? Colors.green : Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
