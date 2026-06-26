import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../chat/chat_controller.dart';
import '../home/home_controller.dart';

/// A follower shown in the horizontal followers row.
class ProfileFollower {
  const ProfileFollower({required this.name, required this.avatar});

  final String name;
  final String avatar;
}

/// Business logic for another user's Profile (GetX only, no setState).
///
/// Opened from the Home Feed (profile image / username tap); the tapped user's
/// data arrives as the [PostModel] in [Get.arguments]. Reuses [PostModel] for
/// the Comments flow and [ChatItem] for the Chat Detail flow. Dummy/local data.
class UserProfileController extends GetxController {
  late final String userName;
  late final String userAvatar;

  final String location = 'Abeokuta, Ogun';
  final String bio =
      "I'm a postive person. I love to travel and eat Always available for chat";

  final String postsCount = '87';
  final String followingCount = '870';
  final String followersCount = '15k';

  /// Follow ↔ Following (local).
  final RxBool isFollowing = false.obs;

  final List<ProfileFollower> followers = const [
    ProfileFollower(name: 'Elijah', avatar: 'assets/images/follower_1.png'),
    ProfileFollower(name: 'Abdul', avatar: 'assets/images/follower_2.png'),
    ProfileFollower(name: 'Qudus', avatar: 'assets/images/follower_3.png'),
    ProfileFollower(name: 'Joe', avatar: 'assets/images/follower_4.png'),
    ProfileFollower(name: 'Ojogbon', avatar: 'assets/images/follower_5.png'),
  ];

  final List<String> posts = List.generate(
    9,
    (i) => 'assets/images/other_profile_post_${i + 1}.png',
  );

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg is PostModel) {
      userName = arg.userName;
      userAvatar = arg.userImage;
    } else {
      // Fallback if opened without a user (shouldn't normally happen).
      userName = 'Abdul Qudus';
      userAvatar = 'assets/images/user_profile_image.png';
    }
  }

  void toggleFollow() => isFollowing.toggle();

  /// Open the existing Chat Detail screen for this user.
  void openMessage() {
    Get.toNamed(
      AppRoutes.chatDetail,
      arguments: ChatItem(
        name: userName,
        avatar: userAvatar,
        preview: '',
        time: '',
        lastSeen: 'Last seen recently',
      ),
    );
  }

  /// Open the existing Comments flow for the tapped post.
  void openPost(int index) {
    Get.toNamed(
      AppRoutes.comments,
      arguments: PostModel(
        userImage: userAvatar,
        userName: userName,
        time: 'Just now',
        caption: bio,
        postImage: posts[index],
        likedAvatars: const [
          'assets/images/like_user_image_1.png',
          'assets/images/like_user_image_2.png',
          'assets/images/like_user_image_3.png',
        ],
        likedByName: 'Blazinshado',
        likeCount: 120,
        commentCount: 12,
      ),
    );
  }

  /// 3-dot menu.
  void openMenu() {
    // TODO: show profile options (report, block, share...).
  }

  void onBack() => Get.back();
}
