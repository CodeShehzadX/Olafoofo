import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/auth/forgot_password_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({super.key});

  // Light grey fill for all fields (matches the design).
  static const Color _fieldFill = AppColors.lightGray;

  @override
  Widget build(BuildContext context) {
    return AppConstants.lightSystemOverlay(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
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
                              'Forgot Password',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                                color: AppColors.blackText,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Let’s help recover your account',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textHint,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Username
                            _label('Username'),
                            CustomTextfield(
                              controller: controller.usernameController,
                              text: '',
                              textInputType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              validation: controller.validateUsername,
                              filledColor: _fieldFill,
                              borderRadius: 12,
                            ),
                            const SizedBox(height: 16),

                            // Email
                            _label('Email'),
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

                            // Phone Number
                            _label('Phone Number'),
                            CustomTextfield(
                              controller: controller.phoneController,
                              text: '',
                              textInputType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              inputFormatter: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validation: controller.validatePhone,
                              filledColor: _fieldFill,
                              borderRadius: 12,
                            ),
                            const SizedBox(height: 16),

                            // Last Remembered password
                            _label('Last Remembered password'),
                            CustomTextfield(
                              controller: controller.lastPasswordController,
                              text: '',
                              obsecureText: true,
                              showPasswordToggle: true,
                              textInputAction: TextInputAction.done,
                              filledColor: _fieldFill,
                              borderRadius: 12,
                            ),

                            const Spacer(),

                            // Done
                            CustomButton(
                              height: 56,
                              margin: 0,
                              borderRadius: 14,
                              title: 'Done',
                              titleFontSize: 16,
                              backgroundColor: AppColors.splashCircle,
                              textColor: Colors.white,
                              onTap: controller.onDone,
                            ),
                            const SizedBox(height: 20),

                            // Sign up
                            Center(
                              child: GestureDetector(
                                onTap: controller.onSignUp,
                                child: RichText(
                                  text: const TextSpan(
                                    text: 'Do not have an Account? ',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.blackText,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Sign up',
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
            },
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
}
