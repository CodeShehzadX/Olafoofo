import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

/// The app's standard top bar: a back chevron, a centered title, and (by
/// default) a 40px spacer that balances the back button so the title stays
/// centered. Pass [trailing] to put an action on the right instead.
class BackTitleAppBar extends StatelessWidget {
  const BackTitleAppBar({
    super.key,
    required this.title,
    required this.onBack,
    this.trailing,
  });

  final String title;
  final VoidCallback onBack;

  /// Optional right-side widget. Defaults to a 40x40 spacer.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onBack,
            child: const SizedBox(
              width: 40,
              height: 40,
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: AppColors.blackText,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackText,
                ),
              ),
            ),
          ),
          trailing ?? const SizedBox(width: 40, height: 40),
        ],
      ),
    );
  }
}
