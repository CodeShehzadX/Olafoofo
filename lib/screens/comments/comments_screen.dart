import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/comments/comments_controller.dart';
import '../../utils/app_constants.dart';
import '../../widgets/back_title_app_bar.dart';
import '../../widgets/comment_tile.dart';
import '../../widgets/post_card.dart';

class CommentsScreen extends GetView<CommentsController> {
  const CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConstants.lightSystemOverlay(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              BackTitleAppBar(title: 'Comment', onBack: controller.onBack),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  children: [
                    // Selected post (from navigation args) — no "View all".
                    PostCard(
                      post: controller.post,
                      showViewComments: false,
                      onLikeTap: controller.toggleLike,
                      onProfileTap: controller.onProfileTap,
                    ),
                    const SizedBox(height: 8),
                    for (final comment in controller.comments)
                      CommentTile(
                        item: comment,
                        onLikeTap: () => controller.toggleCommentLike(comment),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
