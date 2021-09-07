import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/providers/util.dart';
import 'package:stacked/stacked.dart';

class ThemeViewModel extends BaseViewModel {
  FlexScheme _flexColor;
  final ThemeMode themeMode;
  bool drawerOpened = false;

  FlexScheme get flexColor => _flexColor;

  toggleOpenDrawer() {
    drawerOpened = !drawerOpened;
    notifyListeners();
  }

  ThemeViewModel(this._flexColor, {this.themeMode});

  bool get isDark => themeMode == ThemeMode.dark;

  setColor(FlexScheme color) {
    this._flexColor = color;
    SharedPreferencesHelper.setFlexSchemaColor(color.toString());
    notifyListeners();
  }

  ThemeData get theme => FlexColorScheme.light(
        scheme: flexColor,
        fontFamily: 'Dosis',
        transparentStatusBar: true,
        appBarElevation: 0,
        appBarStyle: FlexAppBarStyle.background,
      ).toTheme.copyWith(inputDecorationTheme: baseTheme);

  ThemeData get darkTheme => FlexColorScheme.dark(
        scheme: flexColor,
        fontFamily: 'Dosis',
        transparentStatusBar: true,
        appBarElevation: 0,
        appBarStyle: FlexAppBarStyle.background,
      ).toTheme.copyWith(inputDecorationTheme: baseTheme);

  InputDecorationTheme get baseTheme => InputDecorationTheme(
        isDense: false,
        isCollapsed: false,
        filled: true,
        fillColor: Colors.white12,
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
}
