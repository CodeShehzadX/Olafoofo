import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../../utils/validators.dart';

/// Business logic + state for the phone signup screen.
///
/// All state lives here (GetX, no setState): the selected dial code and the
/// phone number field, plus validation. The country list itself comes from the
/// `country_code_picker` package — it is never hardcoded here.
class PhoneController extends GetxController {
  /// Validates the phone number field.
  final formKey = GlobalKey<FormState>();

  /// Phone number input (digits only).
  final TextEditingController phoneController = TextEditingController();

  /// Selected country dial code — defaults to Nigeria (+234) to match Figma.
  final RxString dialCode = '+234'.obs;

  /// Called by the picker whenever the user selects a different country.
  void onCountryChanged(CountryCode code) {
    final selected = code.dialCode;
    if (selected != null && selected.isNotEmpty) {
      dialCode.value = selected;
    }
  }

  /// Phone number validation (delegates to the shared [Validators]).
  String? validatePhone(String? value) => Validators.phone(value);

  /// Validate, then proceed to OTP verification.
  void onNext() {
    if (!(formKey.currentState?.validate() ?? false)) return;

    // The full E.164-style number to verify, e.g. "+2348025557595".
    // ignore: unused_local_variable
    final phoneNumber = '${dialCode.value}${phoneController.text.trim()}';

    // Reuse the shared OTP screen; tell it this is the signup flow.
    Get.toNamed(AppRoutes.otp, arguments: {'flow': 'signup'});
  }

  /// Existing user wants to sign in.
  void onSignIn() => Get.toNamed(AppRoutes.login);

  /// Pop back to the previous screen.
  void onBack() => Get.back();

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}
