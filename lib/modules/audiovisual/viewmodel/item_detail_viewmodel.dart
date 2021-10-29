import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:movie_search/model/api/models/movie.dart';
import 'package:movie_search/model/api/models/person.dart';
import 'package:movie_search/model/api/models/tv.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/service/service.dart';
import 'package:movie_search/providers/util.dart';
import 'package:stacked/stacked.dart';

class ItemDetailViewModel extends FutureViewModel<BaseSearchResult> {
  final BaseSearchResult _param;
  final AudiovisualService _service;

  ItemDetailViewModel(this._param)
      : _service = AudiovisualService.getInstance(),
        scrollController = ScrollController();

  final ScrollController scrollController;

  String get posterImageUrl => _param.posterImage;

  bool get withImage => posterImageUrl != null && posterImageUrl.isNotEmpty;

  String get title => _param.title;

  int get year => _param.year;

  String get backDropImageUrl => _param.backDropImage;

  int get itemId => _param.id;

  TMDB_API_TYPE get itemType => _param.type;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Future<BaseSearchResult> futureToRun() async {
    try {
      final result = await _getData();
      clearErrors();
      setInitialised(true);
      return result;
    } catch (e) {
      setError(e);
      return null;
    }
  }

  Future<BaseSearchResult> _getData() async {
    try {
      if (_param.type == TMDB_API_TYPE.MOVIE) {
        final MovieApi movie = await _service.getById(id: _param.id, type: _param.type.type);
        return BaseSearchResult.fromMovie(movie);
      } else if (_param.type == TMDB_API_TYPE.TV_SHOW) {
        final TvApi tv = await _service.getById(id: _param.id, type: _param.type.type);
        return BaseSearchResult.fromTv(tv);
      } else {
        final Person person = await _service.getById(id: _param.id, type: _param.type.type);
        return BaseSearchResult.fromPerson(person);
      }
    } catch (err) {
      print(err);
      rethrow;
    }
  }
}
