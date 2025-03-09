import 'package:movie_search/model/api/models/genre.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/splash/config_singleton.dart';
import 'package:movie_search/modules/trending/trending_service.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/widgets/extensions.dart';
import 'package:stacked/stacked.dart';

enum TrendingContent { MOVIE, TV, PERSON }

enum TrendingType { TRENDING, POPULAR }

class TrendingViewModel extends BaseViewModel {
  final TrendingContent content;
  final TrendingType trendingType;
  final TrendingService _trendingService;

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
      ? filterGenre!.entries
          .where((element) => element.value)
          .map<int>((e) => int.parse(e.key))
          .toList()
      : [];

  List<Genre> _allGenres = [];

  List<String> get activeGenresNames => filterGenre != null
      ? _allGenres
          .where((element) => activeGenres.contains(int.tryParse(element.id)))
          .map<String>((e) => e.name)
          .toList()
      : [];

  TrendingViewModel(this.content, {this.trendingType = TrendingType.TRENDING})
      : _trendingService = TrendingService();

  TrendingViewModel.forPage(this.content, this._items, this._total,
      {this.filterGenre = const {}, this.trendingType = TrendingType.TRENDING})
      : _trendingService = TrendingService();

  TrendingViewModel.homeHorizontal(this.content, Genre genre,
      {this.trendingType = TrendingType.TRENDING})
      : filterGenre = {genre.id: true},
        _allGenres = [genre],
        _trendingService = TrendingService();

  Future synchronize() async {
    setBusy(true);
    SearchResponse response = trendingType == TrendingType.POPULAR
        ? await _trendingService.getPopular(content.type)
        : await _trendingService.getTrending(content.type);
    _total = response.totalResult;
    _items = response.result;
    _actualPage = 1;
    _allGenres = await ConfigSingleton.instance.getGenresByType(content.type);
    setBusy(false);
  }

  Future fetchMore() async {
    _debounce.run(() => _fetchMore());
  }

  Future _fetchMore() async {
    _actualPage++;
    SearchResponse results = trendingType == TrendingType.POPULAR
        ? await _trendingService.getDiscover(content.type, page: _actualPage)
        : await _trendingService.getTrending(content.type, page: _actualPage);
    _items.addAll(results.result);
    notifyListeners();
  }

  updateFilters(Map<String, bool> filterGenre) {
    this.filterGenre = filterGenre;
    synchronize();
  }
}
