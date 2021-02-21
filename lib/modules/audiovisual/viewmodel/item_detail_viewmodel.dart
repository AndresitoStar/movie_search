import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/service/service.dart';
import 'package:movie_search/providers/util.dart';
import 'package:stacked/stacked.dart';

class ItemDetailViewModel<T extends ModelBase>
    extends FutureViewModel<ModelBase> {
  final ModelBase _param;
  final AudiovisualService _service;
  final MyDatabase _db;

  ItemDetailViewModel(this._param, this._service, this._db);

  bool _highQualityImage = false;
  String baseImageUrl = URL_IMAGE_MEDIUM;

  bool get isHighQualityImage => _highQualityImage;

  bool get withImage => _param.image != null;

  String get image => _param.image;

  bool get isFavourite =>
      data != null && data.data != null ? data.data.isFavourite : false;

  @override
  Future<ModelBase> futureToRun() async {
    final results = await Future.wait([
      _checkImageCachedQuality(),
      _db.getAudiovisualById(_param.id),
    ]);
    baseImageUrl = results[0];
    final _dbAv = results[1];
    if (_dbAv != null) {
      _param.data = _dbAv;
      setInitialised(true);
      return _param;
    }
    return await _cacheData();
  }

  Future<ModelBase> _cacheData() async {
    final av = await _service.getById<T>(id: _param.id, type: _param.type);
    await _db.insertAudiovisual(av.data);
    setInitialised(true);
    return av;
  }

  Future<String> _checkImageCachedQuality() async {
    if (await _checkImageCachedExist('$URL_IMAGE_BIG${_param.image}')) {
      _highQualityImage = true;
      return URL_IMAGE_BIG;
    }
    return URL_IMAGE_MEDIUM;
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
      if (data.data == null) await _cacheData();
      await _db.toggleFavouriteAudiovisual(data.data);
      initialise();
    } catch (e) {
      setError(e);
    }
    setBusy(false);
  }

  Future toggleHighQualityImage() async {
    _highQualityImage = true;
    baseImageUrl = URL_IMAGE_BIG;
    notifyListeners();
  }
}
