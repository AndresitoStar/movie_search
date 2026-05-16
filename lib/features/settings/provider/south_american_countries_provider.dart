import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie_search/common/model/country.dart';
import 'package:movie_search/common/network/config_service.dart';
import 'package:movie_search/core/di/injection.dart';

part 'south_american_countries_provider.g.dart';

const Set<String> _southAmericanIsoCodes = {
  'AR',
  'BO',
  'BR',
  'CL',
  'CO',
  'EC',
  'GY',
  'PY',
  'PE',
  'SR',
  'UY',
  'VE',
};

final List<Country> _defaultCountries = [
  Country(iso31661: 'AR', name: 'Argentina', nativeName: 'Argentina'),
  Country(iso31661: 'BO', name: 'Bolivia', nativeName: 'Bolivia'),
  Country(iso31661: 'BR', name: 'Brazil', nativeName: 'Brasil'),
  Country(iso31661: 'CL', name: 'Chile', nativeName: 'Chile'),
  Country(iso31661: 'CO', name: 'Colombia', nativeName: 'Colombia'),
  Country(iso31661: 'EC', name: 'Ecuador', nativeName: 'Ecuador'),
  Country(iso31661: 'GY', name: 'Guyana', nativeName: 'Guyana'),
  Country(iso31661: 'PY', name: 'Paraguay', nativeName: 'Paraguay'),
  Country(iso31661: 'PE', name: 'Peru', nativeName: 'Perú'),
  Country(iso31661: 'SR', name: 'Suriname', nativeName: 'Suriname'),
  Country(iso31661: 'UY', name: 'Uruguay', nativeName: 'Uruguay'),
  Country(iso31661: 'VE', name: 'Venezuela', nativeName: 'Venezuela'),
];

List<Country> _decodeCountries(List<String> stored) {
  return stored
      .map((e) => Country.fromJson(jsonDecode(e) as Map<String, dynamic>))
      .toList();
}

List<String> _encodeCountries(List<Country> countries) {
  return countries.map((c) => jsonEncode(c.toJson())).toList();
}

@Riverpod(keepAlive: true)
class SouthAmericanCountries extends _$SouthAmericanCountries {
  @override
  Future<List<Country>> build() async {
    final repository = getIt<ConfigRepository>();
    try {
      final countries = await repository.getCountries();
      final southAmericanCountries = countries
          .where((c) => _southAmericanIsoCodes.contains(c.iso31661))
          .toList();

      if (southAmericanCountries.isNotEmpty) {
        return southAmericanCountries;
      }
    } catch (_) {}

    return _defaultCountries;
  }

  Future<void> resetToDefault() async {
    state = AsyncValue.data(_defaultCountries);
  }
}

@Riverpod(keepAlive: true)
class SelectedCountry extends _$SelectedCountry {
  static const String _selectedCountryKey = 'selected_country';
  static final Country _defaultCountry = _defaultCountries.firstWhere(
    (c) => c.iso31661 == 'UY',
    orElse: () => _defaultCountries[0],
  );
  late SharedPreferences _prefs;

  @override
  Future<Country> build() async {
    _prefs = await SharedPreferences.getInstance();
    final stored = _prefs.getString(_selectedCountryKey);
    if (stored != null) {
      try {
        return Country.fromJson(jsonDecode(stored) as Map<String, dynamic>);
      } catch (_) {}
    }
    return Future.value(_defaultCountry);
  }

  Future<void> setSelectedCountry(Country country) async {
    state = AsyncValue.data(country);
    await _prefs.setString(_selectedCountryKey, jsonEncode(country.toJson()));
  }
}