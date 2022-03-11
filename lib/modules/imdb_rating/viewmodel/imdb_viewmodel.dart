import 'package:movie_search/modules/imdb_rating/service/service.dart';
import 'package:stacked/stacked.dart';

class ImdbRatingViewModel extends FutureViewModel<num> {
  String? imdbId;
  final num tmdbId;
  final String type;
  final ImdbService _service;

  ImdbRatingViewModel(this.tmdbId, this.type, {required this.imdbId}) : _service = ImdbService();

  @override
  Future<num> futureToRun() async {
    setBusy(true);
    num result = -1;
    try {
      if (this.imdbId == null) this.imdbId = await _service.getImbdIdByTmdbId(tmdbId, type);
      if (this.imdbId != null) {
        result = await _service.getImdbRating(this.imdbId!);
        clearErrors();
      } else {
        setError('No Encontrado');
      }
    } catch (e) {
      print(e);
      setError(e);
    }
    setInitialised(true);
    setBusy(false);
    return result;
  }
}
