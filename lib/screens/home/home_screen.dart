import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/home/home_controller.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_search_bar.dart';
import '../../widgets/post_card.dart';
import '../../widgets/story_list.dart';

/// The Home Feed tab: search + notifications, stories row, and post list.
///
/// Rendered inside the main shell, so it has no Scaffold/bottom-nav of its own.
class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          // Search bar + notification icon
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Row(
              children: [
                Expanded(
                  child: CustomSearchBar(controller: controller.searchController),
                ),
                const SizedBox(width: 14),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: controller.openNotifications,
                  child: SvgPicture.asset(
                    'assets/icons/notification_icon.svg',
                    height: 26,
                    colorFilter: const ColorFilter.mode(
                      AppColors.splashCircle,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Feed
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 16),
              children: [
                Obx(
                  () => StoryList(
                    stories: controller.stories.toList(),
                    onStoryTap: controller.openStory,
                    onAddTap: controller.openAddStory,
                  ),
                ),
                const SizedBox(height: 8),
                Obx(
                  () => Column(
                    children: [
                      for (final post in controller.posts)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: PostCard(
                            post: post,
                            onProfileTap: () => controller.openProfile(post),
                            onLikeTap: () => controller.toggleLike(post),
                            onCommentTap: () => controller.openComments(post),
                            onViewComments: () => controller.openComments(post),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
