import 'package:base_project/controllers/auth/forgot_password_controller.dart';
import 'package:base_project/controllers/auth/otp_controller.dart';
import 'package:base_project/controllers/auth/personal_info_controller.dart';
import 'package:base_project/controllers/auth/signin_controller.dart';
import 'package:base_project/controllers/auth/username_controller.dart';
import 'package:base_project/controllers/auth/welcome_controller.dart';
import 'package:base_project/screens/auth/forgot_password_screen.dart';
import 'package:base_project/screens/auth/otp_screen.dart';
import 'package:base_project/screens/auth/personal_info_screen.dart';
import 'package:base_project/screens/auth/signin_screen.dart';
import 'package:base_project/screens/auth/username_screen.dart';
import 'package:base_project/screens/auth/welcome_screen.dart';
import 'package:get/get.dart';
import 'app_routes.dart';
import '../screens/splash_screen.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../controllers/onboarding/onboarding_controller.dart';
import '../screens/auth/phone_screen.dart';
import '../controllers/auth/phone_controller.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OnboardingController>(() => OnboardingController());
      }),
    ),
    GetPage(
      name: AppRoutes.phone,
      page: () => const PhoneScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<PhoneController>(() => PhoneController());
      }),
      transition: Transition.cupertino,
    ),
GetPage(
      name: AppRoutes.otp,
      page: () => const OtpScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OtpController>(() => OtpController());
      }),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.personalInformation,
      page: () => const PersonalInfoScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<PersonalInfoController>(() => PersonalInfoController());
      }),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.usernameSetup,
      page: () => const UsernameScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<UsernameController>(() => UsernameController());
      }),
      transition: Transition.cupertino,
    ),
     GetPage(
      name: AppRoutes.welcome,
      page: () => const WelcomeScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<WelcomeController>(() => WelcomeController());
      }),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const SigninScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SigninController>(() => SigninController());
      }),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
      }),
      transition: Transition.cupertino,
    ),
    // Add more routes here as you build your app
  ];
}
