import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // =========================
  // 🎨 Light Colors
  // =========================
  static const Color primaryLight = Color(0xFF35AAD5);
  static const Color secondaryLight = Color(0xFF1F3E6C);
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color cardLight = Color(0xFFE1F2F8);
  static const Color textSecondaryLight = Color(0xFF6E6565);
  static const Color white = Color(0xFFFFFFFF);
  static const Color textSecondarytwoLight = Color(0xff2D3142);

  // =========================
  // 🌙 Dark Colors (مريحة للعين)
  // =========================
  static const Color primaryDark = Color(0xFF4FC3F7);
  static const Color secondaryDark = Color(0xFF90CAF9);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color cardDark = Color(0xFF1E1E1E);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);
  static const Color black = Color(0xFF000000);
  static const Color textSecondarytwoDark = Color.fromARGB(255, 94, 102, 136);

  // =========================
  // 🌞 Light Theme
  // =========================
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: backgroundLight,
    colorScheme: const ColorScheme.light(
      primary: primaryLight,
      secondary: secondaryLight,
      surface: cardLight,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundLight,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: secondaryLight),
      titleTextStyle: TextStyle(
        color: secondaryLight,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardColor: cardLight,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black),
      bodySmall: TextStyle(color: textSecondaryLight),
      
    ),
  );

  // =========================
  // 🌙 Dark Theme
  // =========================
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: backgroundDark,
    colorScheme: const ColorScheme.dark(
      primary: primaryDark,
      secondary: secondaryDark,
      surface: cardDark,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundDark,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: primaryDark),
      titleTextStyle: TextStyle(
        color: primaryDark,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardColor: cardDark,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: textSecondaryDark),
    ),
  );

  // =========================
  //  Getters للألوان حسب الـ Theme
  // =========================
  static Color primary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? primaryDark
          : primaryLight;

  static Color secondary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? secondaryDark
          : secondaryLight;

  static Color background(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? backgroundDark
          : backgroundLight;

  static Color card(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? cardDark
          : cardLight;

  static Color WB(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? black
          : white;


  static Color textSecondary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? textSecondaryDark
          : textSecondaryLight;

          static Color textSecondaryTwo(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? textSecondarytwoDark
          : textSecondarytwoLight;
}