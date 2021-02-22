import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/service/service.dart';
import 'package:stacked/stacked.dart';

class ItemLikeButtonViewModel extends BaseViewModel {
  final AudiovisualService _audiovisualService;
  final MyDatabase _db;
  final String type;

  ItemLikeButtonViewModel(
      this._db, this._audiovisualService, this.type);

  Stream<List<String>> get stream => _db.watchFavouritesId();

  initialize() {
    _db.watchFavouritesId().listen((event) {
      notifyListeners();
    });
    setInitialised(true);
  }

  Future toggleFavourite(String id) async {
    setBusy(true);
    try {
      if (await _db.getAudiovisualById(id) == null) await _cacheData(id);
      await _db.toggleFavouriteAudiovisualById(id);
    } catch (e) {
      setError(e);
    }
    setBusy(false);
  }

  _cacheData(String id) async {
    final av = await _audiovisualService.getById(id: id, type: type);
    await _db.insertAudiovisual(av.data);
  }
}
