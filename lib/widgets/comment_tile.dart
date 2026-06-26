import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/comments/comments_controller.dart';
import '../utils/app_colors.dart';
import 'user_avatar.dart';

/// A single comment row: avatar + like on the left, name/time/text on the right.
class CommentTile extends StatelessWidget {
  const CommentTile({super.key, required this.item, this.onLikeTap});

  final CommentItem item;
  final VoidCallback? onLikeTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar + like count
          Column(
            children: [
              UserAvatar(image: item.avatar, size: 40),
              const SizedBox(height: 8),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onLikeTap,
                child: Obx(
                  () => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/Heart.svg',
                        height: 16,
                        colorFilter: ColorFilter.mode(
                          item.isLiked.value
                              ? AppColors.likeRed
                              : AppColors.textHint,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${item.likeCount.value}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),

          // Name + time + comment text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.username,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blackText,
                        ),
                      ),
                    ),
                    Text(
                      item.time,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textHint,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Right padding so the text wraps before the far edge (Figma).
                Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: Text(
                    item.text,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.45,
                      color: AppColors.textHint,
                    ),
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
