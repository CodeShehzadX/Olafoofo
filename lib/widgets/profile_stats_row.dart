import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'profile_stat_item.dart';

/// The Posts / Following / Followers stats row used on profile screens, with
/// thin vertical dividers between items.
class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({
    super.key,
    required this.postsCount,
    required this.followingCount,
    required this.followersCount,
  });

  final String postsCount;
  final String followingCount;
  final String followersCount;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(child: ProfileStatItem(count: postsCount, label: 'Posts')),
          _divider(),
          Expanded(
            child: ProfileStatItem(count: followingCount, label: 'Following'),
          ),
          _divider(),
          Expanded(
            child: ProfileStatItem(count: followersCount, label: 'Followers'),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(width: 1, color: AppColors.lightBorder);
  }
}
