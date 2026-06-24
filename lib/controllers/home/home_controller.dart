import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';

/// A story shown in the horizontal stories row.
class StoryItem {
  const StoryItem({
    required this.name,
    this.image,
    this.avatar,
    this.isLive = false,
    this.isAdd = false,
  });

  final String name;

  /// Large background image asset.
  final String? image;

  /// Small author avatar asset.
  final String? avatar;
  final bool isLive;
  final bool isAdd;
}

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

  /// Exactly 5 story items (1 add-story + 4 stories).
  final List<StoryItem> stories = const [
    StoryItem(name: 'Abdul', isAdd: true),
    StoryItem(
      name: 'Chris',
      image: 'assets/images/1stStory_chris.png',
      avatar: 'assets/images/1stStory_user_image.png',
      isLive: true,
    ),
    StoryItem(
      name: 'General',
      image: 'assets/images/2ndStory_general.png',
      avatar: 'assets/images/2ndStory_user_image.png',
    ),
    StoryItem(
      name: 'Ojogbon',
      image: 'assets/images/3rdStory_ojogbon.png',
      avatar: 'assets/images/3rdStory_user_image.png',
    ),
    StoryItem(
      name: 'John',
      image: 'assets/images/4thStory_john.png',
      // Reuses the first story's user image, per spec.
      avatar: 'assets/images/1stStory_user_image.png',
    ),
  ];

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
    // TODO: navigate to the Notifications screen once its route exists.
  }

  /// Open a story viewer for the story at [index].
  void openStory(int index) {
    // TODO: navigate to the Story / Live viewer once its route exists.
  }

  /// Open a user's profile.
  void openProfile(PostModel post) {
    // Route constant exists; the profile page is registered in a later step.
    Get.toNamed(AppRoutes.profile);
  }

  /// Open the comments screen for [post].
  void openComments(PostModel post) {
    // TODO: navigate to the Comments screen once its route exists.
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
