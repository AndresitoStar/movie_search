import 'package:movie_search/rest/resolver.dart';

class ImdbService extends BaseService {
  final Map<String, num> _cacheImdbRating = {};
  Future<num> getImdbRating(String id) async {
    try {
      if (_cacheImdbRating.containsKey(id)) return _cacheImdbRating[id];
      var response = await clientOMDB.get('/', queryParameters: {'i': id});
      if (response.statusCode == 200) {
        final body = response.data;
        final result = num.tryParse(body['imdbRating']);
        _cacheImdbRating.putIfAbsent(id, () => result);
        return result;
      }
    } catch (e) {}
    return null;
  }

  final Map<String, String> _cacheImbdIdByTmdbId = {};
  Future<String> getImbdIdByTmdbId(int id, String type) async {
    try {
      final cacheId = '$type$id';
      if (_cacheImbdIdByTmdbId.containsKey(cacheId)) return _cacheImbdIdByTmdbId[cacheId];
      var response = await clientTMDB.get('/$type/$id/external_ids', queryParameters: baseParams);
      if (response.statusCode == 200) {
        final body = response.data;
        final result = body['imdb_id'];
        _cacheImbdIdByTmdbId.putIfAbsent(cacheId, () => result);
        return result;
      }
    } catch (e) {}
    return null;
  }
}
