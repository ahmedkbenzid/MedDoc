import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Sign up with email verification
  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required String fullName,
    required String userType,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'user_type': userType,
        },
        emailRedirectTo: 'io.supabase.flutterapplication://login-callback/',
      );

      if (response.user != null) {
        return {
          'success': true,
          'message': 'Verification email sent! Please check your inbox.',
          'user': response.user,
        };
      } else {
        return {
          'success': false,
          'message': 'Signup failed. Please try again.',
        };
      }
    } on AuthException catch (e) {
      return {
        'success': false,
        'message': e.message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'An unexpected error occurred: $e',
      };
    }
  }

  // Sign in with email verification check
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        // Check if email is verified
        if (response.user!.emailConfirmedAt == null) {
          await _supabase.auth.signOut();
          return {
            'success': false,
            'message': 'Please verify your email before logging in.',
          };
        }

        return {
          'success': true,
          'message': 'Login successful',
          'user': response.user,
          'userType': response.user!.userMetadata?['user_type'] ?? 'patient',
        };
      } else {
        return {
          'success': false,
          'message': 'Login failed',
        };
      }
    } on AuthException catch (e) {
      return {
        'success': false,
        'message': e.message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'An unexpected error occurred: $e',
      };
    }
  }

  // Resend verification email
  Future<Map<String, dynamic>> resendVerificationEmail(String email) async {
    try {
      await _supabase.auth.resend(
        type: OtpType.signup,
        email: email,
      );
      return {
        'success': true,
        'message': 'Verification email resent!',
      };
    } on AuthException catch (e) {
      return {
        'success': false,
        'message': e.message,
      };
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  // Get current user
  User? getCurrentUser() {
    return _supabase.auth.currentUser;
  }

  // Check if user is logged in
  bool isLoggedIn() {
    return _supabase.auth.currentUser != null;
  }

  Future<Map<String, dynamic>> updatePassword(String newPassword) async {
  try {
    await _supabase.auth.updateUser(
      UserAttributes(password: newPassword),
    );
    
    return {
      'success':  true,
      'message': 'Password updated successfully',
    };
  } on AuthException catch (e) {
    return {
      'success': false,
      'message': e. message,
    };
  } catch (e) {
    return {
      'success': false,
      'message': 'An unexpected error occurred:  $e',
    };
  }
}

}

