import 'package:movie_search/model/api/models/tv.dart';
import 'package:movie_search/modules/audiovisual/service/service.dart';
import 'package:stacked/stacked.dart';

class ItemWatchProviderViewModel extends FutureViewModel {
  final AudiovisualService _service;
  final String type;
  final num id;

  late List<WatchProvider> provider;

  ItemWatchProviderViewModel({required this.type, required this.id}) : _service = AudiovisualService.getInstance();

  @override
  Future futureToRun() async {
    setBusy(true);
    final watchProviders = await _service.getWatchProviders(id: id, type: type);
    final region = await _service.fetchRegion();
    provider = (watchProviders.results.containsKey(region) ? watchProviders.results[region] : [])!;
    notifyListeners();
    setInitialised(true);
    setBusy(false);
  }
}
