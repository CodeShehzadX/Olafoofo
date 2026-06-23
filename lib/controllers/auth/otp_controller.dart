import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../../widgets/custom_snackbar.dart';

/// Business logic + state for the OTP verification screen.
///
/// Owns the Pinput controller/focus node, the entered OTP value, and the
/// resend countdown timer (GetX only, no setState).
class OtpController extends GetxController {
  /// Number of digits in the OTP.
  static const int otpLength = 4;

  /// Total seconds before the user may request a new code.
  static const int resendSeconds = 60;

  /// Backs the Pinput field.
  final TextEditingController pinController = TextEditingController();
  final FocusNode pinFocusNode = FocusNode();

  /// The OTP value currently entered (reactive).
  final RxString otp = ''.obs;

  /// Seconds left on the resend countdown.
  final RxInt secondsRemaining = resendSeconds.obs;

  Timer? _timer;

  /// Which flow opened this screen: 'signup' (default) or 'forgotPassword'.
  /// Read from the route arguments so the single OTP screen can be reused.
  String flow = 'signup';

  /// Whether the resend countdown has finished.
  bool get canResend => secondsRemaining.value == 0;

  /// Countdown formatted as mm:ss (e.g. "01:00").
  String get timerText {
    final minutes = (secondsRemaining.value ~/ 60).toString().padLeft(2, '0');
    final seconds = (secondsRemaining.value % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map && args['flow'] is String) {
      flow = args['flow'] as String;
    }
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    secondsRemaining.value = resendSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value <= 1) {
        secondsRemaining.value = 0;
        timer.cancel();
      } else {
        secondsRemaining.value--;
      }
    });
  }

  /// Keep [otp] in sync with the field.
  void onOtpChanged(String value) => otp.value = value;
  void onOtpCompleted(String value) => otp.value = value;

  /// Request a new code once the countdown has elapsed.
  void resendCode() {
    if (!canResend) return;
    // TODO: trigger the resend-OTP API call here.
    _startTimer();
  }

  /// Validate the OTP, then continue to the next step.
  void onNext() {
    final code = otp.value;
    if (code.length != otpLength || int.tryParse(code) == null) {
      CustomSnackbar.error(
        title: 'Invalid OTP',
        message: 'Please enter the $otpLength-digit code',
      );
      return;
    }

    // Route to the next step based on the flow that opened this screen.
    if (flow == 'forgotPassword') {
      Get.toNamed(AppRoutes.newPassword); 
    } else {
      Get.toNamed(AppRoutes.personalInformation);
    }
  }

  /// Existing user wants to sign in.
  void onSignIn() => Get.toNamed(AppRoutes.login);

  /// Pop back to the previous screen.
  void onBack() => Get.back();

  @override
  void onClose() {
    _timer?.cancel();
    pinController.dispose();
    pinFocusNode.dispose();
    super.onClose();
  }
}
