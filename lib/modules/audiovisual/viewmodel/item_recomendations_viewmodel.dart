import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/service/service.dart';
import 'package:stacked/stacked.dart';

class ItemRecomendationViewModel extends FutureViewModel {
  final AudiovisualService _service;
  final String type;
  final String typeId;

  List<ModelBase> _items = [];

  List<ModelBase> get items => [..._items];

  ItemRecomendationViewModel(this.type, this.typeId)
      : _service = AudiovisualService.getInstance();

  @override
  Future futureToRun() async {
    setBusy(true);
    final list = await _service.getRecomendations(type, typeId);
    _items = list;
    setInitialised(true);
    setBusy(false);
  }
}
