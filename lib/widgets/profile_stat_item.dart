import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

/// A single profile stat: a bold count over a gray label (Posts / Following /
/// Followers). Used in the My Profile stats row.
class ProfileStatItem extends StatelessWidget {
  const ProfileStatItem({super.key, required this.count, required this.label});

  final String count;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.blackText,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: AppColors.textHint),
        ),
      ],
    );
  }
}
