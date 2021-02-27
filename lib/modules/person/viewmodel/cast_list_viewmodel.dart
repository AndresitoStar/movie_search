import 'package:movie_search/modules/person/model/credit.dart';
import 'package:movie_search/modules/person/service/service.dart';
import 'package:stacked/stacked.dart';

class CastListViewModel extends FutureViewModel {
  final PersonService _service;
  final String type;
  final String typeId;

  List<Cast> _items = [];

  List<Cast> get items => [..._items];

  CastListViewModel(this.type, this.typeId) : _service = PersonService.getInstance();

  @override
  Future futureToRun() async {
    setBusy(true);
    final credit = await _service.getCredits(type, typeId);
    _items = credit.cast;
    setInitialised(true);
    setBusy(false);
  }

}
