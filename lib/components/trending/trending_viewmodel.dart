import 'package:movie_search/components/trending/trending_service.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
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
}

class TrendingViewModel extends BaseViewModel {

  final TrendingContent content;
  final TrendingService _trendingService;

  List<AudiovisualProvider> _items = [];

  List<AudiovisualProvider> get items => [..._items];

  bool get hasMore => _items.length < _total;

  int _total = 0;

  int get totalSearchResult => _total;

  int get actualPage => _actualPage;

  int _actualPage = 1;

  final Debounce _debounce = Debounce(milliseconds: 100);

  TrendingViewModel(this.content) : _trendingService = TrendingService();

  Future synchronize() async {
    TMDB_API_TYPE type;
    switch (content) {
      case TrendingContent.MOVIE:
        type = TMDB_API_TYPE.MOVIE;
        break;
      case TrendingContent.TV:
        type = TMDB_API_TYPE.TV_SHOW;
        break;
    }
    SearchResponse response = await _trendingService.getTrending(type);
    _total = response?.totalResult ?? -1;
    _items = response?.result ?? [];
    notifyListeners();
  }

  Future fetchMore() async {
    _debounce.run(() => _fetchMore());
  }

  Future _fetchMore() async {
    _actualPage++;
    SearchResponse results;
    switch (content) {
      case TrendingContent.MOVIE:
        results = await _trendingService.getTrending(TMDB_API_TYPE.MOVIE,
            page: _actualPage);
        break;
      case TrendingContent.TV:
        results = await _trendingService.getTrending(TMDB_API_TYPE.TV_SHOW,
            page: _actualPage);
        break;
    }
    _items.addAll(results.result);
    notifyListeners();
  }
}