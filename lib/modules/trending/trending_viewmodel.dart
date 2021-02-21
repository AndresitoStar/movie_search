import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/model/movie.dart';
import 'package:movie_search/modules/audiovisual/model/serie.dart';
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

  Type get baseType {
    switch (this) {
      case TrendingContent.MOVIE:
        return Movie().runtimeType;
      case TrendingContent.TV:
        return TvShow().runtimeType;
    // case TMDB_API_TYPE.PERSON:
    //   return 'person';
      default:
        return null;
    }
  }
}

class TrendingViewModel<T extends ModelBase> extends BaseViewModel {
  final TrendingContent content;
  final TrendingService _trendingService;

  List<ModelBase> _items = [];

  List<ModelBase> get items => [..._items];

  bool get hasMore => _items.length < _total;

  int _total = 0;

  int get total => _total;

  int get actualPage => _actualPage;

  int _actualPage = 1;

  final Debounce _debounce = Debounce(milliseconds: 100);

  TrendingViewModel(this.content) : _trendingService = TrendingService();

  TrendingViewModel.forPage(this.content, this._items, this._total)
      : _trendingService = TrendingService();

  Future synchronize() async {
    TrendingResponse response =
        await _trendingService.getTrending<T>(content.type);
    _total = response?.totalResult ?? -1;
    _items = response?.result ?? [];
    notifyListeners();
  }

  Future fetchMore() async {
    _debounce.run(() => _fetchMore());
  }

  Future _fetchMore() async {
    _actualPage++;
    TrendingResponse results =
        await _trendingService.getTrending<T>(content.type, page: _actualPage);
    _items.addAll(results.result);
    notifyListeners();
  }
}
