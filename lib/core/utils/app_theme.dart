// import 'package:flutter/material.dart';

// class AppTheme {
//   AppTheme._();

//   // =========================
//   // 🎨 Light Colors
//   // =========================
//   static const Color primaryLight = Color(0xFF35AAD5);
//   static const Color secondaryLight = Color(0xFF1F3E6C);
//   static const Color backgroundLight = Color(0xFFF5F5F5);
//   static const Color cardLight = Color(0xFFE1F2F8);
//   static const Color textSecondaryLight = Color(0xFF6E6565);
//   static const Color white = Color(0xFFFFFFFF);
//   static const Color textSecondarytwoLight = Color(0xff2D3142);

//   // =========================
//   // 🌙 Dark Colors (مريحة للعين)
//   // =========================
//   static const Color primaryDark = Color(0xFF4FC3F7);
//   static const Color secondaryDark = Color(0xFF90CAF9);
//   static const Color backgroundDark = Color(0xFF121212);
//   static const Color cardDark = Color(0xFF1E1E1E);
//   static const Color textSecondaryDark = Color(0xFFB0B0B0);
//   static const Color black = Color(0xFF000000);
//   static const Color textSecondarytwoDark = Color.fromARGB(255, 94, 102, 136);

//   // =========================
//   // 🌞 Light Theme
//   // =========================
//   static final ThemeData lightTheme = ThemeData(
//     brightness: Brightness.light,
//     scaffoldBackgroundColor: backgroundLight,
//     colorScheme: const ColorScheme.light(
//       primary: primaryLight,
//       secondary: secondaryLight,
//       surface: cardLight,
//     ),
//     appBarTheme: const AppBarTheme(
//       backgroundColor: backgroundLight,
//       elevation: 0,
//       surfaceTintColor: Colors.transparent,
//       iconTheme: IconThemeData(color: secondaryLight),
//       titleTextStyle: TextStyle(
//         color: secondaryLight,
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//     cardColor: cardLight,
//     textTheme: const TextTheme(
//       bodyMedium: TextStyle(color: Colors.black),
//       bodySmall: TextStyle(color: textSecondaryLight),

//     ),
//   );

//   // =========================
//   // 🌙 Dark Theme
//   // =========================
//   static final ThemeData darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     scaffoldBackgroundColor: backgroundDark,
//     colorScheme: const ColorScheme.dark(
//       primary: primaryDark,
//       secondary: secondaryDark,
//       surface: cardDark,
//     ),
//     appBarTheme: const AppBarTheme(
//       backgroundColor: backgroundDark,
//       elevation: 0,
//       surfaceTintColor: Colors.transparent,
//       iconTheme: IconThemeData(color: primaryDark),
//       titleTextStyle: TextStyle(
//         color: primaryDark,
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//     cardColor: cardDark,
//     textTheme: const TextTheme(
//       bodyMedium: TextStyle(color: Colors.white),
//       bodySmall: TextStyle(color: textSecondaryDark),
//     ),
//   );

//   // =========================
//   //  Getters للألوان حسب الـ Theme
//   // =========================
//   static Color primary(BuildContext context) =>
//       Theme.of(context).brightness == Brightness.dark
//           ? primaryDark
//           : primaryLight;

//   static Color secondary(BuildContext context) =>
//       Theme.of(context).brightness == Brightness.dark
//           ? secondaryDark
//           : secondaryLight;

//   static Color background(BuildContext context) =>
//       Theme.of(context).brightness == Brightness.dark
//           ? backgroundDark
//           : backgroundLight;

//   static Color card(BuildContext context) =>
//       Theme.of(context).brightness == Brightness.dark
//           ? cardDark
//           : cardLight;

//   static Color WB(BuildContext context) =>
//       Theme.of(context).brightness == Brightness.dark
//           ? black
//           : white;

//   static Color textSecondary(BuildContext context) =>
//       Theme.of(context).brightness == Brightness.dark
//           ? textSecondaryDark
//           : textSecondaryLight;

//           static Color textSecondaryTwo(BuildContext context) =>
//       Theme.of(context).brightness == Brightness.dark
//           ? textSecondarytwoDark
//           : textSecondarytwoLight;
// }

