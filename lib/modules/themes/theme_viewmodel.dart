import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_search/providers/util.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stacked/stacked.dart';

class ThemeViewModel extends BaseViewModel {
  static ThemeViewModel of(BuildContext context) => Provider.of<ThemeViewModel>(context, listen: false);

  FlexScheme _flexColor;
  final ThemeMode themeMode;
  bool drawerOpened = false;

  FlexScheme get flexColor => _flexColor;

  toggleOpenDrawer() {
    drawerOpened = !drawerOpened;
    notifyListeners();
  }

  ThemeViewModel(this._flexColor, {required this.themeMode});

  bool get isDark => themeMode == ThemeMode.dark;

  setColor(FlexScheme color) {
    this._flexColor = color;
    SharedPreferencesHelper.setFlexSchemaColor(color.toString());
    notifyListeners();
  }

  ThemeData get theme => FlexColorScheme.light(
        scheme: flexColor,
        // transparentStatusBar: true,
        appBarElevation: 0,
        appBarStyle: FlexAppBarStyle.primary,
      ).toTheme.copyWith(
            inputDecorationTheme: baseTheme.copyWith(fillColor: Colors.black12),
            elevatedButtonTheme: baseElevatedButtonThemeData,
            cardTheme: cardTheme,
            textTheme: baseTextTheme(GoogleFonts.nunitoTextTheme()),
          );

  ThemeData get darkTheme => FlexColorScheme.dark(
        scheme: flexColor,
        // transparentStatusBar: true,
        appBarElevation: 0,
        appBarStyle: FlexAppBarStyle.primary,
      ).toTheme.copyWith(
            inputDecorationTheme: baseTheme.copyWith(fillColor: Colors.white12),
            elevatedButtonTheme: baseElevatedButtonThemeData,
            cardTheme: cardTheme,
            brightness: Brightness.dark,
            textTheme: baseTextTheme(GoogleFonts.nunitoTextTheme(ThemeData(brightness: Brightness.dark).textTheme)),
          );

  final OutlinedBorder _buttonsBorder = RoundedRectangleBorder(borderRadius: BorderRadius.circular(15));

  CardTheme get cardTheme => CardTheme(shape: _buttonsBorder);

  ElevatedButtonThemeData get baseElevatedButtonThemeData => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: _buttonsBorder,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      );

  InputDecorationTheme get baseTheme => InputDecorationTheme(
        isDense: false,
        isCollapsed: false,
        filled: false,
        // fillColor: Colors.white12,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 8.0,
        ),
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      );

  TextTheme baseTextTheme(TextTheme baseTheme) {
    return baseTheme.copyWith(
      displayLarge: baseTheme.displayLarge!.copyWith(fontSize: 57.sp),
      displayMedium: baseTheme.displayMedium!.copyWith(fontSize: 45.sp),
      displaySmall: baseTheme.displaySmall!.copyWith(fontSize: 36.sp),
      headlineLarge: baseTheme.headlineLarge!.copyWith(fontSize: 28.sp),
      headlineMedium: baseTheme.headlineMedium!.copyWith(fontSize: 24.sp),
      headlineSmall: baseTheme.headlineSmall!.copyWith(fontSize: 20.sp),
      titleLarge: baseTheme.titleLarge!.copyWith(fontSize: 18.sp),
      titleMedium: baseTheme.titleMedium!.copyWith(fontSize: 16.sp),
      titleSmall: baseTheme.titleSmall!.copyWith(fontSize: 14.sp),
      labelLarge: baseTheme.labelLarge!.copyWith(fontSize: 14.sp),
      labelMedium: baseTheme.labelMedium!.copyWith(fontSize: 12.sp),
      labelSmall: baseTheme.labelSmall!.copyWith(fontSize: 11.sp),
      bodyLarge: baseTheme.bodyLarge!.copyWith(fontSize: 16.sp),
      bodyMedium: baseTheme.bodyMedium!.copyWith(fontSize: 14.sp),
      bodySmall: baseTheme.bodySmall!.copyWith(fontSize: 12.sp),
    );
  }
}
