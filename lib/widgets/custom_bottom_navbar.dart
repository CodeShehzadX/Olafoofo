import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/app_colors.dart';

/// The 5-tab bottom navigation bar for the main app shell.
///
/// Tabs (in order): Home · Ofofo/Lounge · Add Post · Chats · Profile.
/// Stateless — the selected index and tap handling are owned by the caller
/// (MainController), so this can be wrapped in an [Obx].
class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  /// Currently selected tab index.
  final int currentIndex;

  /// Called with the tapped tab index.
  final ValueChanged<int> onTap;

  static const List<String> _icons = [
    'assets/icons/Home_bottom_navbar.svg',
    'assets/icons/lounge_bottom_navbar.svg',
    'assets/icons/add_post_bottom_navbar.svg',
    'assets/icons/Chat_bottom_navbar.svg',
    'assets/icons/Profile_bottom_navbar.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 62,
          child: Row(
            children: List.generate(_icons.length, (index) {
              final selected = index == currentIndex;
              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onTap(index),
                  child: Center(
                    child: SvgPicture.asset(
                      _icons[index],
                      height: 26,
                      colorFilter: ColorFilter.mode(
                        selected ? AppColors.splashCircle : AppColors.blackText,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