import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // ---------------------------------------------------------
  // 🎨 الألوان المباشرة (Palette)
  // ---------------------------------------------------------

  // 1. Surface Color
  static const Color _surfL = Color(0xFFE1F2F8);
  static const Color _surfD = Color(0xFF494646);

  // 2. Primary/Secondary Switch (الكحلي مقابل السماوي)
  static const Color _secL = Color(0xFF1F3E6C);
  static const Color _priD = Color(0xFF35AAD5);

  // 3. Opacity Colors (22%)
  static const Color _secOpacityL = Color(0x381F3E6C);
  static const Color _priD_fromOpacity = Color(0xFF35AAD5);

  // 4. Contrast Color (Text/Icons)
  static const Color _contrastL = Color(0xFF1F3E6C);
  static const Color _contrastD = Color(0xFFFFFFFF);

  // 5. Secondary Surface/Grey
  static const Color _surfSecondaryL = Color(0xFFE1F2F8);
  static const Color _greyD = Color(0xFF9C9C9C);

  // 6. Main Branding Switch (السماوي مقابل الكحلي)
  static const Color _priL = Color(0xFF35AAD5);
  static const Color _secD = Color(0xFF1F3E6C);

  // 7. Opacity Colors (39%)
  static const Color _surfOpacityL = Color(0x63E1F2F8);
  static const Color _greyVariantD = Color(0xFF6F6F70);

  // 8. Service Provider Specialty text
  static const Color _spSL = Color(0xFF6E6565);
  static const Color _spSD = Color(0xFFDADADA);

  // 9. Service Provider background
  static const Color _spBL = Color(0xFFFFFFFF);
  static const Color _spBD = Color(0xFF494646);

  // 10. Scaffold Backgrounds (خلفية الصفحات)
  static const Color _bgL = Color(0xFFFFFFFF); // أبيض في اللايت
  static const Color _bgD = Color(0xFF121212); // أسود في الدارك

  // ---------------------------------------------------------
  // 🌞 تعريف الثيمات (ThemeData)
  // ---------------------------------------------------------
static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: _bgL,
    // السطر ده بيضمن إن الـ AppBar مياخدش ألوان عشوائية وقت السكرول
    colorScheme: ColorScheme.fromSeed(
      seedColor: _priL,
      brightness: Brightness.light,
      surface: _bgL,
    ).copyWith(
      primary: _priL,
      secondary: _secL,
      surfaceVariant: const Color(0x63E1F2F8),
      secondaryContainer: const Color(0x381F3E6C),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _bgL,
      surfaceTintColor: Colors.transparent, // الحل اللي اشتغل معاكي
      scrolledUnderElevation: 0.0,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: _contrastL),
      titleTextStyle: TextStyle(color: _contrastL, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Tajawal"),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: _bgD,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _priD,
      brightness: Brightness.dark,
      surface: _bgD,
    ).copyWith(
      primary: _priD,
      secondary: _secD,
      surfaceVariant: const Color(0xFF6F6F70),
      secondaryContainer: _priD,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _bgD,
      surfaceTintColor: Colors.transparent, // الحل اللي اشتغل معاكي
      scrolledUnderElevation: 0.0,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: _contrastD),
      titleTextStyle: TextStyle(color: _contrastD, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Tajawal"),
    ),
  );
  // ---------------------------------------------------------
  // 🛠 Getters للنداء السهل في الـ UI
  // ---------------------------------------------------------

  // خلفية الصفحة (المجموعة 10)
  static Color background(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light ? _bgL : _bgD;

  // اللون الرئيسي للبراند (المجموعة 6)
  static Color primary(BuildContext context) =>
      Theme.of(context).colorScheme.primary;

  // اللون الثانوي / الكحلي (المجموعة 2)
  static Color brandColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light ? _secL : _priD;

  // التباين الأساسي (المجموعة 4)
  static Color mainContrast(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
      ? _contrastL
      : _contrastD;

  // الحاويات والأسطح (المجموعة 1)
  static Color surfaceContainer(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light ? _surfL : _surfD;

  // الألوان الشفافة (المجموعة 3 و 7)
  static Color opacityAccent(BuildContext context) =>
      Theme.of(context).colorScheme.secondaryContainer;

  static Color opacitySurface(BuildContext context) =>
      Theme.of(context).colorScheme.surfaceVariant;

  // ألوان الـ Service Provider (المجموعة 8 و 9)
  static Color spStext(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light ? _spSL : _spSD;

  static Color spB(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light ? _spBL : _spBD;

  // لتبديل اللون الرمادي (المجموعة 5)
  static Color surfaceToGrey(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
      ? _surfSecondaryL
      : _greyD;
}
