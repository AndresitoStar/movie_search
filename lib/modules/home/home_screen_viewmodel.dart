import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/splash/splash_service.dart';
import 'package:movie_search/modules/trending/trending_service.dart';
import 'package:movie_search/modules/trending/trending_viewmodel.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

class AllGenre extends GenreTableData {
  AllGenre(String type) : super(type: type, id: null, name: 'Todos');
}

class HomeScreenViewModel extends BaseViewModel {
  final MyDatabase _db;
  static const String FORM_TYPE = 'formType';
  static const String FORM_GENRE = 'formGenre';

  Map<TrendingContent, List<GenreTableData>> _genresMap = {};

  Map<TrendingContent, List<GenreTableData>> get genresMap => {..._genresMap};

  Map<String, List<BaseSearchResult>> _popularMap = {};

  Map<String, List<BaseSearchResult>> get popularMapFull => {..._popularMap};

  Map<TrendingContent, Map<GenreTableData, List<BaseSearchResult>>> _trendingMap = {};

  Map<GenreTableData, List<BaseSearchResult>> get trendingMap =>
      _trendingMap.containsKey(typeSelected) ? _trendingMap[typeSelected] : {};

  Future<List<BaseSearchResult>> getTrendingListData(GenreTableData genre) async {
    print(genre.name);
    if (_trendingMap.containsKey(typeSelected) &&
        _trendingMap[typeSelected].containsKey(genre) &&
        _trendingMap[typeSelected][genre].isNotEmpty) {
      return _trendingMap[typeSelected][genre];
    }
    final list = await TrendingService().getDiscover(typeSelected.type, genres: [int.tryParse(genre.id)]);
    _trendingMap[typeSelected].update(genre, (value) => list.result);
    return _trendingMap[typeSelected][genre];
  }

  List<BaseSearchResult> get popularMap {
    final key = '${genreSelected?.type}${genreSelected?.id ?? ''}';
    return genreSelected != null && _popularMap.containsKey(key) ? _popularMap[key] : null;
  }

  final FormGroup form = fb.group({
    FORM_TYPE: FormControl<TrendingContent>(value: TrendingContent.values.first),
    FORM_GENRE: FormControl<GenreTableData>(value: AllGenre(TrendingContent.values.first.type)),
  });

  FormControl<TrendingContent> get typeControl => this.form.controls[FORM_TYPE];

  TrendingContent get typeSelected => typeControl.value;

  FormControl<GenreTableData> get genreControl => this.form.controls[FORM_GENRE];

  GenreTableData get genreSelected => genreControl.value;

  HomeScreenViewModel(this._db);

  selectType(TrendingContent type) {
    typeControl.updateValue(type);
    selectGenre(AllGenre(type.type));
  }

  selectGenre(GenreTableData genre) async {
    genreControl.updateValue(genre);
    final key = '${genre.type}${genre.id ?? ''}';
    if (!_popularMap.containsKey(key)) {
      final response =
          await TrendingService().getDiscover(genre.type, genres: genre != null ? [int.tryParse(genre.id)] : null);
      _popularMap.putIfAbsent(key, () => response.result);
    }
    notifyListeners();
  }

  Future synchronize() async {
    setBusy(true);
    // Fetching populars
    await Future.wait(TrendingContent.values.map(
      (t) async {
        if (!_popularMap.containsKey(t.type)) {
          final response = await TrendingService().getTrending(t.type);
          _popularMap.putIfAbsent(t.type, () => response.result);
        }
      },
    ).toList());
    // Fetching genres
    await Future.wait(TrendingContent.values.map((t) async {
      List<GenreTableData> list = await _db.allGenres(t.type);
      if (list.isEmpty) list = await _syncGenres(t.type);
      _genresMap.putIfAbsent(t, () => [/*AllGenre(t.type), */ ...list]);
      _trendingMap.putIfAbsent(
          t, () => Map.fromIterable(list.sublist(0, 5), key: (element) => element, value: (_) => []));
    }).toList());
    setBusy(false);
  }

  Future<List<GenreTableData>> _syncGenres(String type) async {
    try {
      var bool = await _db.existGenres(type);
      if (bool) return [];
      var genres = await SplashService.getInstance().getGenres(type);
      final dbGenres = genres.entries
          .map((entry) => GenreTableData(id: entry.key?.toString(), name: entry.value, type: type))
          .toList();
      await _db.insertGenres(dbGenres);
      return dbGenres;
    } catch (e) {
      print(e);
    }
    return [];
  }
}
