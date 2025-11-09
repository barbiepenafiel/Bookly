import 'package:flutter/material.dart';

/// Bookly App Color Constants
///
/// This file contains all the color definitions used throughout the app.
/// Updated to Purple & White Theme (November 8, 2025)

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF8a5bf7); // Main purple
  static const Color primaryDark = Color(
    0xFF7c4de6,
  ); // Darker purple for gradients
  static const Color primaryLight = Color(
    0xFFD4B5FD,
  ); // Light purple for accents

  // Background & Surface Colors
  static const Color background = Colors.white; // Main background
  static const Color surface = Colors.white; // Card/Container background
  static const Color surfaceLight = Color(0xFFF9F7FF); // Slightly tinted white

  // Text Colors
  static const Color textPrimary = Colors.black; // Main text
  static const Color textSecondary = Color(0xFF666666); // Secondary text
  static const Color textHint = Color(0xFFD4B5FD); // Hint text
  static const Color textDisabled = Color(0xFFCCCCCC); // Disabled text

  // Border & Divider Colors
  static const Color border = Color(0xFFE9D5FF); // Light purple borders
  static const Color borderActive = Color(0xFF8a5bf7); // Active border
  static const Color divider = Color(0xFFE9D5FF); // Dividers

  // Semantic Colors
  static const Color success = Color(0xFF4CAF50); // Success green
  static const Color error = Color(0xFFFF6B6B); // Error red
  static const Color warning = Color(0xFFFFA726); // Warning orange
  static const Color info = Color(0xFF29B6F6); // Info blue

  // Gradient
  static const List<Color> primaryGradient = [
    Color(0xFF8a5bf7),
    Color(0xFF7c4de6),
  ];

  // Transparency variants
  static Color primaryWithOpacity(double opacity) =>
      primary.withValues(alpha: opacity);

  static Color primaryDarkWithOpacity(double opacity) =>
      primaryDark.withValues(alpha: opacity);

  // Utility method for getting text color based on background
  static Color getContrastText(Color backgroundColor) {
    // If background is dark, return white text
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
