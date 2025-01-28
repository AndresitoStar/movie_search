import 'package:movie_search/modules/audiovisual/service/service.dart';
import 'package:movie_search/modules/imdb_rating/service/service.dart';
import 'package:movie_search/providers/util.dart';
import 'package:stacked/stacked.dart';

class ImdbRatingViewModel extends FutureViewModel<num> {
  String? imdbId;
  final num tmdbId;
  final String type;
  final ImdbService _service;

  ImdbRatingViewModel(this.tmdbId, this.type, {required this.imdbId})
      : _service = ImdbService();

  @override
  Future<num> futureToRun() async {
    setBusy(true);
    num result = -1;
    try {
      if (this.imdbId == null)
        this.imdbId = await _service.getImbdIdByTmdbId(tmdbId, type);
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

class ContentRatingViewModel extends FutureViewModel<String> {
  final num id;
  final TMDB_API_TYPE type;

  ContentRatingViewModel(this.id, this.type);

  @override
  Future<String> futureToRun() async {
    setBusy(true);
    String result = '';
    final _service = AudiovisualService.getInstance();
    try {
      if (type == TMDB_API_TYPE.TV_SHOW) {
        final list = await _service.getTVContentRating(type.type, id);
        if (list.isNotEmpty) {
          result =
              list.firstWhere((element) => element.iso_3166_1 == 'US').rating ??
                  '';
          clearErrors();
        } else {
          setError('No Encontrado');
        }
      } else if (type == TMDB_API_TYPE.MOVIE) {
        final list = await _service.getCertifications(type.type, id);
        if (list.isNotEmpty) {
          result =
              list.firstWhere((element) => element.iso_3166_1 == 'US').rating ??
                  '';
          clearErrors();
        } else {
          setError('No Encontrado');
        }
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
