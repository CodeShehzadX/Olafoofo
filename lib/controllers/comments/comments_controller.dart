import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../home/home_controller.dart';

/// A single comment under a post. [isLiked] and [likeCount] are reactive so
/// each comment toggles its own like independently.
class CommentItem {
  CommentItem({
    required this.avatar,
    required this.username,
    required this.time,
    required this.text,
    required int likeCount,
    bool isLiked = false,
  })  : likeCount = likeCount.obs,
        isLiked = isLiked.obs;

  final String avatar;
  final String username;
  final String time;
  final String text;
  final RxInt likeCount;
  final RxBool isLiked;
}

/// Business logic + state for the Comments screen (GetX, no setState).
///
/// The post being viewed is passed in via [Get.arguments], so the same screen
/// works for any [PostModel] from any source (Home Feed, Profile, etc.) — no
/// hardcoded post data.
class CommentsController extends GetxController {
  /// The post whose comments are shown. Provided through navigation arguments.
  late final PostModel post;

  static const String _lorem =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra '
      'aliquam, congue habitasse tortor. Fringilla nunc aliquam volutpat '
      'suscipit porttitor in quis sagittis hac. Tellus sed ac libero';

  /// Dummy comments.
  final List<CommentItem> comments = [
    CommentItem(
      avatar: 'assets/images/commentor_1.png',
      username: 'Chris uil',
      time: '2hrs Ago',
      text: _lorem,
      likeCount: 25,
      isLiked: true,
    ),
    CommentItem(
      avatar: 'assets/images/commentor_2.png',
      username: 'Joe Mickey',
      time: '2hrs Ago',
      text: _lorem,
      likeCount: 25,
      isLiked: false,
    ),
    CommentItem(
      avatar: 'assets/images/commentor_3.png',
      username: 'General Focus',
      time: '2hrs Ago',
      text: _lorem,
      likeCount: 25,
      isLiked: true,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    post = Get.arguments as PostModel;
  }

  /// Toggle the like on the post (reactive — shared with the source list).
  void toggleLike() {
    if (post.isLiked.value) {
      post.isLiked.value = false;
      post.likeCount.value -= 1;
    } else {
      post.isLiked.value = true;
      post.likeCount.value += 1;
    }
  }

  /// Toggle the like on an individual [comment].
  void toggleCommentLike(CommentItem comment) {
    if (comment.isLiked.value) {
      comment.isLiked.value = false;
      comment.likeCount.value -= 1;
    } else {
      comment.isLiked.value = true;
      comment.likeCount.value += 1;
    }
  }

  /// Open the post author's profile, passing their data through navigation
  /// (same pattern as the Home feed).
  void onProfileTap() =>
      Get.toNamed(AppRoutes.userProfile, arguments: post);

  /// Pop back to the previous screen.
  void onBack() => Get.back();
}
