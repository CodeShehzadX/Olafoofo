import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../controllers/auth/otp_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/custom_button.dart';

class OtpScreen extends GetView<OtpController> {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 70,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        color: AppColors.splashCircle,
        borderRadius: BorderRadius.circular(16),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      color: AppColors.splashCircle,
      border: Border.all(color: AppColors.info, width: 2),
      borderRadius: BorderRadius.circular(16),
    );

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
                  'OTP sent',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackText,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Enter the OTP sent to you',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textHint,
                  ),
                ),
                const SizedBox(height: 20),

                // OTP boxes
                Center(
                  child: Pinput(
                    length: OtpController.otpLength,
                    controller: controller.pinController,
                    focusNode: controller.pinFocusNode,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    mainAxisAlignment: MainAxisAlignment.center,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: defaultPinTheme,
                    separatorBuilder: (_) => const SizedBox(width: 14),
                    onChanged: controller.onOtpChanged,
                    onCompleted: controller.onOtpCompleted,
                  ),
                ),
                const SizedBox(height: 14),

                // Resend row with countdown
                Row(
                  children: [
                    const Text(
                      'Didn’t receive any code? ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackText,
                      ),
                    ),
                    Obx(
                      () => controller.canResend
                          ? GestureDetector(
                              onTap: controller.resendCode,
                              child: const Text(
                                'Resend',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.splashCircle,
                                ),
                              ),
                            )
                          : Text(
                              'Resend in ${controller.timerText}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.error,
                              ),
                            ),
                    ),
                  ],
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
