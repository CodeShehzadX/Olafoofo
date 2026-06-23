import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth/welcome_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/custom_button.dart';

class WelcomeScreen extends GetView<WelcomeController> {
  const WelcomeScreen({super.key});

  // Teal used for the decorative stars/dots (matches the design).
  static const Color _decor = AppColors.splashCircle;

  @override
  Widget build(BuildContext context) {
    return AppConstants.lightSystemOverlay(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _illustration(),
                const SizedBox(height: 28),
                const Text(
                  'Welcome',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackText,
                  ),
                ),
                const SizedBox(height: 28),
                CustomButton(
                  height: 56,
                  margin: 0,
                  borderRadius: 14,
                  title: 'Continue',
                  titleFontSize: 16,
                  backgroundColor: AppColors.splashCircle,
                  textColor: Colors.white,
                  onTap: controller.onContinue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Central illustration with a soft circle backdrop and scattered confetti.
  Widget _illustration() {
    return SizedBox(
      width: double.infinity,
      height: 240,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Soft circle behind the image
          Container(
            width: 152,
            height: 152,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFF1F5F6),
            ),
          ),

          // Hero illustration (138 x 138)
          Image.asset(
            'assets/images/signup_succes.png',
            width: 138,
            height: 138,
            fit: BoxFit.contain,
          ),

          // Scattered stars
          const Positioned(top: 24, left: 270, child: _Star(size: 20)),
          const Positioned(top: 219, left: 228, child: _Star(size: 16)),
          const Positioned(top:104, left: 90,child:  _Star(size: 15)),
          

          // Scattered dots
         const Positioned(top: 8, left: 88, child: _Dot(size: 20)),
          const Positioned(top: 12, left: 160, child: _Dot(size: 12)),
          const Positioned(bottom: 46, left: 64, child: _Dot(size: 10)),
          const Positioned(bottom: 20, left: 120, child: _Dot(size: 8)),
          const Positioned(bottom: 60, right: 44, child: _Dot(size: 10)),
        ],
      ),
    );
  }
}

/// A small teal star used in the confetti scatter.
class _Star extends StatelessWidget {
  const _Star({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.star_rounded, size: size, color: WelcomeScreen._decor);
  }
}

/// A small teal dot used in the confetti scatter.
class _Dot extends StatelessWidget {
  const _Dot({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: WelcomeScreen._decor,
      ),
    );
  }
}
