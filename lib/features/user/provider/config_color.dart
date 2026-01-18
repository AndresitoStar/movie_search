import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'config_color.g.dart';

@Riverpod(keepAlive: true)
class ColorConfig extends _$ColorConfig {
  static const String _colorSchemeKey = 'app_color_scheme';
  late SharedPreferences _prefs;

  @override
  Future<FlexScheme> build() async {
    _prefs = await SharedPreferences.getInstance();
    final colorSchemeName = _prefs.getString(_colorSchemeKey);

    // If no color is saved, return default (hippieBlue)
    if (colorSchemeName == null) {
      return FlexScheme.hippieBlue;
    }

    // Try to parse the saved color scheme name
    try {
      return FlexScheme.values.firstWhere(
        (scheme) => scheme.name == colorSchemeName,
        orElse: () => FlexScheme.hippieBlue,
      );
    } catch (e) {
      return FlexScheme.hippieBlue;
    }
  }

  /// Set the color scheme and save to local storage
  Future<void> setColorScheme(FlexScheme scheme) async {
    state = AsyncValue.data(scheme);
    await _prefs.setString(_colorSchemeKey, scheme.name);
  }

  /// Get all available color schemes
  List<FlexScheme> get availableSchemes => FlexScheme.values;
}

/// Provider to get the current color scheme
@riverpod
FlexScheme currentColorScheme(ref) {
  final colorConfig = ref.watch(colorConfigProvider);
  return colorConfig.when(
    data: (scheme) => scheme,
    loading: () => FlexScheme.hippieBlue,
    error: (_, __) => FlexScheme.hippieBlue,
  );
}
