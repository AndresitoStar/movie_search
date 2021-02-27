import 'package:movie_search/modules/splash/splash_service.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/rest/resolver.dart';
import 'package:stacked/stacked.dart';

class SplashViewModel extends FutureViewModel {
  final MyDatabase _db;
  final SplashService _splashService;

  SplashViewModel(this._db) : _splashService = SplashService.getInstance();

  @override
  Future futureToRun() {
    return Future.wait([
      syncCountries(),
      syncLanguages(),
      syncGenres('movie'),
      syncGenres('tv'),
    ]);
  }

  Future syncCountries() async {
    try {
      final bool = await _db.existCountries();
      if (bool) return;
      var countries = await _splashService.getCountries();
      final dbCountries = countries.entries
          .map((entry) => CountryTableData(iso: entry.key, name: entry.value))
          .toList();
      await _db.insertCountries(dbCountries);
    } catch (e) {
      print(e);
    }
  }

  Future syncLanguages() async {
    try {
      var bool = await _db.existLanguages();
      if (bool) return;
      var countries = await _splashService.getLanguages();
      final dbLanguages = countries.entries
          .map((entry) => LanguageTableData(iso: entry.key, name: entry.value))
          .toList();
      await _db.insertLanguages(dbLanguages);
    } catch (e) {
      print(e);
    }
  }

  Future syncGenres(String type) async {
    try {
      var bool = await _db.existGenres();
      if (bool) return;
      var genres = await _splashService.getGenres(type);
      final dbGenres = genres.entries
          .map((entry) =>
              GenreTableData(id: entry.key?.toString(), name: entry.value, type: type))
          .toList();
      await _db.insertGenres(dbGenres);
    } catch (e) {
      print(e);
    }
  }
}
