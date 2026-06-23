import 'package:get/get.dart';

import '../../routes/app_routes.dart';

/// Business logic for the Welcome screen (GetX, no setState).
class WelcomeController extends GetxController {
  /// Enter the main app, clearing the auth/onboarding stack.
  void onContinue() => Get.offAllNamed(AppRoutes.home);
}
