import 'dart:async';
import 'dart:ui';

import 'audiovisual_single_provider.dart';

class SearchMovieResponse {
  final List<AudiovisualProvider> result;
  final int totalResult;

  SearchMovieResponse({this.result, this.totalResult});
}

enum FAVOURITE_THINGS { FILMS, SERIES, GAMES }

enum GRID_CONTENT {TRENDING_MOVIE, TRENDING_TV, FAVOURITE}

class Debounce {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debounce({this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
