import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../../utils/validators.dart';

/// Business logic + state for the Username screen.
///
/// Holds the field controllers and validation (GetX, no setState).
class UsernameController extends GetxController {
  /// Validates the form on Done.
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // ---- Validation -----------------------------------------------------------

  String? validateUsername(String? value) => Validators.username(value);

  String? validatePassword(String? value) => Validators.password(value);

  String? validateConfirmPassword(String? value) =>
      Validators.confirmPassword(value, passwordController.text);

  // ---- Navigation -----------------------------------------------------------

  /// Validate, then continue to the Welcome screen.
  void onDone() {
    if (!(formKey.currentState?.validate() ?? false)) return;
    Get.toNamed(AppRoutes.welcome);
  }

  /// Existing user wants to sign in.
  void onSignIn() => Get.toNamed(AppRoutes.login);

  /// Pop back to the previous screen.
  void onBack() => Get.back();

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
