import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../../utils/validators.dart';

/// Business logic + state for the New Password screen (GetX, no setState).
class NewPasswordController extends GetxController {
  /// Validates the form on Done.
  final formKey = GlobalKey<FormState>();

  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // ---- Validation -----------------------------------------------------------

  /// New password — required + minimum length (via [Validators.password]).
  String? validateNewPassword(String? value) => Validators.password(value);

  /// Confirm password — required + must match [newPasswordController].
  String? validateConfirmPassword(String? value) =>
      Validators.confirmPassword(value, newPasswordController.text);

  // ---- Navigation -----------------------------------------------------------

  /// Validate, then continue to the Welcome Back screen.
  void onDone() {
    if (!(formKey.currentState?.validate() ?? false)) return;

    // TODO: Persist the new password via the API before navigating.
    Get.toNamed(AppRoutes.welcome);
  }

  /// New user wants to create an account.
  void onSignUp() => Get.toNamed(AppRoutes.signup);

  /// Pop back to the previous screen.
  void onBack() => Get.back();

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
