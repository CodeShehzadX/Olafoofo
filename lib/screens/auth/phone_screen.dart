import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/auth/phone_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class PhoneScreen extends GetView<PhoneController> {
  const PhoneScreen({super.key});

  // Light teal border for the phone field (matches the design).
  static const Color _fieldBorder = Color(0xFF9EC2C9);

  @override
  Widget build(BuildContext context) {
    return AppConstants.lightSystemOverlay(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
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
                  'Phone',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackText,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Enter your phone number',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textHint,
                  ),
                ),
                const SizedBox(height: 20),

                // Phone field with world country-code picker as prefix
                Form(
                  key: controller.formKey,
                  child: CustomTextfield(
                    controller: controller.phoneController,
                    text: '8025557595',
                    textInputType: TextInputType.phone,
                    validation: controller.validatePhone,
                    filledColor: Colors.white,
                    borderColor: _fieldBorder,
                    borderRadius: 12,
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    prefix: CountryCodePicker(
                      onChanged: controller.onCountryChanged,
                      initialSelection: 'NG',
                      favorite: const ['+234', 'NG'],
                      showFlag: true,
                      showFlagMain: true,
                      alignLeft: false,
                      flagWidth: 26,
                      padding: const EdgeInsets.only(left: 8),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackText,
                      ),
                      dialogTextStyle: const TextStyle(
                        color: AppColors.blackText,
                      ),
                      searchStyle: const TextStyle(
                        color: AppColors.blackText,
                      ),
                    ),
                  ),
                ),

                const Spacer(),

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
    );
  }
}
