import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../routes/app_routes.dart';
import '../../utils/app_colors.dart';
import '../../utils/validators.dart';

/// Business logic + state for the Personal Information screen.
///
/// Holds all field controllers and validation (GetX, no setState).
class PersonalInfoController extends GetxController {
  /// Validates the form on Next.
  final formKey = GlobalKey<FormState>();

  // Field controllers
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();
  final genderController = TextEditingController();
  final aboutController = TextEditingController();

  /// The picked date of birth (backing value for [dobController]).
  DateTime? selectedDob;

  /// Gender options shown in the bottom sheet.
  final List<String> genders = const ['Male', 'Female', 'Other'];

  // ---- Validation -----------------------------------------------------------

  String? validateFullName(String? value) =>
      Validators.required(value, fieldName: 'Full name');

  String? validateEmail(String? value) => Validators.email(value);

  String? validateDob(String? value) =>
      Validators.required(value, fieldName: 'Date of birth');

  String? validateGender(String? value) =>
      Validators.required(value, fieldName: 'Gender');

  // ---- Pickers --------------------------------------------------------------

  /// Open a date picker for the date of birth.
  Future<void> pickDate() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDob ?? DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      selectedDob = picked;
      dobController.text = DateFormat('dd MMM yyyy').format(picked);
    }
  }

  /// Open a bottom sheet to choose a gender.
  void pickGender() {
    FocusManager.instance.primaryFocus?.unfocus();
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: genders
                .map(
                  (gender) => ListTile(
                    title: Text(
                      gender,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.blackText,
                      ),
                    ),
                    onTap: () {
                      genderController.text = gender;
                      Get.back();
                    },
                  ),
                )
                .toList(),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  // ---- Navigation -----------------------------------------------------------

  /// Validate, then continue to the Username screen.
  void onNext() {
    if (!(formKey.currentState?.validate() ?? false)) return;

    // TODO: Navigate to the Username screen once its route exists, e.g.
     Get.toNamed(AppRoutes.usernameSetup);
  }

  /// Existing user wants to sign in.
  void onSignIn() => Get.toNamed(AppRoutes.login);

  /// Pop back to the previous screen.
  void onBack() => Get.back();

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    dobController.dispose();
    genderController.dispose();
    aboutController.dispose();
    super.onClose();
  }
}
