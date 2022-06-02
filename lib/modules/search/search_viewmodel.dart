import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/search/search_category.dart';
import 'package:movie_search/modules/search/search_service.dart';
import 'package:movie_search/providers/util.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

class SearchViewModel extends BaseViewModel {
  final SearchService _service;
  final FormGroup form = fb.group({
    FORM_QUERY: FormControl<String>(value: ''),
    FORM_CATEGORY: FormControl<SearchCategory>(value: SearchCategory.all()),
  });

  final List<BaseSearchResult> _searchResults = [];

  List<BaseSearchResult> get searchResults => [..._searchResults];

  int _total = -1;
  int _page = 1;
  int _totalPage = -1;

  bool get hasMore => searchResults.length < _total && _page < _totalPage;

  final _debounce = Debounce(milliseconds: 300);

  static const String FORM_QUERY = 'formQuery';
  static const String FORM_CATEGORY = 'formCategory';

  FormControl<String> get queryControl => this.form.controls[FORM_QUERY] as FormControl<String>;

  FormControl<SearchCategory> get categoryControl => this.form.controls[FORM_CATEGORY] as FormControl<SearchCategory>;

  SearchCategory? get actualCategory => categoryControl.value;

  String get _query => queryControl.value ?? '';

  bool showFilter = false;

  toggleFilter() {
    showFilter = !showFilter;
    notifyListeners();
  }

  SearchViewModel(this._service) {
    final onData = (event) {
      _debounce.run(() async {
        await search();
      });
    };
    queryControl.valueChanges.listen(onData);
    categoryControl.valueChanges.listen(onData);
  }

  search() async {
    setBusy(true);
    try {
      _page = 1;
      _searchResults.clear();
      if (queryControl.isNullOrEmpty) {
        _total = -1;
      } else {
        final response = await _service.search(_query, page: _page, type: actualCategory?.value);
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
    var result = await _service.search(_query, page: _page, type: actualCategory?.value);
    _searchResults.addAll(result.result);
    _totalPage = result.totalPageResult;
    notifyListeners();
  }
}
