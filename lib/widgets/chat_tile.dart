import 'package:flutter/material.dart';

import '../controllers/chat/chat_controller.dart';
import '../utils/app_colors.dart';
import 'user_avatar.dart';

/// A single conversation row in the "All Messages" list.
///
/// Shows avatar, name, last-message preview, timestamp and a trailing status:
/// unread count badge, a teal chevron badge, or a read double-tick.
class ChatTile extends StatelessWidget {
  const ChatTile({super.key, required this.chat, this.onTap});

  final ChatItem chat;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            UserAvatar(image: chat.avatar, size: 50),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackText,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    chat.preview,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textHint,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  chat.time,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textHint,
                  ),
                ),
                const SizedBox(height: 6),
                _trailingStatus(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _trailingStatus() {
    if (chat.unreadCount > 0) {
      return _badge(
        child: Text(
          '${chat.unreadCount}',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      );
    }
    if (chat.showArrow) {
      return _badge(
        child: const Icon(Icons.chevron_right, size: 16, color: Colors.white),
      );
    }
    if (chat.isRead) {
      return const Icon(Icons.done_all, size: 18, color: AppColors.textHint);
    }
    return const SizedBox(height: 20);
  }

  Widget _badge({required Widget child}) {
    return Container(
      width: 20,
      height: 20,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.splashCircle,
      ),
      child: child,
    );
  }
}
