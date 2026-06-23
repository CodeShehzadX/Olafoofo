import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';

/// Immutable content for a single onboarding page.
class OnboardingPageData {
  const OnboardingPageData({required this.title, required this.description});

  final String title;
  final String description;
}

/// The image used in each slot of the floating avatar cluster.
///
/// Slot layout (size / position / background) is fixed by the cluster widget;
/// this model only swaps which image each slot shows, per page.
class OnboardingAvatars {
  const OnboardingAvatars({
    required this.centre,
    required this.topRight,
    required this.topLeft,
    required this.leftMiddle,
    required this.rightMiddle,
    required this.bottomRight,
    required this.bottomCentre,
  });

  final String centre;
  final String topRight;
  final String topLeft;
  final String leftMiddle;
  final String rightMiddle;
  final String bottomRight;
  final String bottomCentre;
}

/// Business logic + state for the onboarding flow.
///
/// Owns the [PageController] and the reactive [currentPage] so the screen can
/// stay purely declarative (no setState, GetX only).
class OnboardingController extends GetxController {
  /// Drives the [PageView] in the screen.
  final PageController pageController = PageController();

  /// Index of the currently visible page (reactive).
  final RxInt currentPage = 0.obs;

  /// Static content for each onboarding page.
  final List<OnboardingPageData> pages = const [
    OnboardingPageData(
      title: 'Connect with Friends and Family',
      description:
          'Connecting with Family and Friends provides a sense of belonging '
          'and security',
    ),
    OnboardingPageData(
      title: 'Make new friends with ease',
      description:
          'Allowing you to make new Friends is our Number one priority.....',
    ),
    OnboardingPageData(
      title: 'Express yourself to the world',
      description:
          'Let your voice be heard on the internet through the OFOFO features '
          'on the App without restrictions',
    ),
  ];

  /// Avatar imagery for each page (index-aligned with [pages]).
  ///
  /// Page 1: original emoji set + hero circle.
  /// Page 2: dedicated page-2 asset set (note: files are spelled
  /// `onbaording_page_2-*` in assets).
  /// Page 3: reuses page 1's outer emojis, with `onboarding_emoji7` as the hero.
  final List<OnboardingAvatars> avatars = const [
    // Page 1
    OnboardingAvatars(
      centre: 'assets/images/onboarding_1_big_circle.png',
      topRight: 'assets/images/onboarding_emoji7.png',
      topLeft: 'assets/images/onboarding_emoji1.png',
      leftMiddle: 'assets/images/onboarding_emoji5.png',
      rightMiddle: 'assets/images/onboarding_emoji4.png',
      bottomRight: 'assets/images/onboarding_emoji3.png',
      bottomCentre: 'assets/images/onboarding_emoji6.png',
    ),
    // Page 2
    OnboardingAvatars(
      centre: 'assets/images/onbaording_page_2-1.png',
      topRight: 'assets/images/onbaording_page_2-7.png',
      topLeft: 'assets/images/onbaording_page_2-8.png',
      leftMiddle: 'assets/images/onbaording_page_2-2.png',
      rightMiddle: 'assets/images/onbaording_page_2-3.png',
      bottomRight: 'assets/images/onbaording_page_2-4.png',
      bottomCentre: 'assets/images/onbaording_page_2-6.png',
    ),
    // Page 3
    OnboardingAvatars(
      centre: 'assets/images/onboarding_page_3_main.png',
      topRight: 'assets/images/onboarding_1_big_circle.png',
      topLeft: 'assets/images/onboarding_page_3_topleft.png',
      leftMiddle: 'assets/images/onboarding_emoji5.png',
      rightMiddle: 'assets/images/onboarding_emoji4.png',
      bottomRight: 'assets/images/onboarding_emoji3.png',
      bottomCentre: 'assets/images/onboarding_page_3_bottomleft.png',
    ),
  ];

  /// Whether the user is on the final page.
  bool get isLastPage => currentPage.value == pages.length - 1;

  /// Keep [currentPage] in sync with swipe gestures.
  void onPageChanged(int index) => currentPage.value = index;

  /// Advance to the next page (used by the "Next" button).
  void onNext() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// Finish onboarding from the last page's "Continue" button.
  ///
  /// TODO: route to your main entry point (home/signup) when ready.
  void onContinue() {
    Get.toNamed(AppRoutes.phone);
  }

  /// Skip onboarding entirely.
  ///
  /// TODO: route to your main entry point (home/login) when ready.
  void onSkip() {
    Get.offAllNamed(AppRoutes.phone);
  }

  /// Existing user wants to sign in.
  void onSignIn() {
    Get.toNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
