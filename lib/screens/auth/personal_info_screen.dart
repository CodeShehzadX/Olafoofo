import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth/personal_info_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class PersonalInfoScreen extends GetView<PersonalInfoController> {
  const PersonalInfoScreen({super.key});

  // Light grey fill for all fields (matches the design).
  static const Color _fieldFill = AppColors.lightGray;

  @override
  Widget build(BuildContext context) {
    return AppConstants.lightSystemOverlay(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: controller.onBack,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 20,
                        color: AppColors.blackText,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Title + subtitle
                  const Text(
                    'Personal Information',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Please fill the following',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textHint,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Full name
                  _label('Full name'),
                  CustomTextfield(
                    controller: controller.fullNameController,
                    text: '',
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validation: controller.validateFullName,
                    filledColor: _fieldFill,
                    borderRadius: 12,
                  ),
                  const SizedBox(height: 16),

                  // Email Address
                  _label('Email Address'),
                  CustomTextfield(
                    controller: controller.emailController,
                    text: '',
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validation: controller.validateEmail,
                    filledColor: _fieldFill,
                    borderRadius: 12,
                  ),
                  const SizedBox(height: 16),

                  // Date of birth + Gender (side by side)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _label('Date of birth'),
                            _pickerField(
                              controller.dobController,
                              controller.validateDob,
                              controller.pickDate,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _label('Gender'),
                            _pickerField(
                              controller.genderController,
                              controller.validateGender,
                              controller.pickGender,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // About
                  _label('About'),
                  CustomTextfield(
                    controller: controller.aboutController,
                    text: '',
                    maxLines: 5,
                    textInputType: TextInputType.multiline,
                    filledColor: _fieldFill,
                    borderRadius: 12,
                  ),
                  const SizedBox(height: 28),

                  // Next
                  CustomButton(
                    height: 56,
                    margin: 0,
                    borderRadius: 14,
                    title: 'Next',
                    titleFontSize: 16,
                    backgroundColor: AppColors.splashCircle,
                    textColor: Colors.white,
                    onTap: controller.onNext,
                  ),
                  const SizedBox(height: 20),

                  // Sign in
                  Center(
                    child: GestureDetector(
                      onTap: controller.onSignIn,
                      child: RichText(
                        text: const TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackText,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign In',
                              style: TextStyle(
                                color: AppColors.splashCircle,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Field label shown above each input.
  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.blackText,
          ),
        ),
      );

  /// A read-only field that opens a picker on tap, with a trailing caret.
  Widget _pickerField(
    TextEditingController fieldController,
    String? Function(String?) validator,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            CustomTextfield(
              controller: fieldController,
              text: '',
              readOnly: true,
              validation: validator,
              filledColor: _fieldFill,
              borderRadius: 12,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 14),
              child: Icon(
                Icons.arrow_drop_down,
                size: 24,
                color: AppColors.blackText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
