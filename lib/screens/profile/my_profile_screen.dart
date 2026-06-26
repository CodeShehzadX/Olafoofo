import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/profile/my_profile_controller.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/profile_stat_item.dart';
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
          _appBar(),
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
                _stats(),
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

  Widget _appBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: controller.onBack,
            child: const SizedBox(
              width: 40,
              height: 40,
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: AppColors.blackText,
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'My Profile',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackText,
                ),
              ),
            ),
          ),
          const SizedBox(width: 40, height: 40),
        ],
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        _avatarWithBadge(),
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

  Widget _avatarWithBadge() {
    return SizedBox(
      width: 58,
      height: 58,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          UserAvatar(image: MyProfileController.avatar, size: 58),
          Positioned(
            right: -2,
            bottom: -2,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: controller.editProfilePicture,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.splashCircle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(
                  Icons.photo_camera,
                  size: 11,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stats() {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: ProfileStatItem(
              count: controller.postsCount,
              label: 'Posts',
            ),
          ),
          _divider(),
          Expanded(
            child: ProfileStatItem(
              count: controller.followingCount,
              label: 'Following',
            ),
          ),
          _divider(),
          Expanded(
            child: ProfileStatItem(
              count: controller.followersCount,
              label: 'Followers',
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(width: 1, color: AppColors.lightBorder);
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
