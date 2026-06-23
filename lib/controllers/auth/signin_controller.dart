import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';

/// Business logic + state for the Sign In screen (GetX, no setState).
class SigninController extends GetxController {
  /// Validates the form on Done.
  final formKey = GlobalKey<FormState>();

  /// Login identifier — accepts a username, email, or phone.
  final identifierController = TextEditingController();
  final passwordController = TextEditingController();

  // ---- Validation -----------------------------------------------------------

  String? validateIdentifier(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  // ---- Navigation -----------------------------------------------------------

  /// Validate credentials, then enter the app.
  void onDone() {
    if (!(formKey.currentState?.validate() ?? false)) return;

    // TODO: Call the sign-in API here before navigating.
    Get.offAllNamed(AppRoutes.home);
  }

  /// Go to the forgot-password flow.
  void onForgotPassword() => Get.toNamed(AppRoutes.forgotPassword);

  /// New user wants to create an account.
  void onSignUp() => Get.toNamed(AppRoutes.signup);

  /// Pop back to the previous screen.
  void onBack() => Get.back();

  @override
  void onClose() {
    identifierController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
