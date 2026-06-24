import 'package:flutter/material.dart';

import '../controllers/home/home_controller.dart';
import 'story_avatar.dart';

/// Horizontal scroller of [StoryAvatar]s.
class StoryList extends StatelessWidget {
  const StoryList({super.key, required this.stories, this.onStoryTap});

  final List<StoryItem> stories;
  final void Function(int index)? onStoryTap;

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
          final story = stories[index];
          return StoryAvatar(
            name: story.name,
            image: story.image,
            avatar: story.avatar,
            isLive: story.isLive,
            isAdd: story.isAdd,
            onTap: () => onStoryTap?.call(index),
          );
        },
      ),
    );
  }
}
