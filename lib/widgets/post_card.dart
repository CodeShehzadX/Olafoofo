import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/home/home_controller.dart';
import '../utils/app_colors.dart';
import 'user_avatar.dart';

/// A single feed post card (header, caption, image, like/comment actions).
class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
    this.onProfileTap,
    this.onLikeTap,
    this.onCommentTap,
    this.onViewComments,
    this.showViewComments = true,
  });

  final PostModel post;
  final VoidCallback? onProfileTap;
  final VoidCallback? onLikeTap;
  final VoidCallback? onCommentTap;
  final VoidCallback? onViewComments;

  /// Whether to show the trailing "View all comments" link.
  /// Hidden on the Comments screen, where it would be redundant.
  final bool showViewComments;

  static const Color _red = Color(0xFFEB5757);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onProfileTap,
            child: Row(
              children: [
                UserAvatar(image: post.userImage, size: 44),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.userName,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColors.blackText,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      post.time,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textHint,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Caption
          Text(
            post.caption,
            style: const TextStyle(fontSize: 14, color: AppColors.blackText),
          ),
          const SizedBox(height: 12),

          // Post image (bundled asset, or a picked file for new posts)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: post.isAssetImage
                ? Image.asset(
                    post.postImage,
                    width: double.infinity,
                    height: 240,
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    File(post.postImage),
                    width: double.infinity,
                    height: 240,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(height: 10),

          // Liked avatars + like/comment actions
          Row(
            children: [
              _likedAvatars(),
              const Spacer(),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onLikeTap,
                child: Obx(
                  () => Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/Heart.svg',
                        height: 20,
                        colorFilter: ColorFilter.mode(
                          post.isLiked.value ? _red : AppColors.textHint,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${post.likeCount.value}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 18),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onCommentTap,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/Chat.svg',
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                        AppColors.blackText,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${post.commentCount}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Liked by ...
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 13, color: AppColors.blackText),
              children: [
                const TextSpan(text: 'Liked by '),
                TextSpan(
                  text: post.likedByName,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const TextSpan(text: ' and '),
                const TextSpan(
                  text: '100+',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const TextSpan(text: ' others'),
              ],
            ),
          ),
          // View all comments
          if (showViewComments) ...[
            const SizedBox(height: 4),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onViewComments,
              child: Text(
                'View all ${post.commentCount} comments',
                style: const TextStyle(fontSize: 13, color: AppColors.textHint),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _likedAvatars() {
    const double size = 26;
    const double overlap = 16;
    return SizedBox(
      width: size + (post.likedAvatars.length - 1) * overlap,
      height: size,
      child: Stack(
        children: [
          for (int i = 0; i < post.likedAvatars.length; i++)
            Positioned(
              left: i * overlap,
              child: UserAvatar(
                image: post.likedAvatars[i],
                size: size,
                borderColor: AppColors.lightGray,
                borderWidth: 2,
              ),
            ),
        ],
      ),
    );
  }
}
