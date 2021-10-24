import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:stacked/stacked.dart';

class ItemGridViewModel extends FutureViewModel<BaseSearchResult> {
  final BaseSearchResult _param;

  bool _highQualityImage = false;
  bool over = false;

  bool get isHighQualityImage => _highQualityImage;

  ItemGridViewModel(this._param);

  @override
  Future<BaseSearchResult> futureToRun() async {
    final results = await Future.wait([
      // _checkImageCachedQuality(),
      // _db.getAudiovisualById(_param.id),
    ]);
    // baseImageUrl = results[0];
    // final dbData = results[1];
    // if (dbData != null) {
    // _param.data = dbData;
    // }
    setInitialised(true);
    return _param;
  }

  toggleOver(bool value) {
    over = value;
    notifyListeners();
  }

  Future toggleFavourite() async {
    setBusy(true);
    try {
      // if (data.data == null) await _cacheData();
      // await _db.toggleFavouriteAudiovisual(data.data);
    } catch (e) {
      setError(e);
    }
    setBusy(false);
    initialise();
  }
}
