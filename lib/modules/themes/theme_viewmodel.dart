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
        transparentStatusBar: true,
        appBarElevation: 0,
        appBarStyle: FlexAppBarStyle.background,
      ).toTheme.copyWith(
            inputDecorationTheme: baseTheme.copyWith(fillColor: Colors.black12),
            elevatedButtonTheme: baseElevatedButtonThemeData,
            cardTheme: cardTheme,
            // textTheme: baseTextTheme,
          );

  ThemeData get darkTheme => FlexColorScheme.dark(
        scheme: flexColor,
        transparentStatusBar: true,
        appBarElevation: 0,
        appBarStyle: FlexAppBarStyle.background,
      ).toTheme.copyWith(
            inputDecorationTheme: baseTheme.copyWith(fillColor: Colors.white12),
            elevatedButtonTheme: baseElevatedButtonThemeData,
            cardTheme: cardTheme,
            // textTheme: baseTextTheme,
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
  TextTheme get googleTheme => GoogleFonts.sourceSansProTextTheme();

  TextTheme get baseTextTheme => googleTheme.copyWith(
        displayLarge: googleTheme.displayLarge!.copyWith(fontSize: 57.dp),
        displayMedium: googleTheme.displayMedium!.copyWith(fontSize: 45.dp),
        displaySmall: googleTheme.displaySmall!.copyWith(fontSize: 36.dp),
        headlineLarge: googleTheme.headlineLarge!.copyWith(fontSize: 32.dp),
        headlineMedium: googleTheme.headlineMedium!.copyWith(fontSize: 28.dp),
        headlineSmall: googleTheme.headlineSmall!.copyWith(fontSize: 24.dp),
        titleLarge: googleTheme.titleLarge!.copyWith(fontSize: 22.dp),
        titleMedium: googleTheme.titleMedium!.copyWith(fontSize: 16.dp),
        titleSmall: googleTheme.titleSmall!.copyWith(fontSize: 14.dp),
        labelLarge: googleTheme.labelLarge!.copyWith(fontSize: 14.dp),
        labelMedium: googleTheme.labelMedium!.copyWith(fontSize: 12.dp),
        labelSmall: googleTheme.labelSmall!.copyWith(fontSize: 11.dp),
        bodyLarge: googleTheme.bodyLarge!.copyWith(fontSize: 16.dp),
        bodyMedium: googleTheme.bodyMedium!.copyWith(fontSize: 14.dp),
        bodySmall: googleTheme.bodySmall!.copyWith(fontSize: 12.dp),
      );
}
