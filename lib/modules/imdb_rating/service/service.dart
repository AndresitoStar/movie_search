import 'package:movie_search/rest/resolver.dart';

class ImdbService extends BaseService {
  final Map<String, num> _cacheImdbRating = {};
  Future<num> getImdbRating(String id) async {
    if (_cacheImdbRating.containsKey(id)) return _cacheImdbRating[id]!;
    var response = await clientOMDB.get('/', queryParameters: {'i': id});
    if (response.statusCode == 200) {
      final body = response.data as Map;
      if (body.containsKey('imdbRating')) {
        if (body['imdbRating'] == 'N/A') return -1;
        final result = num.tryParse(body['imdbRating'])!;
        _cacheImdbRating.putIfAbsent(id, () => result);
        return result;
      }
    }
    throw Exception();
  }

  final Map<String, String> _cacheImbdIdByTmdbId = {};
  Future<String> getImbdIdByTmdbId(num id, String type) async {
    final cacheId = '$type$id';
    if (_cacheImbdIdByTmdbId.containsKey(cacheId))
      return _cacheImbdIdByTmdbId[cacheId]!;
    var response = await clientTMDB.get('/$type/$id/external_ids',
        queryParameters: baseParams);
    if (response.statusCode == 200) {
      final body = response.data;
      final result = body['imdb_id'];
      _cacheImbdIdByTmdbId.putIfAbsent(cacheId, () => result);
      return result;
    }
    throw Exception();
  }
}
