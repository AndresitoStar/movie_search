import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/model/api/models/movie.dart';
import 'package:movie_search/model/api/models/tv.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/model/image.dart';
import 'package:movie_search/modules/audiovisual/service/service.dart';
import 'package:movie_search/providers/util.dart';
import 'package:stacked/stacked.dart';

class ItemDetailViewModel extends FutureViewModel<BaseSearchResult> {
  final BaseSearchResult _param;
  final AudiovisualService _service;
  final MyDatabase _db;

  ItemDetailViewModel(this._param, this._db)
      : _service = AudiovisualService.getInstance(),
        scrollController = ScrollController();

  bool _highQualityImage = false;
  String baseImageUrl = URL_IMAGE_MEDIUM;
  final ScrollController scrollController;

  List<MediaImage> _images = [];

  List<String> get images => [posterImageUrl, ..._images.map((e) => e.filePath).toSet().toList()];

  bool get isHighQualityImage => _highQualityImage;

  bool get withImage => _param.posterImage != null;

  bool get withImageList => _images.isNotEmpty;

  String get posterImageUrl => _param.posterImage;

  String get title => _param.title;

  int get year => _param.year;

  String get backDropImageUrl => _param.backDropImage;

  int get itemId => _param.id;

  TMDB_API_TYPE get itemType => _param.type;

  int currentImage = 0;

  bool pauseTimer = false;

  togglePauseTimer() {
    pauseTimer = !pauseTimer;
    notifyListeners();
  }

  changeCurrentImage(int current) {
    this.currentImage = current;
    notifyListeners();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Future<BaseSearchResult> futureToRun() async {
    final results = await Future.wait([
      _checkImageCachedQuality(),
      _cacheData(),
      // _fetchImages(),
    ]);
    baseImageUrl = results[0];
    setInitialised(true);
    return results[1] ?? _param;
  }

  Future<BaseSearchResult> _cacheData() async {
    try {
      if (_param.type == TMDB_API_TYPE.MOVIE) {
        // final _dbMovie = await _db.getMovieById(_param.id);
        // if (_dbMovie != null) {
        //   return BaseSearchResult.fromMovie(_dbMovie);
        // }
        // final Movie movie =
        //     await _service.getById(id: _param.id, type: _param.type.type);
        final MovieApi movie = await _service.getById(id: _param.id, type: _param.type.type);
        // _db.insertMovie(movie);
        return BaseSearchResult.fromMovie(movie);
      } else if (_param.type == TMDB_API_TYPE.TV_SHOW) {
        // final _dbTv = await _db.getTvShowById(_param.id);
        // if (_dbTv != null) {
        //   return BaseSearchResult.fromTv(_dbTv);
        // }
        final TvApi tv = await _service.getById(id: _param.id, type: _param.type.type);
        // _db.insertTvShow(tv);
        return BaseSearchResult.fromTv(tv);
      }
    } catch (err) {
      print(err);
    }
    return _param;
  }

  Future<String> _checkImageCachedQuality() async {
    if (await _checkImageCachedExist('$URL_IMAGE_BIG${_param.posterImage}')) {
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

  Future toggleHighQualityImage() async {
    _highQualityImage = true;
    baseImageUrl = URL_IMAGE_BIG;
    notifyListeners();
  }
}
