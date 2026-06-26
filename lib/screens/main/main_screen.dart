import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/main/main_controller.dart';
import '../../utils/app_constants.dart';
import '../../widgets/custom_bottom_navbar.dart';
import '../chat/chat_screen.dart';
import '../home/home_screen.dart';
import '../lounge/lounge_screen.dart';
import '../post/create_post_screen.dart';
import '../profile/my_profile_screen.dart';

/// The main app shell: hosts the 5 tabs behind the bottom navigation bar.
///
/// Tab bodies are placeholders for now — each will be replaced by its real
/// screen (Home Feed, Ofofo, Create Post, Chats, Profile) in later steps.
class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConstants.lightSystemOverlay(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(
          () => IndexedStack(
            index: controller.currentIndex.value,
            children: const [
              HomeScreen(),
              LoungeScreen(),
              CreatePostScreen(),
              ChatScreen(),
              MyProfileScreen(),
            ],
          ),
        ),
        bottomNavigationBar: Obx(
          () => CustomBottomNavbar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeTab,
          ),
        ),
      ),
    );
  }
}
