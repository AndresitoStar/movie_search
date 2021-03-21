import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/providers/util.dart';
import 'package:stacked/stacked.dart';

class ItemGridViewModel extends FutureViewModel<BaseSearchResult> {
  final BaseSearchResult _param;

  bool get isFavourite => data != null ? data.isFavourite : false;

  bool _highQualityImage = false;
  String baseImageUrl = URL_IMAGE_SMALL;
  bool over = false;

  bool get isHighQualityImage => _highQualityImage;

  ItemGridViewModel(this._param);

  @override
  Future<BaseSearchResult> futureToRun() async {
    final results = await Future.wait([
      _checkImageCachedQuality(),
      // _db.getAudiovisualById(_param.id),
    ]);
    baseImageUrl = results[0];
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

  Future<String> _checkImageCachedQuality() async {
    if (await _checkImageCachedExist('$URL_IMAGE_BIG${_param.image}')) {
      _highQualityImage = true;
      return URL_IMAGE_BIG;
    } else if (await _checkImageCachedExist(
        '$URL_IMAGE_MEDIUM${_param.image}')) {
      return URL_IMAGE_MEDIUM;
    }
    return URL_IMAGE_SMALL;
  }

  Future<bool> _checkImageCachedExist(String url) async {
    try {
      var file = await DefaultCacheManager().getFileFromCache(url);
      return file?.file?.exists() ?? false;
    } catch (e) {
      return false;
    }
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
