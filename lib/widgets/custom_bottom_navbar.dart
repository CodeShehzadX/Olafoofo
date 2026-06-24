import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/app_colors.dart';

/// One bottom-nav tab: its outline (inactive) and filled (active) SVG assets.
class _NavItem {
  const _NavItem(this.outline, this.filled);
  final String outline;
  final String filled;
}

/// The 5-tab bottom navigation bar for the main app shell.
///
/// Tabs (in order): Home · Ofofo/Lounge · Add Post · Chats · Profile.
///
/// The selected tab uses the **filled** SVG tinted with the app's teal primary;
/// the others use the **outline** SVG tinted black — matching the Figma.
///
/// Stateless — selection/tap handling stays with the caller (MainController),
/// so this can be wrapped in an [Obx].
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

  // Note: the filled assets use inconsistent names (double underscore on
  // lounge, no `_bottom_navbar` on chat) — kept verbatim to match the files.
  static const List<_NavItem> _items = [
    _NavItem(
      'assets/icons/Home_bottom_navbar.svg',
      'assets/icons/Home_bottom_navbar_filled.svg',
    ),
    _NavItem(
      'assets/icons/lounge_bottom_navbar.svg',
      'assets/icons/lounge_bottom_navbar__filled.svg',
    ),
    _NavItem(
      'assets/icons/add_post_bottom_navbar.svg',
      'assets/icons/add_post_bottom_navbar_filled.svg',
    ),
    _NavItem(
      'assets/icons/Chat_bottom_navbar.svg',
      'assets/icons/Chat_filled.svg',
    ),
    _NavItem(
      'assets/icons/Profile_bottom_navbar.svg',
      'assets/icons/Profile_bottom_navbar_filled.svg',
    ),
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
            children: List.generate(_items.length, (index) {
              final selected = index == currentIndex;
              final item = _items[index];
              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onTap(index),
                  child: Center(
                    child: SvgPicture.asset(
                      selected ? item.filled : item.outline,
                      height: 26,
                      colorFilter: ColorFilter.mode(
                        selected
                            ? AppColors.splashCircle
                            : AppColors.blackText,
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
