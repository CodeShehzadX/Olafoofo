import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/profile/my_profile_controller.dart';
import '../../utils/app_colors.dart';
import '../../widgets/back_title_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/profile_stats_row.dart';
import '../../widgets/user_avatar.dart';

/// My Profile tab — header, bio, edit button, stats and a 3-column posts grid.
///
/// Rendered inside the main shell, so it has no Scaffold/bottom-nav of its own.
class MyProfileScreen extends GetView<MyProfileController> {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          BackTitleAppBar(title: 'My Profile', onBack: controller.onBack),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              children: [
                _header(),
                const SizedBox(height: 14),
                Obx(
                  () => Text(
                    controller.about.value,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: AppColors.blackText,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                CustomButton(
                  height: 50,
                  margin: 0,
                  borderRadius: 12,
                  title: 'Edit Profile',
                  titleFontSize: 16,
                  fontWeight: FontWeight.w700,
                  backgroundColor: AppColors.splashCircle,
                  textColor: Colors.white,
                  onTap: controller.openEditProfile,
                ),
                const SizedBox(height: 18),
                ProfileStatsRow(
                  postsCount: controller.postsCount,
                  followingCount: controller.followingCount,
                  followersCount: controller.followersCount,
                ),
                const SizedBox(height: 22),
                const Text(
                  'Posts',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackText,
                  ),
                ),
                const SizedBox(height: 12),
                _postsGrid(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        UserAvatar(image: MyProfileController.avatar, size: 58),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Text(
                  controller.name.value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackText,
                  ),
                ),
              ),
              const SizedBox(height: 3),
              Obx(
                () => Text(
                  controller.region.value,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textHint,
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: controller.openSettings,
          child: const Icon(
            Icons.settings_outlined,
            size: 26,
            color: AppColors.blackText,
          ),
        ),
      ],
    );
  }

  Widget _postsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.posts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(controller.posts[index], fit: BoxFit.cover),
        );
      },
    );
  }
}
