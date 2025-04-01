import 'package:movie_search/model/api/models/country.dart';
import 'package:movie_search/model/api/models/genre.dart';
import 'package:movie_search/modules/splash/splash_service.dart';
import 'package:movie_search/providers/util.dart';

class ConfigSingleton {
  static ConfigSingleton? _instance;

  static ConfigSingleton get instance {
    if (_instance == null) _instance = ConfigSingleton._();
    return _instance!;
  }

  ConfigSingleton._();

  final Map<String, List<Genre>> _cacheGenres = {};
  final List<Country> _cacheCountries = [];

  List<Genre> getGenresByType(String type) {
    return _cacheGenres[type] ?? [];
  }

  List<Country> get countries => _cacheCountries;

  Future syncGenres() async {
    if (_cacheGenres.isNotEmpty) return;
    final types = [
      TMDB_API_TYPE.MOVIE,
      TMDB_API_TYPE.TV_SHOW,
    ];
    for (final type in types) {
      if (_cacheGenres.containsKey(type)) return _cacheGenres[type]!;
      final genres =
          await SplashService.getInstance().getGenreByType(type.type);
      _cacheGenres[type.type] = genres;
    }
  }

  Future syncCountries() async {
    if (_cacheCountries.isNotEmpty) return _cacheCountries;
    _cacheCountries.addAll(await SplashService.getInstance().getCountries());
  }
}
