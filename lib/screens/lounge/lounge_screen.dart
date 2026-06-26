import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/lounge/lounge_controller.dart';
import '../../utils/app_colors.dart';
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
              _appBar(),
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

          // Floating create-Ofofo button.
          Positioned(
            right: 16,
            bottom: 16,
            child: _createButton(),
          ),
        ],
      ),
    );
  }

  Widget _appBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: controller.onBack,
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
          const Expanded(
            child: Center(
              child: Text(
                'Ofofo',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackText,
                ),
              ),
            ),
          ),
          const SizedBox(width: 40, height: 40),
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
        width: 56,
        height: 56,
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
          child: SvgPicture.asset(
            'assets/icons/ofofo_plus.svg',
            height: 26,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
