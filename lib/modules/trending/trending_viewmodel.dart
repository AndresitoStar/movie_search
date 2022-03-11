import 'package:flutter/cupertino.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/trending/trending_service.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:stacked/stacked.dart';

enum TrendingContent { MOVIE, TV }

enum TrendingType { TRENDING, POPULAR }

extension ExtensionTitleTrending on TrendingType {
  String get title {
    switch (this) {
      case TrendingType.TRENDING:
        return 'Tendencia';
      case TrendingType.POPULAR:
        return 'Popular';
      default:
        return '';
    }
  }

  IconData get icon {
    switch (this) {
      case TrendingType.TRENDING:
        return MyIcons.trending;
      case TrendingType.POPULAR:
        return MyIcons.popular;
    }
  }
}

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

  String get titleTrending {
    switch (this) {
      case TrendingContent.MOVIE:
        return 'En Cines';
      case TrendingContent.TV:
        return 'En Televisión';
      default:
        return '';
    }
  }

  IconData get icon {
    switch (this) {
      case TrendingContent.MOVIE:
        return MyIcons.movie;
      case TrendingContent.TV:
        return MyIcons.tv;
    }
  }

  String get type {
    switch (this) {
      case TrendingContent.MOVIE:
        return 'movie';
      case TrendingContent.TV:
        return 'tv';
    }
  }
}

class TrendingViewModel extends BaseViewModel {
  final TrendingContent content;
  final TrendingType trendingType;
  final TrendingService _trendingService;
  final MyDatabase? _db;

  List<BaseSearchResult> _items = [];

  List<BaseSearchResult> get items => [..._items];

  bool get hasMore => _items.length < _total;

  int _total = 0;

  int get total => _total;

  int get actualPage => _actualPage;

  int _actualPage = 1;

  final Debounce _debounce = Debounce(milliseconds: 100);

  Map<String, bool>? filterGenre;

  int? year;

  updateYear(int? year) {
    this.year = year;
    synchronize();
  }

  List<int> get activeGenres => filterGenre != null
      ? filterGenre!.entries.where((element) => element.value).map<int>((e) => int.parse(e.key)).toList()
      : [];

  List<GenreTableData> _allGenres = [];

  List<String> get activeGenresNames => filterGenre != null
      ? _allGenres
          .where((element) => activeGenres.contains(int.tryParse(element.id)))
          .map<String>((e) => e.name)
          .toList()
      : [];

  TrendingViewModel(this.content, {this.trendingType = TrendingType.TRENDING})
      : _db = null,
        _trendingService = TrendingService();

  TrendingViewModel.forPage(this.content, this._items, this._total, this._db,
      {this.filterGenre = const {}, this.trendingType = TrendingType.TRENDING})
      : _trendingService = TrendingService();

  TrendingViewModel.homeHorizontal(this.content, GenreTableData genre, {this.trendingType = TrendingType.TRENDING})
      : _db = null,
        filterGenre = {genre.id: true},
        _allGenres = [genre],
        _trendingService = TrendingService();

  Future synchronize() async {
    setBusy(true);
    SearchResponse response = trendingType == TrendingType.POPULAR
        ? await _trendingService.getDiscover(content.type, genres: activeGenres)
        : await _trendingService.getTrending(content.type);
    _total = response.totalResult;
    _items = response.result;
    _actualPage = 1;
    if (_db != null) _allGenres = await _db!.allGenres(content.type);
    setBusy(false);
  }

  Future fetchMore() async {
    _debounce.run(() => _fetchMore());
  }

  Future _fetchMore() async {
    _actualPage++;
    SearchResponse results = trendingType == TrendingType.POPULAR
        ? await _trendingService.getDiscover(content.type, page: _actualPage, genres: activeGenres)
        : await _trendingService.getTrending(content.type, page: _actualPage);
    _items.addAll(results.result);
    notifyListeners();
  }

  updateFilters(Map<String, bool> filterGenre) {
    this.filterGenre = filterGenre;
    synchronize();
  }
}
