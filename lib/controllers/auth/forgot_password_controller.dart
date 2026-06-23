import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../../utils/validators.dart';

/// Business logic + state for the Forgot Password screen (GetX, no setState).
class ForgotPasswordController extends GetxController {
  /// Validates the form on Done.
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final lastPasswordController = TextEditingController();

  // ---- Validation -----------------------------------------------------------

  String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  String? validateEmail(String? value) => Validators.email(value);

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 7 || digits.length > 15) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  // ---- Navigation -----------------------------------------------------------

  /// Validate, then continue to OTP verification.
  void onDone() {
    if (!(formKey.currentState?.validate() ?? false)) return;

    // TODO: Trigger the recovery / send-OTP request here.
    // Reuse the shared OTP screen; tell it this is the forgot-password flow.
    Get.toNamed(AppRoutes.otp, arguments: {'flow': 'forgotPassword'});
  }

  /// New user wants to create an account.
  void onSignUp() => Get.toNamed(AppRoutes.signup);

  /// Pop back to the previous screen.
  void onBack() => Get.back();

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    lastPasswordController.dispose();
    super.onClose();
  }
}
