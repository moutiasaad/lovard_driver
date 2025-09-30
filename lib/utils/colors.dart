import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF00555C);
  static const Color secondary = Color(0xFFB89EC6);
  static const Color primary1 = Color(0xFF626EFD);

  static Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 7) {
      buffer.write('ff'); // Add 'ff' for full opacity if alpha is not provided
    }
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

// text colors
class TextColor {
  static const Color primary = Color(0xFF00555C);
  static const Color secondary = Color(0xFFB89EC6);
  static const Color primary1 = Color(0xFF626EFD);
  static const Color black = Color(0xFF0A0B19); //all
  static const Color black1 = Color(0xFF3B3C47); //800
  static const Color black2 = Color(0xFF54545E); //700
  static const Color black3 = Color(0xFF6C6D75); //600
  static const Color black4 = Color(0xFF4D4D4D); //600
  static const Color white = Color(0xFFFFFFFF);
  static const Color red = Color(0xFFE93C3C); //800
  static const Color greyScale7 = Color(0xFF616161); //700
  static const Color red1 = Color(0xFFFF6B7B);
  static const Color grey = Color(0xFF6C6D75);
}

// Button Colors
class ButtonColor {
  static const Color disabled = Color(0xFFCECED1);
  static const Color secondary = Color(0xFFB89EC6);
}

// Border Colors
class BorderColor {
  static const Color grey = Color(0xFFCECED1);
  static const Color grey1 = Color(0xFFE7E7E8);
  static const Color grey3 = Color(0xFFF6F6F8);
  static const Color grey4 = Color(0xFFF4F4F6);
  static const Color grey5 = Color(0xFFF8F8F8);
  static const Color grey6 = Color(0xFF8F8F8F);
  static const Color grey7 = Color(0xFFDEDEDE);
  static const Color black2 = Color(0xFF54545E); //700
  static const Color primary = Color(0xFF00555C);
  static const Color secondary = Color(0xFFB89EC6);
  static const Color red = Color(0xFFE93C3C); //800
  static const Color surface = Color(0xFFFFFFFF);
  static const Color overlay = Color(0xFFEEEEEE);
  static const Color red1 = Color(0xFFFF6B7B);
}

// Background Colors
class BackgroundColor {
  static const Color white100 = Color(0xFFFBFBFB);
  static const Color white200 = Color(0xFFF8F8FA);
  static const Color white300 = Color(0xFFFCFCFE);
  static const Color grey1 = Color(0xFFF8F8F8);
  static const Color background = Color(0xFFFFFFFF);
  static const Color purple1 = Color(0xFF7A84FF);
  static const Color red1 = Color(0xFFFF6B7B);
  static const Color secondary = Color(0xFFB89EC6);
  static const Color grey2 = Color(0xFFF2F2F3);
  static const Color light4 = Color(0xFFFAFAFA);
  static const Color customLightGreen = Color(0xFFE8ECF2);

  static Color blackOp1 = Colors.black.withOpacity(0.1);
}

class GradientColor {
  static  LinearGradient homeHeaderGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFB721FF),// Soft purple color (at the top)
      Color(0xFF626EFD), // Light color (at the bottom)
    ],
  );
}

// Error Colors
class ErrorColor {
  static const Color error = Color(0xFFE93C3C);
  static const Color warning = Color(0xFFFFC107);
  static const Color success = Color(0xFF4CAF50);
}

// iconColors
class IconColors {
  static const Color black = Color(0xFF130F26);
  static const Color white = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF00555C);
  static const Color secondary = Color(0xFFB89EC6);
  static const Color grey6 = Color(0xFF6C6D75);
  static const Color primary1 = Color(0xFF626EFD);
  static const Color red1 = Color(0xFFFF6B7B);
}

class StatusColor {
  static const Color waitingReview = Colors.orangeAccent;
  static const Color waitingPayment = Color(0xFF4CAF50);
  static const Color shiPing = Colors.deepOrange;
  static const Color received = AppColors.secondary;
  static const Color canceled = Color(0xFFFF6B7B);
}
