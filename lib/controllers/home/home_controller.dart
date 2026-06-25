import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/story_models.dart';
import '../../routes/app_routes.dart';

/// A feed post. [isLiked] and [likeCount] are reactive so likes update live.
class PostModel {
  PostModel({
    required this.userImage,
    required this.userName,
    required this.time,
    required this.caption,
    required this.postImage,
    required this.likedAvatars,
    required this.likedByName,
    required this.commentCount,
    bool isLiked = false,
    required int likeCount,
  })  : isLiked = isLiked.obs,
        likeCount = likeCount.obs;

  final String userImage;
  final String userName;
  final String time;
  final String caption;
  final String postImage;
  final List<String> likedAvatars;
  final String likedByName;
  final int commentCount;

  final RxBool isLiked;
  final RxInt likeCount;
}

/// Business logic for the Home Feed (GetX only, no setState).
class HomeController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  /// Story groups (reactive) — one item per user. The first group is the
  /// current user (starts with no media → shows the Add Story card).
  final RxList<StoryGroup> stories = <StoryGroup>[
    StoryGroup(
      username: 'Your Story',
      avatar: 'assets/images/1stStory_user_image.png',
      isCurrentUser: true,
      media: [],
    ),
    StoryGroup(
      username: 'Chris',
      avatar: 'assets/images/1stStory_user_image.png',
      isLive: true,
      watching: 129000,
      media: [const StoryMedia('assets/images/1stStory_chris.png')],
    ),
    StoryGroup(
      username: 'General',
      avatar: 'assets/images/2ndStory_user_image.png',
      media: [const StoryMedia('assets/images/2ndStory_general.png')],
    ),
    StoryGroup(
      username: 'Ojogbon',
      avatar: 'assets/images/3rdStory_user_image.png',
      media: [const StoryMedia('assets/images/3rdStory_ojogbon.png')],
    ),
    StoryGroup(
      username: 'John',
      avatar: 'assets/images/1stStory_user_image.png',
      media: [const StoryMedia('assets/images/4thStory_john.png')],
    ),
  ].obs;

  /// The current user's story group (always the first item).
  StoryGroup get currentUserStory => stories.first;

  /// Append a newly captured/selected image to the current user's story group
  /// (does NOT create a new row). [imagePath] is a file or asset path.
  void addStoryMedia(String imagePath) {
    currentUserStory.media.add(StoryMedia(imagePath));
    stories.refresh();
  }

  /// Open the Add to Story screen.
  void openAddStory() => Get.toNamed(AppRoutes.addStory);

  /// Dummy feed posts.
  final List<PostModel> posts = [
    PostModel(
      userImage: 'assets/images/1stpost_user_image.png',
      userName: 'Oyin Dolapo',
      time: '1hr ago',
      caption:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra',
      postImage: 'assets/images/1st_post_image.png',
      likedAvatars: const [
        'assets/images/like_user_image_1.png',
        'assets/images/like_user_image_2.png',
        'assets/images/like_user_image_3.png',
      ],
      likedByName: 'Blazinshado',
      likeCount: 247,
      commentCount: 57,
    ),
    PostModel(
      userImage: 'assets/images/2ndpost_user_image.png',
      userName: 'Abdul Quayyum',
      time: '1hr ago',
      caption:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra',
      postImage: 'assets/images/2nd_post_image.png',
      likedAvatars: const [
        'assets/images/like_user_image_1.png',
        'assets/images/like_user_image_2.png',
        'assets/images/like_user_image_3.png',
      ],
      likedByName: 'Blazinshado',
      likeCount: 312,
      commentCount: 24,
    ),
  ];

  /// Toggle the like state of [post].
  void toggleLike(PostModel post) {
    if (post.isLiked.value) {
      post.isLiked.value = false;
      post.likeCount.value -= 1;
    } else {
      post.isLiked.value = true;
      post.likeCount.value += 1;
    }
  }

  /// Open the notifications screen.
  void openNotifications() {
    Get.toNamed(AppRoutes.notifications);
  }

  /// Open the story viewer for the group at [index].
  void openStory(int index) {
    final group = stories[index];
    // A current-user group with no media opens Add Story instead.
    if (!group.hasMedia) {
      openAddStory();
      return;
    }
    Get.toNamed(
      AppRoutes.storyViewer,
      arguments: StoryViewerArgs(group: group),
    );
  }

  /// Open a user's profile.
  void openProfile(PostModel post) {
    // Route constant exists; the profile page is registered in a later step.
    Get.toNamed(AppRoutes.profile);
  }

  /// Open the comments screen for [post], passing it through navigation.
  void openComments(PostModel post) {
    Get.toNamed(AppRoutes.comments, arguments: post);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
