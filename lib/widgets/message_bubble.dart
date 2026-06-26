import 'package:flutter/material.dart';

import '../controllers/chat/chat_detail_controller.dart';
import '../utils/app_colors.dart';

/// A single chat message bubble.
///
/// Outgoing (sent) messages are light-gray and right-aligned; incoming
/// messages are teal with white text and left-aligned. Supports an optional
/// attached image.
class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    final bool isSent = message.isSent;
    final Color bubbleColor =
        isSent ? AppColors.lightGray : AppColors.splashCircle;
    final Color textColor = isSent ? AppColors.blackText : Colors.white;
    final Color timeColor =
        isSent ? AppColors.textHint : Colors.white.withValues(alpha: 0.8);

    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.72,
        ),
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 8),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (message.image != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  message.image!,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
            ],
            if (message.text.isNotEmpty)
              Text(
                message.text,
                style: TextStyle(fontSize: 14, color: textColor, height: 1.3),
              ),
            const SizedBox(height: 4),
            Text(
              message.time,
              style: TextStyle(fontSize: 11, color: timeColor),
            ),
          ],
        ),
      ),
    );
  }
}
