import 'package:flutter/material.dart';

import '../controllers/notifications/notification_controller.dart';
import '../utils/app_colors.dart';
import 'user_avatar.dart';

/// A single notification row: avatar + rich action text + time.
class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key, required this.item});

  final NotificationItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UserAvatar(image: item.avatar, size: 48),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.blackText,
                      height: 1.2,
                    ),
                    children: [
                      TextSpan(
                        text: item.boldText,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      if (item.normalText != null)
                        TextSpan(
                          text: item.normalText,
                          style: const TextStyle(fontWeight: FontWeight.w400),
                        ),
                      if (item.italicText != null)
                        TextSpan(
                          text: item.italicText,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.time,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textHint,
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
