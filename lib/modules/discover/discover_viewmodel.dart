import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/model/api/models/api.dart';
import 'package:movie_search/model/api/models/tv.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/search/search_category.dart';
import 'package:movie_search/modules/trending/trending_service.dart';
import 'package:movie_search/providers/util.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

class DiscoverViewModel extends BaseViewModel {
  static const String FORM_TYPE = 'type';
  static const String FORM_GENRE = 'genre';
  static const String FORM_CAST = 'cast';
  static const String FORM_PROVIDERS = 'networks';
  static const String FORM_SORT_ORDER = 'sort_order';
  static const String FORM_SORT_DIRECTIONS = 'sort_direction';

  final MyDatabase _db;
  final FormGroup form = fb.group({
    FORM_TYPE: FormControl<SearchCategory>(value: SearchCategory.getAll().first),
    FORM_GENRE: FormControl<Set<GenreTableData>>(value: {}),
    FORM_CAST: FormControl<Set<BaseSearchResult>>(value: {}),
    FORM_PROVIDERS: FormControl<WatchProvider>(),
    FORM_SORT_ORDER: FormControl<SortOrder>(value: SortOrder.POPULARITY),
    FORM_SORT_DIRECTIONS: FormControl<SortDirection>(value: SortDirection.desc),
  });

  DiscoverViewModel(this._db) {
    typeControl.valueChanges.listen((event) {
      genresControl.updateValue({});
    });
  }

  final List<BaseSearchResult> _searchResults = [];

  List<BaseSearchResult> get searchResults => [..._searchResults];

  List<GenreTableData> _allGenres = [];

  Iterable<GenreTableData> get allFilterGenres => _allGenres.where((element) => element.type == actualCategory!.value);

  String get filterText => '${actualCategory!.label} $_activeGenres $_activeWatchProvider';

  Map<String, List<WatchProvider>> _watchProvidersMap = {};

  List<WatchProvider> get watchProviders =>
      actualCategory?.value != null && _watchProvidersMap.isNotEmpty ? _watchProvidersMap[actualCategory!.value]! : [];

  String get _activeGenres =>
      genresControl.value!.isNotEmpty ? '/ ${genresControl.value!.map((e) => e.name).join(',')} /' : '';

  String get _activeWatchProvider => providerControl.value != null ? '${providerControl.value!.providerName}' : '';

  int _total = -1;
  int _page = 1;
  int _totalPage = -1;

  bool get hasMore => searchResults.length < _total && _page < _totalPage;

  FormControl<SearchCategory> get typeControl => form.controls[FORM_TYPE] as FormControl<SearchCategory>;

  FormControl<Set<GenreTableData>> get genresControl => form.controls[FORM_GENRE] as FormControl<Set<GenreTableData>>;

  FormControl<WatchProvider> get providerControl => form.controls[FORM_PROVIDERS] as FormControl<WatchProvider>;

  FormControl<SortOrder> get sortOrderControl => form.controls[FORM_SORT_ORDER] as FormControl<SortOrder>;

  FormControl<SortDirection> get sortDirectionControl =>
      form.controls[FORM_SORT_DIRECTIONS] as FormControl<SortDirection>;

  SearchCategory? get actualCategory => typeControl.value;

  bool showFilterExpansion = true;

  toggleFilterExpansion() {
    showFilterExpansion = !showFilterExpansion;
    notifyListeners();
  }

  toggleGenreFilter(GenreTableData genre) {
    if (!genresControl.value!.remove(genre)) {
      genresControl.value!.add(genre);
    }
    genresControl.updateValueAndValidity();
  }

  toggleProvider(WatchProvider provider) {
    form.control(FORM_PROVIDERS).updateValue(provider);
  }

  initializeFilters() async {
    setBusy(true);
    _allGenres = await _db.allGenres(null);

    for (var c in SearchCategory.getAll()) {
      final list = await TrendingService().getWatchProviders(c.value);
      _watchProvidersMap.putIfAbsent(c.value, () => list);
    }
    // return search();
    setBusy(false);
  }

  Future search() async {
    setBusy(true);
    try {
      _page = 1;
      _searchResults.clear();
      SearchResponse response = await TrendingService().getDiscover(
        actualCategory!.value,
        page: _page,
        genres: genresControl.value!.map((e) => e.id).toList(),
        watchProvider: providerControl.value,
        sortDirection: sortDirectionControl.value,
        sortOrder: sortOrderControl.value,
      );
      _searchResults.addAll(response.result);
      _total = response.totalResult;
      _totalPage = response.totalPageResult;
      notifyListeners();
      setBusy(false);
    } catch (e) {
      print(e);
      setError(e);
    }
  }

  fetchMore() async {
    _page++;
    SearchResponse response = await TrendingService().getDiscover(
      actualCategory!.value,
      page: _page,
      genres: genresControl.value!.map((e) => e.id).toList(),
      watchProvider: providerControl.value,
      sortDirection: sortDirectionControl.value,
      sortOrder: sortOrderControl.value,
    );
    _searchResults.addAll(response.result);
    _total = response.totalResult;
    _totalPage = response.totalPageResult;
    notifyListeners();
  }
}
