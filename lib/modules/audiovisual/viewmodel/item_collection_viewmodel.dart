import 'package:movie_search/model/api/models/movie.dart';
import 'package:movie_search/modules/audiovisual/service/service.dart';
import 'package:stacked/stacked.dart';

class ItemCollectionViewModel extends FutureViewModel {
  final AudiovisualService _service;
  Collection collection;

  ItemCollectionViewModel(this.collection)
      : _service = AudiovisualService.getInstance();

  @override
  Future futureToRun() async {
    setBusy(true);
    collection = await _service.getCollection(collection.id);
    notifyListeners();
    setInitialised(true);
    setBusy(false);
  }
}
