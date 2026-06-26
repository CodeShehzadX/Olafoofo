import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/lounge/lounge_controller.dart';
import '../../utils/app_colors.dart';
import '../../widgets/back_title_app_bar.dart';
import '../../widgets/custom_search_bar.dart';
import '../../widgets/lounge_card.dart';

/// The Ofofo/Lounge list screen — Figma page 23.
///
/// Rendered inside the main shell as the "Ofofo" tab, so (like [HomeScreen])
/// it has no Scaffold/bottom-nav of its own; the back button switches tabs via
/// the controller. The create button floats over the list.
class LoungeScreen extends GetView<LoungeController> {
  const LoungeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          Column(
            children: [
              BackTitleAppBar(title: 'Ofofo', onBack: controller.onBack),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                child: CustomSearchBar(controller: controller.searchController),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                  children: [
                    _sectionHeader(
                      'Feeling bored? Join an Ofofo',
                      'Selected based on your friends interest',
                    ),
                    const SizedBox(height: 14),
                    LoungeCard(
                      lounge: controller.lounges[0],
                      onTap: () => controller.openLounge(controller.lounges[0]),
                    ),
                    const SizedBox(height: 28),
                    _sectionHeader(
                      'Happening Now',
                      'Ofofos going on at the moment',
                    ),
                    const SizedBox(height: 14),
                    for (final lounge in controller.lounges.skip(1))
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: LoungeCard(
                          lounge: lounge,
                          onTap: () => controller.openLounge(lounge),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),

          // Floating create-Ofofo button — right side, lower-middle area,
          // overlapping near the third card (Figma page 23).
          Positioned(right: 18, bottom: 100, child: _createButton()),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.blackText,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 13, color: AppColors.textHint),
        ),
      ],
    );
  }

  Widget _createButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: controller.createOfofo,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.splashCircle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          // The Ofofo/lounge glyph with the small plus mark at its top-right.
          child: SizedBox(
            width: 26,
            height: 24,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: SvgPicture.asset(
                    'assets/icons/ofofo_white_filled.svg',
                    height: 19,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                Positioned(
                  top: -3,
                  right: 0,
                  child: SvgPicture.asset(
                    'assets/icons/ofofo_plus.svg',
                    height: 8,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
