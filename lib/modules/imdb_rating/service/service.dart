import 'package:movie_search/rest/resolver.dart';

class ImdbService extends BaseService {
  Future<num> getImdbRating(String id) async {
    try {
      var response = await clientOMDB.get('/', queryParameters: {'i': id});
      if (response.statusCode == 200) {
        final body = response.data;
        return num.tryParse(body['imdbRating']);
      }
    } catch (e) {}
    return null;
  }

  Future<String> getImbdIdByTmdbId(int id, String type) async {
    try {
      var response = await clientTMDB.get('/$type/$id/external_ids', queryParameters: baseParams);
      if (response.statusCode == 200) {
        final body = response.data;
        return body['imdb_id'];
      }
    } catch (e) {}
    return null;
  }
}
