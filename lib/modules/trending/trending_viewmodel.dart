import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/trending/trending_service.dart';
import 'package:movie_search/providers/util.dart';
import 'package:stacked/stacked.dart';

enum TrendingContent { MOVIE, TV }

extension ExtensionTitle on TrendingContent {
  String get title {
    switch (this) {
      case TrendingContent.MOVIE:
        return 'Películas';
      case TrendingContent.TV:
        return 'Series';
      default:
        return '';
    }
  }

  String get type {
    switch (this) {
      case TrendingContent.MOVIE:
        return 'movie';
      case TrendingContent.TV:
        return 'tv';
      // case TMDB_API_TYPE.PERSON:
      //   return 'person';
      default:
        return null;
    }
  }
}

class TrendingViewModel extends BaseViewModel {
  final TrendingContent content;
  final TrendingService _trendingService;
  final MyDatabase _db;

  List<BaseSearchResult> _items = [];

  List<BaseSearchResult> get items => [..._items];

  bool get hasMore => _items.length < _total;

  int _total = 0;

  int get total => _total;

  int get actualPage => _actualPage;

  int _actualPage = 1;

  final Debounce _debounce = Debounce(milliseconds: 100);

  Map<String, bool> filterGenre;

  List<int> get activeGenres => filterGenre != null
      ? filterGenre.entries
          .where((element) => element.value)
          .map<int>((e) => int.parse(e.key))
          .toList()
      : [];

  List<GenreTableData> _allGenres = [];

  List<String> get activeGenresNames => filterGenre != null
      ? _allGenres
          .where((element) => activeGenres.contains(int.tryParse(element.id)))
          .map<String>((e) => e.name)
          .toList()
      : [];

  TrendingViewModel(this.content)
      : _db = null,
        _trendingService = TrendingService();

  TrendingViewModel.forPage(this.content, this._items, this._total, this._db)
      : _trendingService = TrendingService(),
        filterGenre = {};

  Future synchronize() async {
    setBusy(true);
    SearchResponse response = await _trendingService.getDiscover(
      content.type,
      genres: activeGenres,
    );
    _total = response?.totalResult ?? -1;
    _items = response?.result ?? [];
    _actualPage = 1;
    if (_db != null) _allGenres = await _db.allGenres(content.type);
    setBusy(false);
  }

  Future fetchMore() async {
    _debounce.run(() => _fetchMore());
  }

  Future _fetchMore() async {
    _actualPage++;
    SearchResponse results = await _trendingService.getDiscover(
      content.type,
      page: _actualPage,
      genres: activeGenres,
    );
    _items.addAll(results.result);
    notifyListeners();
  }

  updateFilters(Map<String, bool> filterGenre) {
    this.filterGenre = filterGenre;
    synchronize();
  }
}
