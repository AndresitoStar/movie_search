// class with riverpod_generator to manage app theme (light/dark)
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@Riverpod(keepAlive: true)
class ThemeProvider extends _$ThemeProvider {
  static const String _themeModeKey = 'app_theme_mode';
  late SharedPreferences _prefs;

  @override
  Future<ThemeMode> build() async {
    _prefs = await SharedPreferences.getInstance();
    final themeIndex = _prefs.getInt(_themeModeKey) ?? 0;
    return Future.value(ThemeMode.values[themeIndex]);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = AsyncValue.data(mode);
    await _prefs.setInt(_themeModeKey, mode.index);
  }

  switchThemeMode() {
    final currentMode = state.asData?.value ?? ThemeMode.system;
    ThemeMode newMode;
    switch (currentMode) {
      case ThemeMode.light:
        newMode = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        newMode = ThemeMode.light;
        break;
      case ThemeMode.system:
        newMode = ThemeMode.light;
        break;
    }
    setThemeMode(newMode);
  }
}
