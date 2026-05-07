import 'package:flutter/material.dart';

class AppColors {
  // Backgrounds & Surfaces
  static const Color background = Color(0xFFF2F6FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surface2 = Color(0xFFEBF1F8);
  static const Color surface3 = Color(0xFFDCE6F0);

  // Primary (Blues)
  static const Color primary = Color(0xFF0277BD);
  static const Color primaryHover = Color(0xFF01579B);
  static const Color primaryLight = Color(0xFFE3F2FD);
  static const Color primaryMid = Color(0xFF0288D1);
  static const Color accent = Color(0xFF002171);

  // Text Colors
  static const Color text1 = Color(0xFF0A1628);
  static const Color text2 = Color(0xFF3D5166);
  static const Color text3 = Color(0xFF7A90A8);

  // Borders
  static const Color border1 = Color(0xFFD0DCE8);
  static const Color border2 = Color(0xFFB8CCDE);

  // Status & Accents
  static const Color red = Color(0xFFE53935);
  static const Color green = Color(0xFF00897B);
  static const Color amber = Color(0xFFF57C00);

  // Gold
  static const Color gold = Color(0xFFF57C00);
  static const Color goldLight = Color(0xFFFFF3E0);
  static const Color goldMid = Color(0xFFFB8C00);

  // Teal
  static const Color teal = Color(0xFF00ACC1);
  static const Color tealLight = Color(0xFFE0F7FA);

  // Hero Gradients (from CSS)
  static const Gradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF01305A),
      Color(0xFF0151A0),
      Color(0xFF0277BD),
    ],
  );
}