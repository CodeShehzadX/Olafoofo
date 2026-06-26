import 'package:flutter/material.dart';

import '../controllers/lounge/lounge_controller.dart';
import '../utils/app_colors.dart';
import 'overlapping_avatars.dart';
import 'user_avatar.dart';

/// A single Ofofo/Lounge room card: live label, title, listener count +
/// avatars, host name and current speaker. Matches Figma page 23.
class LoungeCard extends StatelessWidget {
  const LoungeCard({super.key, required this.lounge, this.onTap});

  final Lounge lounge;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.loungeCard,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Live label
            if (lounge.isLive)
              const Text(
                'Live',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            const SizedBox(height: 10),

            // Title
            Text(
              lounge.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 16),

            // Listener avatars + count
            Row(
              children: [
                OverlappingAvatars(
                  images: lounge.listenerAvatars,
                  size: 28,
                  overlap: 18,
                  borderColor: AppColors.loungeCard,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    lounge.listeningLabel,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Host
            Text(
              'Host ${lounge.hostName}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),

            // Current speaker
            Row(
              children: [
                UserAvatar(image: lounge.speakerAvatar, size: 26),
                const SizedBox(width: 10),
                Text(
                  '${lounge.speakerName} is speaking',
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
