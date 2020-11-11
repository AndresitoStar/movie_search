import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/providers/util.dart';

import '../providers/audiovisual_single_provider.dart';
import '../repository/repository_movie.dart';

class AudiovisualListProvider with ChangeNotifier {
  AudiovisualListProvider(this._content);
  GRID_CONTENT _content;

  GRID_CONTENT get content => _content;

  List<AudiovisualProvider> _items = [];

  List<AudiovisualProvider> get items => [..._items];

  bool get hasMore => _items.length < _total;

  int _total = 0;

  int get totalSearchResult => _total;

  int get actualPage => _actualPage;

  int _actualPage = 1;

  Future synchronize(BuildContext context) async {
    final MovieRepository _repository = MovieRepository.getInstance(context);
    SearchMovieResponse response;
    switch (content) {
      case GRID_CONTENT.TRENDING_MOVIE:
        response = await _repository.getTrending();
        break;
      case GRID_CONTENT.TRENDING_TV:
        response = await _repository.getTrendingSeries();
        break;
      case GRID_CONTENT.FAVOURITE:
        break;
    }
    _total = response.totalResult;
    _items = response.result;
    notifyListeners();
  }

  Future fetchMore(BuildContext context) async {
    final MovieRepository _repository = MovieRepository.getInstance(context);
    _actualPage++;
    SearchMovieResponse results;
    switch (content) {
      case GRID_CONTENT.TRENDING_MOVIE:
        results = await _repository.getTrending(page: _actualPage);
        break;
      case GRID_CONTENT.TRENDING_TV:
        results = await _repository.getTrendingSeries(page: _actualPage);
        break;
      case GRID_CONTENT.FAVOURITE:
        break;
    }
    _items.addAll(results.result);
    notifyListeners();
  }

}