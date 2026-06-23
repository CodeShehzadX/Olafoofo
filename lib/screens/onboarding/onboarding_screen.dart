import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/custom_button.dart';
import '../../controllers/onboarding/onboarding_controller.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConstants.lightSystemOverlay(
      child: Scaffold(
        backgroundColor: AppColors.lightBackground,
        body: SafeArea(
          child: Column(
            children: [
              // Swipeable onboarding pages (avatar cluster + dynamic text)
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  itemCount: controller.pages.length,
                  itemBuilder: (context, index) {
                    return _OnboardingPage(
                      data: controller.pages[index],
                      avatars: controller.avatars[index],
                    );
                  },
                ),
              ),

              // Action buttons + sign-in (shared across all pages)
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24,24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Buttons depend on the current page index
                    Obx(() {
                      if (controller.isLastPage) {
                        return CustomButton(
                          height: 56,
                          margin: 0,
                          borderRadius: 14,
                          title: 'Continue',
                          titleFontSize: 16,
                          backgroundColor: AppColors.splashCircle,
                          textColor: Colors.white,
                          onTap: controller.onContinue,
                        );
                      }
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomButton(
                            height: 56,
                            margin: 0,
                            borderRadius: 14,
                            title: 'Next',
                            titleFontSize: 16,
                            backgroundColor: AppColors.splashCircle,
                            textColor: Colors.white,
                            onTap: controller.onNext,
                          ),
                          const SizedBox(height: 14),
                          CustomButton(
                            height: 56,
                            margin: 0,
                            borderRadius: 14,
                            title: 'Skip',
                            titleFontSize: 16,
                            backgroundColor: Colors.white,
                            textColor: AppColors.blackText,
                            borderColor: AppColors.borderColor,
                            onTap: controller.onSkip,
                          ),
                        ],
                      );
                    }),
                    Obx(
  () => SizedBox(
    height: controller.isLastPage ? 90 : 20,
  ),
),

                    // Sign in — always visible
                    GestureDetector(
                      onTap: controller.onSignIn,
                      child: RichText(
                        text: const TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackText,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign In',
                              style: TextStyle(
                                color: AppColors.textHint,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A single onboarding page: the floating avatar cluster on top with the
/// page's title and description beneath it.
class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({required this.data, required this.avatars});

  final OnboardingPageData data;
  final OnboardingAvatars avatars;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Floating avatar cluster
        Expanded(child: _AvatarCluster(avatars: avatars)),

        // Title + description
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                data.title,
                style: const TextStyle(
                  fontSize: 26,
                  height: 1.25,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackText,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                data.description,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.45,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// The cluster of floating avatars shown at the top of each page.
///
/// Positions are expressed as fractions of the available space so the
/// composition holds together across phone sizes.
class _AvatarCluster extends StatelessWidget {
  const _AvatarCluster({required this.avatars});

  final OnboardingAvatars avatars;

  // Soft teal used behind the lighter avatars / the big centre circle.
  static const Color _lightBg = Color(0xFFB7D3D8);
  static const Color _centerBg = Color(0xFFDCE9EB);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;

        return Stack(
          children: [
            // Centre — large hero avatar
            Align(
              alignment: const Alignment(0, -0.15),
              child: _Avatar(
                size: w * 0.34,
                background: _centerBg,
                asset: avatars.centre,
                imageInset: 0.10,
              ),
            ),

            // Top-right — dark, large
            Positioned(
              top: h * 0.06,
              right: w * 0.14,
              child: _Avatar(
                size: w * 0.16,
                background: AppColors.splashCircle,
                asset: avatars.topRight,
              ),
            ),

            // Top-left — light, small
            Positioned(
              top: h * 0.13,
              left: w * 0.10,
              child: _Avatar(
                size: 44,
                background: _lightBg,
                asset: avatars.topLeft,
              ),
            ),

            // Left-middle — dark, large
            Positioned(
              top: h * 0.50,
              left: w * 0.06,
              child: _Avatar(
                size: w * 0.17,
                background: AppColors.splashCircle,
                asset: avatars.leftMiddle,
              ),
            ),

            // Right-middle — light, small
            Positioned(
              top: h * 0.54,
              right: w * 0.08,
              child: _Avatar(
                size: 40,
                background: _lightBg,
                asset: avatars.rightMiddle,
              ),
            ),

            // Bottom-right — light, medium
            Positioned(
              bottom: h * 0.20,
              right: w * 0.16,
              child: _Avatar(
                size: w * 0.14,
                background: _centerBg,
                asset: avatars.bottomRight,
              ),
            ),

            // Bottom-centre — light, small
            Positioned(
              bottom: h * 0.15,
              left: w * 0.28,
              child: _Avatar(
                size: 46,
                background: _lightBg,
                asset: avatars.bottomCentre,
              ),
            ),
          ],
        );
      },
    );
  }
}

/// A single circular avatar: a coloured disc with an emoji image inset.
class _Avatar extends StatelessWidget {
  const _Avatar({
    required this.size,
    required this.background,
    required this.asset,
    this.imageInset = 0.16,
  });

  final double size;
  final Color background;
  final String asset;

  /// Fraction of [size] used as padding around the image.
  final double imageInset;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
      ),
      padding: EdgeInsets.all(size * imageInset),
      child: Image.asset(asset, fit: BoxFit.contain),
    );
  }
}
