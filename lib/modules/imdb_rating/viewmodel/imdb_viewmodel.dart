import 'package:movie_search/modules/imdb_rating/service/service.dart';
import 'package:stacked/stacked.dart';

class ImdbRatingViewModel extends FutureViewModel<num> {
  final String imdbId;
  final int tmdbId;
  final String type;
  final ImdbService _service;

  ImdbRatingViewModel(this.tmdbId, this.type, {this.imdbId}) : _service = ImdbService();

  @override
  Future<num> futureToRun() async {
    if (this.imdbId != null) {
      return _service.getImdbRating(this.imdbId);
    }
    final imdbId = await _service.getImbdIdByTmdbId(tmdbId, type);
    if (imdbId != null) {
      return _service.getImdbRating(imdbId);
    }
    return null;
  }

}