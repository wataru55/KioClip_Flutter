import 'package:flutter/material.dart';

class AppStyles {
  // このクラスはインスタンス化させないための、プライベートコンストラクタ
  AppStyles._();

  // === Corner Radius ===
  static const double cornerRadius = 16.0;
  static const double cornerRadiusSmall = 8.0;

  // === Border Width ===
  static const double borderWidth = 1.5;

  // === Padding & Spacing ===
  static const double edgeAllPadding = 12.0;
  static const double cardMarginBottom = 8.0;
  static const double cardSpacing = 8.0;

  // === Sized Box Height ===
  static const double sizedBoxHeight = 16.0;

  // === Article Card ===
  static const double articleThumbnailWidth = 150.0;
  static const double articleThumbnailHeight = 100.0;
  static const double articleThumbnailIconSize = 50.0;

  // === Typography ===
  static const double articleTitleFontSize = 16.0;
  static const double articleHostFontSize = 14.0;
  static const double articleDateFontSize = 12.0;

  // === Color ===
  static const Color cardBackgroundColor = Color(0xFFB2D8B2);
  static const Color articleThumbnailPlaceholderColor = Color(0xFFE0E0E0);
  static const Color articleTextSecondaryColor = Color(0xFF757575);
}
