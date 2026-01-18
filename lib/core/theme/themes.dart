import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  //Singleton pattern
  Themes._privateConstructor();
  static final Themes _instance = Themes._privateConstructor();
  factory Themes() {
    return _instance;
  }

  final ThemeMode themeMode = ThemeMode.dark;
  bool get isDark => themeMode == ThemeMode.dark;

  ThemeData theme(FlexScheme flexColor) {
    return FlexColorScheme.light(
      scheme: flexColor,
      // transparentStatusBar: true,
      appBarElevation: 0,
      appBarStyle: FlexAppBarStyle.background,
    ).toTheme.copyWith(
      inputDecorationTheme: inputDarkTheme,
      elevatedButtonTheme: baseElevatedButtonThemeData,
      outlinedButtonTheme: baseOutlinedButtonThemeData,
      cardTheme: cardTheme,
      textTheme: baseTextTheme(GoogleFonts.nunitoTextTheme()),
    );
  }

  ThemeData darkTheme(FlexScheme flexColor) {
    return FlexColorScheme.dark(
      scheme: flexColor,
      // transparentStatusBar: true,
      appBarElevation: 0,
      appBarStyle: FlexAppBarStyle.background,
    ).toTheme.copyWith(
      inputDecorationTheme: inputLightTheme,
      elevatedButtonTheme: baseElevatedButtonThemeData,
      outlinedButtonTheme: baseOutlinedButtonThemeData,
      cardTheme: cardTheme,
      brightness: Brightness.dark,
      textTheme: baseTextTheme(GoogleFonts.nunitoTextTheme(ThemeData(brightness: Brightness.dark).textTheme)),
    );
  }

  final OutlinedBorder _buttonsBorder = RoundedRectangleBorder(borderRadius: BorderRadius.circular(5));

  CardThemeData get cardTheme =>
      CardThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), elevation: 2);

  ElevatedButtonThemeData get baseElevatedButtonThemeData => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: _buttonsBorder,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    ),
  );

  OutlinedButtonThemeData get baseOutlinedButtonThemeData => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: _buttonsBorder,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    ),
  );

  InputDecorationTheme get inputLightTheme => InputDecorationTheme(
    isDense: false,
    isCollapsed: false,
    filled: true,
    fillColor: Colors.black12,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 16),
    labelStyle: TextStyle(color: Colors.grey.shade700, fontSize: 14),
    floatingLabelStyle: TextStyle(color: Colors.grey.shade700),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: Colors.grey.shade500, width: 1.2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Colors.red),
    ),
  );

  InputDecorationTheme get inputDarkTheme => InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF1E1E1E), // fondo del input
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),
    labelStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
    floatingLabelStyle: TextStyle(color: Colors.grey.shade300),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: Colors.grey.shade700, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: Colors.grey.shade700, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: Colors.grey.shade500, width: 1.2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Colors.redAccent),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Colors.redAccent),
    ),
  );

  TextTheme baseTextTheme(TextTheme baseTheme) {
    return baseTheme.copyWith(
      displayLarge: baseTheme.displayLarge!.copyWith(fontSize: 57),
      displayMedium: baseTheme.displayMedium!.copyWith(fontSize: 45),
      displaySmall: baseTheme.displaySmall!.copyWith(fontSize: 36),
      headlineLarge: baseTheme.headlineLarge!.copyWith(fontSize: 28),
      headlineMedium: baseTheme.headlineMedium!.copyWith(fontSize: 24),
      headlineSmall: baseTheme.headlineSmall!.copyWith(fontSize: 20),
      titleLarge: baseTheme.titleLarge!.copyWith(fontSize: 18),
      titleMedium: baseTheme.titleMedium!.copyWith(fontSize: 16),
      titleSmall: baseTheme.titleSmall!.copyWith(fontSize: 14),
      labelLarge: baseTheme.labelLarge!.copyWith(fontSize: 14),
      labelMedium: baseTheme.labelMedium!.copyWith(fontSize: 12),
      labelSmall: baseTheme.labelSmall!.copyWith(fontSize: 11),
      bodyLarge: baseTheme.bodyLarge!.copyWith(fontSize: 16),
      bodyMedium: baseTheme.bodyMedium!.copyWith(fontSize: 14),
      bodySmall: baseTheme.bodySmall!.copyWith(fontSize: 12),
    );
  }
}
