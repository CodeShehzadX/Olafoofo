import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/main/main_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/custom_bottom_navbar.dart';
import '../home/home_screen.dart';
import '../lounge/lounge_screen.dart';
import '../post/create_post_screen.dart';

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
              _TabPlaceholder(title: 'Chats'),
              _TabPlaceholder(title: 'Profile'),
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

/// Temporary placeholder body for a tab.
class _TabPlaceholder extends StatelessWidget {
  const _TabPlaceholder({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.blackText,
        ),
      ),
    );
  }
}
