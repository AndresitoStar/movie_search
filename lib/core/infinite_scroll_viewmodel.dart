import 'package:stacked/stacked.dart';

abstract class InfiniteScrollViewModel<ItemClass> extends BaseViewModel {
  List<ItemClass> _items = [];

  List<ItemClass> get items => [..._items];

  bool get hasMore => _items.length < _total;

  int _total = 0;

  int _actualPage = 1;

  Future<AbstractSearchResponse<ItemClass>> makeSearch({int? page});

  Future fetch() async {
    setBusy(true);
    try {
      AbstractSearchResponse<ItemClass> response = await makeSearch();
      _total = response.totalResult;
      _items = response.result;
      _actualPage = 1;
      setBusy(false);
    } catch (e) {
      setError(e);
    }
  }

  Future fetchMore() async {
    _actualPage++;
    AbstractSearchResponse<ItemClass> response = await makeSearch(page: _actualPage);
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
