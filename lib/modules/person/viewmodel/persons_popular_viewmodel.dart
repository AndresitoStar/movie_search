import 'package:movie_search/modules/person/model/person.dart';
import 'package:movie_search/modules/person/service/service.dart';
import 'package:movie_search/providers/util.dart';
import 'package:stacked/stacked.dart';

class PersonViewModel extends BaseViewModel {
  final PersonService _service;

  List<Person> _items = [];

  List<Person> get items => [..._items];

  bool get hasMore => _items.length < _total;

  int _total = 0;

  int get total => _total;

  int get actualPage => _actualPage;

  int _actualPage = 1;

  final Debounce _debounce = Debounce(milliseconds: 100);

  PersonViewModel() : _service = PersonService.getInstance();

  Future synchronize() async {
    PersonListResponse response = await _service.getPopulars();
    _total = response?.totalResult ?? -1;
    _items = response?.result ?? [];
    notifyListeners();
  }

  Future fetchMore() async {
    _debounce.run(() => _fetchMore());
  }

  Future _fetchMore() async {
    _actualPage++;
    PersonListResponse results = await _service.getPopulars(page: _actualPage);
    _items.addAll(results.result);
    notifyListeners();
  }
}
