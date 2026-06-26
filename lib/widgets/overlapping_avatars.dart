import 'package:flutter/material.dart';

import 'user_avatar.dart';

/// A horizontally overlapping cluster of circular avatars (e.g. liked-by on a
/// post, or listeners on a lounge card).
class OverlappingAvatars extends StatelessWidget {
  const OverlappingAvatars({
    super.key,
    required this.images,
    required this.size,
    required this.overlap,
    this.borderColor,
    this.borderWidth = 2,
  });

  final List<String> images;
  final double size;

  /// Horizontal offset between consecutive avatars.
  final double overlap;

  final Color? borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size + (images.length - 1) * overlap,
      height: size,
      child: Stack(
        children: [
          for (int i = 0; i < images.length; i++)
            Positioned(
              left: i * overlap,
              child: UserAvatar(
                image: images[i],
                size: size,
                borderColor: borderColor,
                borderWidth: borderWidth,
              ),
            ),
        ],
      ),
    );
  }
}
