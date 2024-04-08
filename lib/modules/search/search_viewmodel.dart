import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/search/search_category.dart';
import 'package:movie_search/modules/search/search_service.dart';
import 'package:movie_search/modules/trending/trending_service.dart';
import 'package:movie_search/providers/util.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

class SearchViewModel extends BaseViewModel {
  final SearchService _service;
  final MyDatabase _db;
  final FormGroup form = fb.group({
    FORM_QUERY: FormControl<String>(value: ''),
    'filter': fb.group({
      FORM_TYPE: FormControl<SearchCategory>(value: SearchCategory.getAll().first),
      FORM_GENRE: FormControl<Set<GenreTableData>>(value: {}),
      FORM_CAST: FormControl<Set<BaseSearchResult>>(value: {}),
    }),
  });

  final List<BaseSearchResult> _searchResults = [];

  List<BaseSearchResult> get searchResults => [..._searchResults];

  List<GenreTableData> _allGenres = [];

  Iterable<GenreTableData> get allFilterGenres => _allGenres.where((element) => element.type == actualCategory!.value);

  FormGroup get filterForm => form.control('filter') as FormGroup;

  String get filterText => '${actualCategory!.label} $_activeGenres';

  String get _activeGenres =>
      genresControl.value!.isNotEmpty ? '(${genresControl.value!.map((e) => e.name).join(',')})' : '';

  int _total = -1;
  int _page = 1;
  int _totalPage = -1;

  bool get hasMore => searchResults.length < _total && _page < _totalPage;

  final _debounce = Debounce(milliseconds: 300);

  static const String FORM_QUERY = 'formQuery';
  static const String FORM_TYPE = 'type';
  static const String FORM_GENRE = 'genre';
  static const String FORM_CAST = 'cast';

  FormControl<String> get queryControl => this.form.controls[FORM_QUERY] as FormControl<String>;

  FormControl<SearchCategory> get typeControl => filterForm.controls[FORM_TYPE] as FormControl<SearchCategory>;

  FormControl<Set<GenreTableData>> get genresControl =>
      filterForm.controls[FORM_GENRE] as FormControl<Set<GenreTableData>>;

  SearchCategory? get actualCategory => typeControl.value;

  String get _query => queryControl.value ?? '';

  bool showFilter = false;
  bool showFilterExpansion = true;

  toggleFilterExpansion() {
    showFilterExpansion = !showFilterExpansion;
    notifyListeners();
  }

  toggleFilter() {
    showFilter = !showFilter;
    showFilterExpansion = true;
    // print(filterForm.value);
    filterForm.reset(value: {
      FORM_TYPE: SearchCategory.getAll().first,
      FORM_GENRE: <GenreTableData>{},
      FORM_CAST: <BaseSearchResult>{},
    });

    notifyListeners();
  }

  toggleGenreFilter(GenreTableData genre) {
    if (!genresControl.value!.remove(genre)) {
      genresControl.value!.add(genre);
    }
    genresControl.updateValueAndValidity();
  }

  SearchViewModel(this._service, this._db) {
    final onData = (event) {
      _debounce.run(() async {
        await search();
      });
    };
    queryControl.valueChanges.listen(onData);
    typeControl.valueChanges.listen((event) {
      genresControl.updateValue({});
    });
  }

  initializeFilters() async {
    _allGenres = await _db.allGenres(null);
  }

  Future search() async {
    setBusy(true);
    try {
      _page = 1;
      _searchResults.clear();
      if (queryControl.isNullOrEmpty && !showFilter) {
        _total = -1;
      } else {
        SearchResponse response;
        if (showFilter) {
          response = await TrendingService()
              .getDiscover(actualCategory!.value, page: _page, genres: genresControl.value!.map((e) => e.id).toList());
        } else {
          response = await _service.search(_query, page: _page);
        }
        _searchResults.addAll(response.result);
        _total = response.totalResult;
        _totalPage = response.totalPageResult;
      }
      notifyListeners();
      setBusy(false);
    } catch (e) {
      print(e);
      setError(e);
    }
  }

  fetchMore(BuildContext context) async {
    _page++;
    SearchResponse result;
    if (showFilter) {
      result = await TrendingService().getDiscover(actualCategory!.value, page: _page);
    } else {
      result = await _service.search(_query, page: _page);
    }
    _searchResults.addAll(result.result);
    _totalPage = result.totalPageResult;
    notifyListeners();
  }
}
