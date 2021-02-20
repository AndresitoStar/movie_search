import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/components/search/search_category.dart';
import 'package:movie_search/components/search/search_service.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/providers/util.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

class SearchViewModel extends BaseViewModel {
  final SearchService _service;
  FormGroup form;

  List<AudiovisualProvider> _movies = [];

  List<AudiovisualProvider> get movies => [..._movies];

  int _total = -1;
  int _page = 1;
  int _totalPage = -1;

  bool get hasMore => _movies.length < _total && _page < _totalPage;

  final _debounce = Debounce(milliseconds: 300);

  static const String FORM_QUERY = 'formQuery';
  static const String FORM_CATEGORY = 'formCategory';

  FormControl<String> get queryControl => this.form.controls[FORM_QUERY];

  FormControl<SearchCategory> get categoryControl => this.form.controls[FORM_CATEGORY];

  SearchCategory get actualCategory => categoryControl.value;

  SearchViewModel(this._service) {
    this.form = fb.group({
      FORM_QUERY: FormControl<String>(value: ''),
      FORM_CATEGORY: FormControl<SearchCategory>(value: SearchCategory.all()),
    });
    final onData = (event) {
      _debounce.run(() {
        search();
      });
    };
    queryControl.valueChanges.listen(onData);
    categoryControl.valueChanges.listen(onData);
  }

  search() async {
    setBusy(true);
    try {
      _page = 1;
      if (queryControl.isNullOrEmpty) {
        _total = -1;
        _movies = [];
      } else {
        final response = await _service.search(queryControl.value,
            page: _page, type: actualCategory.value);
        if (response != null) _movies = response.result;
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
    var result = await _service.search(queryControl.value,
        page: _page, type: actualCategory.value);
    if (result != null) {
      _movies.addAll(result.result);
      _totalPage = result.totalPageResult;
    }
    notifyListeners();
  }
}
