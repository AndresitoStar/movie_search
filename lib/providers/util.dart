import 'audiovisual_single_provider.dart';

class SearchMovieResponse {
  final List<AudiovisualProvider> result;
  final int totalResult;

  SearchMovieResponse({this.result, this.totalResult});
}

enum FAVOURITE_THINGS { FILMS, SERIES, GAMES }
