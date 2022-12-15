import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/splash/splash_service.dart';
import 'package:stacked/stacked.dart';

class TrendingFilterViewModel extends FutureViewModel {
  Map<String, bool> _filterGenre = {};

  Map<String, bool> get filterGenre => {..._filterGenre};

  List<GenreTableData> _genres = [];

  List<GenreTableData> get genres => [..._genres];

  final MyDatabase _db;
  final SplashService _splashService;

  final String type;

  TrendingFilterViewModel(this._db, this.type, this._filterGenre) : _splashService = SplashService.getInstance();

  toggle(String genre) {
    final newValue = !filterGenre[genre]!;
    _filterGenre.update(genre, (v) => newValue);
    notifyListeners();
  }

  clear() {
    _filterGenre.updateAll((k, v) => false);
    notifyListeners();
  }

  Future<List<GenreTableData>> syncGenres(String type) async {
    try {
      var bool = await _db.existGenres(type);
      if (bool) return [];
      var genres = await _splashService.getGenres(type);
      final dbGenres = genres.entries
          .map((entry) => GenreTableData(id: entry.key.toString(), name: entry.value, type: type))
          .toList();
      await _db.insertGenres(dbGenres);
      return dbGenres;
    } catch (e) {
      print(e);
    }
    return [];
  }

  @override
  Future futureToRun() async {
    setBusy(true);
    _genres = await _db.allGenres(type);
    if (_genres.isEmpty) {
      _genres = await syncGenres(type);
    }
    if (_filterGenre.isEmpty)
      _filterGenre = Map.fromIterable(_genres, key: (v) => '${v.providerId}', value: (v) => false);
    setBusy(false);
  }
}
