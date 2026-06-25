import 'dart:io';

import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'user_avatar.dart';

/// A single story tile in the horizontal stories row (one per user).
///
/// Looks:
/// * [isAdd] — empty bordered card with a "+" badge (current user, no story).
/// * [showPlusBadge] — cover image with a "+" badge (current user, has story);
///   tapping the card opens the viewer, tapping the "+" adds another story.
/// * [isLive] — cover image with a LIVE badge.
/// * default — cover image with the author's avatar badge.
class StoryAvatar extends StatelessWidget {
  const StoryAvatar({
    super.key,
    required this.name,
    this.cover,
    this.avatar,
    this.isLive = false,
    this.isAdd = false,
    this.showPlusBadge = false,
    this.onTap,
    this.onBadgeTap,
  });

  final String name;

  /// Card image path (asset or file); null for the add card.
  final String? cover;

  /// Avatar badge image (other users).
  final String? avatar;
  final bool isLive;
  final bool isAdd;
  final bool showPlusBadge;

  /// Tap the card (open Add Story for [isAdd], else open the viewer).
  final VoidCallback? onTap;

  /// Tap the "+" badge (open Add Story) — current user with an existing story.
  final VoidCallback? onBadgeTap;

  static const double _w = 78;
  static const double _h = 112;
  static const double _badge = 32;
  static const double _radius = 16;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: _w,
        child: Column(
          children: [
            SizedBox(
              width: _w,
              height: _h + _badge / 2,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Align(alignment: Alignment.topCenter, child: _card()),
                  if (isLive)
                    const Positioned(top: 8, right: 8, child: _LiveBadge()),
                  Align(alignment: Alignment.bottomCenter, child: _bottomBadge()),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.blackText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card() {
    if (cover == null) {
      // Add card — empty bordered box.
      return Container(
        width: _w,
        height: _h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(_radius),
          border: Border.all(color: AppColors.borderColor),
        ),
      );
    }
    final img = cover!;
    return ClipRRect(
      borderRadius: BorderRadius.circular(_radius),
      child: img.startsWith('assets/')
          ? Image.asset(img, width: _w, height: _h, fit: BoxFit.cover)
          : Image.file(File(img), width: _w, height: _h, fit: BoxFit.cover),
    );
  }

  Widget _bottomBadge() {
    // Empty add card: white "+" circle with a grey border.
    if (isAdd) {
      return Container(
        width: _badge,
        height: _badge,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: AppColors.borderColor),
        ),
        child: const Icon(Icons.add, size: 18, color: AppColors.blackText),
      );
    }

    // Current user with a story: teal "+" badge to add another (tappable).
    if (showPlusBadge) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onBadgeTap,
        child: Container(
          width: _badge,
          height: _badge,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.splashCircle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: const Icon(Icons.add, size: 18, color: Colors.white),
        ),
      );
    }

    if (avatar != null) {
      return UserAvatar(
        image: avatar!,
        size: _badge,
        borderColor: Colors.white,
        borderWidth: 2,
      );
    }
    return const SizedBox.shrink();
  }
}

/// Small white "LIVE" pill shown on the top-right of a live story.
class _LiveBadge extends StatelessWidget {
  const _LiveBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'LIVE',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: AppColors.blackText,
        ),
      ),
    );
  }
}
