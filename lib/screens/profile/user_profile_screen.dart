import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/profile/user_profile_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/back_title_app_bar.dart';
import '../../widgets/profile_stats_row.dart';
import '../../widgets/user_avatar.dart';

/// Another user's Profile — header, bio + Follow/Message, stats, followers row
/// and a 3-column posts grid. Opened from the Home Feed.
class UserProfileScreen extends GetView<UserProfileController> {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConstants.lightSystemOverlay(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              BackTitleAppBar(title: 'Profile', onBack: controller.onBack),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  children: [
                    _header(),
                    const SizedBox(height: 14),
                    _bioAndActions(),
                    const SizedBox(height: 18),
                    ProfileStatsRow(
                      postsCount: controller.postsCount,
                      followingCount: controller.followingCount,
                      followersCount: controller.followersCount,
                    ),
                    const SizedBox(height: 18),
                    _sectionDivider(),
                    const SizedBox(height: 18),
                    _sectionTitle('Followers'),
                    const SizedBox(height: 12),
                    _followersRow(),
                    const SizedBox(height: 18),
                    _sectionDivider(),
                    const SizedBox(height: 18),
                    _sectionTitle('Posts'),
                    const SizedBox(height: 12),
                    _postsGrid(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        UserAvatar(image: controller.userAvatar, size: 58),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.userName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackText,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                controller.location,
                style: const TextStyle(fontSize: 13, color: AppColors.textHint),
              ),
            ],
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: controller.openMenu,
          child: SvgPicture.asset(
            'assets/icons/3_dot.svg',
            height: 22,
            colorFilter: const ColorFilter.mode(
              AppColors.blackText,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }

  Widget _bioAndActions() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            controller.bio,
            style: const TextStyle(
              fontSize: 14,
              height: 1.4,
              color: AppColors.blackText,
            ),
          ),
        ),
        const SizedBox(width: 12),
        _messageButton(),
        const SizedBox(width: 10),
        _followButton(),
      ],
    );
  }

  Widget _messageButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: controller.openMessage,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.splashCircle, width: 1.5),
        ),
        child: Center(
          child: SvgPicture.asset(
            'assets/icons/Chat.svg',
            height: 18,
            colorFilter: const ColorFilter.mode(
              AppColors.splashCircle,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }

  Widget _followButton() {
    return Obx(() {
      final following = controller.isFollowing.value;
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: controller.toggleFollow,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
          decoration: BoxDecoration(
            color: following ? Colors.white : AppColors.splashCircle,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppColors.splashCircle, width: 1.5),
          ),
          child: Text(
            following ? 'Following' : 'Follow',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: following ? AppColors.splashCircle : Colors.white,
            ),
          ),
        ),
      );
    });
  }

  /// Thin full-width line above the Followers and Posts sections (Figma).
  Widget _sectionDivider() {
    return Container(height: 1, color: AppColors.lightBorder);
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: AppColors.blackText,
      ),
    );
  }

  Widget _followersRow() {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: controller.followers.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final follower = controller.followers[index];
          return SizedBox(
            width: 66,
            child: Column(
              children: [
                UserAvatar(image: follower.avatar, size: 62),
                const SizedBox(height: 6),
                Text(
                  follower.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.blackText,
                  ),
                ),
              ],
            ),
          );
        },
      ),
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
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => controller.openPost(index),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(controller.posts[index], fit: BoxFit.cover),
          ),
        );
      },
    );
  }
}
