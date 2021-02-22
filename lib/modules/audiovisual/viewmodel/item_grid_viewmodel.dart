import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/service/service.dart';
import 'package:movie_search/providers/util.dart';
import 'package:stacked/stacked.dart';

class ItemGridViewModel<T extends ModelBase> extends FutureViewModel<ModelBase> {
  final ModelBase _param;
  final AudiovisualService _audiovisualService;
  final MyDatabase _db;

  bool get isFavourite =>
      data != null && data.data != null ? data.data.isFavourite : false;

  bool _highQualityImage = false;
  String baseImageUrl = URL_IMAGE_SMALL;

  bool get isHighQualityImage => _highQualityImage;

  ItemGridViewModel(this._audiovisualService, this._param, this._db);

  @override
  Future<ModelBase> futureToRun() async {
    final results = await Future.wait([
      _checkImageCachedQuality(),
      _db.getAudiovisualById(_param.id),
    ]);
    baseImageUrl = results[0];
    final dbData = results[1];
    if (dbData != null) {
      _param.data = dbData;
    }
    setInitialised(true);
    return _param;
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

  _cacheData() async {
    final av =
        await _audiovisualService.getById<T>(id: _param.id, type: _param.type);
    await _db.insertAudiovisual(av.data);
    data.data = av.data;
    onData(av);
  }

  Future toggleFavourite() async {
    setBusy(true);
    try {
      if (data.data == null) await _cacheData();
      await _db.toggleFavouriteAudiovisual(data.data);
    } catch (e) {
      setError(e);
    }
    setBusy(false);
    initialise();
  }

}
