import 'dart:async';
import 'package:base_project/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';
import '../routes/app_routes.dart';
import '../widgets/animations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 2));

    Get.offAllNamed(AppRoutes.onboarding);
  }

  @override
  Widget build(BuildContext context) {
    return AppConstants.lightSystemOverlay(
      child: Scaffold(
        backgroundColor: AppColors.lightBackground,
        body: Stack(
          children: [
            Positioned(
              top: 121,
              left: 261,
              child: FloatingMotion(
                amplitude: 8,
                duration: const Duration(milliseconds: 3200),
                child: _circle(65),
              ),
            ),
            Positioned(
              top: 199,
              left: 83,
              child: FloatingMotion(
                amplitude: 6,
                duration: const Duration(milliseconds: 4000),
                phase: 0.25,
                child: _circle(42),
              ),
            ),
            Positioned(
              top: 450,
              left: 50,
              child: FloatingMotion(
                amplitude: 10,
                duration: const Duration(milliseconds: 3600),
                phase: 0.5,
                child: _circle(55),
              ),
            ),
            Positioned(
              top: 500,
              right: 80,
              child: FloatingMotion(
                amplitude: 7,
                duration: const Duration(milliseconds: 4400),
                phase: 0.15,
                child: _circle(50),
              ),
            ),
            Positioned(
              bottom: 250,
              right: 55,
              child: FloatingMotion(
                amplitude: 5,
                duration: const Duration(milliseconds: 2800),
                phase: 0.7,
                child: _circle(32),
              ),
            ),
            Positioned(
              bottom: 155,
              left: 110,
              child: FloatingMotion(
                amplitude: 9,
                duration: const Duration(milliseconds: 3800),
                phase: 0.4,
                child: _circle(42),
              ),
            ),

            Center(
              child: FadeSlideIn(
                child: FloatingMotion(
                  amplitude: 6,
                  duration: const Duration(milliseconds: 3400),
                  child: Image.asset(
                    'assets/images/logo-1.png',
                    width: 181,
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circle(double size) {
    return Container(
      height: size,
      width: size,
      decoration: const BoxDecoration(
        color: AppColors.splashCircle,
        shape: BoxShape.circle,
      ),
    );
  }
}
