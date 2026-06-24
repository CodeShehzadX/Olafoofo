import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/comments/comments_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
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
              _appBar(),
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
                'Comment',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackText,
                ),
              ),
            ),
          ),
          // Balances the back button so the title stays centred.
          const SizedBox(width: 40, height: 40),
        ],
      ),
    );
  }
}
