import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFFD4AF37); // Gold
  static const Color primaryDark = Color(0xFFB8941F);
  static const Color primaryLight = Color(0xFFE5C94D);

  // Splash Screen Circles
  static const Color splashCircle = Color(0xff006175);

  // Secondary Color (from Figma)
  static const Color secondary = Color(0xFF8B6934); // Brown/Dark Gold

  // Background Colors (Dark Theme)
  static const Color background = Color(0xFF121212);
  static const Color surface = Color(0xFF1E1E1E);
  static const Color cardBackground = Color(0xFF2A2A2A);

  // Background Colors (Light Theme)
  static const Color lightBackground = Color(0xFFFCFCFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightGray = Color(0xFFF5F5F5);

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textHint = Color(0xFF707070);

  // Light Theme Text Colors
  static const Color blackText = Color(0xFF101010);
  static const Color darkBlackText = Color(0xFF060606);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFA726);
  static const Color error = Color(0xFFE57373);
  static const Color info = Color(0xFF42A5F5);

  // Status Badge Colors
  static const Color pending = Color(0xFFFFA726);
  static const Color completed = Color(0xFF4CAF50);
  static const Color ongoing = Color(0xFF42A5F5);
  static const Color rejected = Color(0xFFE57373);

  // Priority Colors
  static const Color highPriority = Color(0xFFE57373);
  static const Color mediumPriority = Color(0xFFFFA726);
  static const Color lowPriority = Color(0xFF81C784);

  // Border Colors
  static const Color border = Color(0xFF3A3A3A);
  static const Color divider = Color(0xFF2A2A2A);
  static const Color lightBorder = Color(0xFFEDF1F3);
  static const Color borderColor = Color(0xFFB9B9B9);

  // Feature Accent Colors
  static const Color likeRed = Color(0xFFEB5757); // heart / like red
  static const Color loungeCard = Color(0xFF6E9499); // Ofofo/Lounge card bg

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Light variants for effects
  static const Color lightPrimary = primaryLight;

  // Accent Colors
  static const Color purpleAccent = Color(0xFF5C266E);
  static const Color goldAccent = Color(0xFFEDC96A);
}
