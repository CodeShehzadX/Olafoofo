import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'user_avatar.dart';

/// A single story tile in the horizontal stories row.
///
/// Three looks (all share the same card + bottom-centre badge layout):
/// * [isAdd] — empty bordered card with a "+" badge (current user's add-story).
/// * [isLive] — story image with a LIVE badge.
/// * default — story image with the author's avatar.
class StoryAvatar extends StatelessWidget {
  const StoryAvatar({
    super.key,
    required this.name,
    this.image,
    this.avatar,
    this.isLive = false,
    this.isAdd = false,
    this.onTap,
  });

  final String name;
  final String? image;
  final String? avatar;
  final bool isLive;
  final bool isAdd;
  final VoidCallback? onTap;

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
              // Extra half-badge of room so the bottom badge can overhang.
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

  /// The full-size card behind the badge — image, or an empty bordered box.
  Widget _card() {
    if (isAdd) {
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(_radius),
      child: Image.asset(image!, width: _w, height: _h, fit: BoxFit.cover),
    );
  }

  /// The bottom-centre badge: a "+" for add-story, else the author avatar.
  Widget _bottomBadge() {
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
