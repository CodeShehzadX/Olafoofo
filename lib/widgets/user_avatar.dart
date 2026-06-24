import 'package:flutter/material.dart';

/// A circular avatar that renders either a local asset or a network image.
///
/// Reused across posts, stories, comments, chats, lounges and profiles.
class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.image,
    this.size = 44,
    this.borderColor,
    this.borderWidth = 0,
  });

  /// Asset path (e.g. `assets/images/x.png`) or an `http(s)` URL.
  final String image;
  final double size;
  final Color? borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final isNetwork = image.startsWith('http');
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: borderColor != null
            ? Border.all(color: borderColor!, width: borderWidth)
            : null,
      ),
      child: ClipOval(
        child: isNetwork
            ? Image.network(image, width: size, height: size, fit: BoxFit.cover)
            : Image.asset(image, width: size, height: size, fit: BoxFit.cover),
      ),
    );
  }
}
