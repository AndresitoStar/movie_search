import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/util.dart';

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

  final Debounce _debounce = Debounce(milliseconds: 100);

  Future synchronize(BuildContext context) async {
    final MovieRepository _repository = MovieRepository.getInstance(context);
    SearchResponse response;
    TMDB_API_TYPE type;
    switch (content) {
      case GRID_CONTENT.TRENDING_MOVIE:
        type = TMDB_API_TYPE.MOVIE;
        break;
      case GRID_CONTENT.TRENDING_TV:
        type = TMDB_API_TYPE.TV_SHOW;
        break;
      case GRID_CONTENT.FAVOURITE:
        break;
    }
    response = await UtilView.runLongTaskFromServer(
        context, () => _repository.getTrending(type));
    _total = response?.totalResult ?? -1;
    _items = response?.result ?? [];
    notifyListeners();
  }

  Future fetchMore(BuildContext context) async {
    _debounce.run(() => _fetchMore(context));
  }

  Future _fetchMore(BuildContext context) async {
    print('fetching...');
    final MovieRepository _repository = MovieRepository.getInstance(context);
    _actualPage++;
    SearchResponse results;
    switch (content) {
      case GRID_CONTENT.TRENDING_MOVIE:
        results = await _repository.getTrending(TMDB_API_TYPE.MOVIE,
            page: _actualPage);
        break;
      case GRID_CONTENT.TRENDING_TV:
        results = await _repository.getTrending(TMDB_API_TYPE.TV_SHOW,
            page: _actualPage);
        break;
      case GRID_CONTENT.FAVOURITE:
        break;
    }
    _items.addAll(results.result);
    notifyListeners();
  }
}

class AudiovisualListProviderHelper {
  static AudiovisualListProviderHelper _instance;

  Map<GRID_CONTENT, AudiovisualListProvider> _map = {};

  AudiovisualListProvider getProvider(GRID_CONTENT key) =>
      _map.putIfAbsent(key, () => AudiovisualListProvider(key));

  static AudiovisualListProviderHelper getInstance() {
    if (_instance == null) _instance = AudiovisualListProviderHelper._();
    return _instance;
  }

  AudiovisualListProviderHelper._();
}
