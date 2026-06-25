import 'package:flutter/material.dart';

import '../models/story_models.dart';
import 'story_avatar.dart';

/// Horizontal scroller of [StoryAvatar]s — one per [StoryGroup] (user).
class StoryList extends StatelessWidget {
  const StoryList({
    super.key,
    required this.stories,
    this.onStoryTap,
    this.onAddTap,
  });

  final List<StoryGroup> stories;

  /// Open the viewer for the group at the given index.
  final void Function(int index)? onStoryTap;

  /// Open the Add Story screen.
  final VoidCallback? onAddTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: stories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final group = stories[index];
          final isAddCard = group.isCurrentUser && !group.hasMedia;
          final showPlus = group.isCurrentUser && group.hasMedia;
          return StoryAvatar(
            name: group.username,
            cover: group.cover?.path,
            avatar: group.avatar,
            isLive: group.isLive,
            isAdd: isAddCard,
            showPlusBadge: showPlus,
            onTap: isAddCard ? onAddTap : () => onStoryTap?.call(index),
            onBadgeTap: onAddTap,
          );
        },
      ),
    );
  }
}
