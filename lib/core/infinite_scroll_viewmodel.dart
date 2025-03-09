import 'package:stacked/stacked.dart';

abstract class InfiniteScrollViewModel<ItemClass> extends BaseViewModel {
  List<ItemClass> _items = [];

  List<ItemClass> get items => [..._items];

  bool get hasMore => _items.length < _total;

  int _total = 0;

  int _actualPage = 1;

  Future<AbstractSearchResponse<ItemClass>> makeSearch({int? page, required bool force});

  Future fetch({bool force = false}) async {
    setBusy(true);
    try {
      _items.clear();
      AbstractSearchResponse<ItemClass> response = await makeSearch(force: force);
      _total = response.totalResult;
      _items = response.result;
      _actualPage = 1;
      setBusy(false);
      setInitialised(true);
    } catch (e) {
      setError(e);
    }
  }

  Future fetchMore() async {
    _actualPage++;
    AbstractSearchResponse<ItemClass> response = await makeSearch(page: _actualPage, force: false);
    _items.addAll(response.result);
    notifyListeners();
  }
}

abstract class AbstractSearchResponse<T> {
  final List<T> result;
  final int totalResult;
  final int totalPageResult;

  AbstractSearchResponse({required this.totalResult, required this.totalPageResult, required this.result});
}
