import 'dart:io';

import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/rest/resolver.dart';

class TrendingService extends BaseService {
  Future<SearchResponse> getTrending(TMDB_API_TYPE type, {int page = 1}) async {
    List<AudiovisualProvider> result = [];
    int total = 0;
    Map<String, String> params = {...baseParams, 'page': page.toString()};

    try {
      var response = await clientTMDB.get('trending/${type.type}/week',
          queryParameters: params);
      if (response.statusCode == 200) {
        result = [];
        final body = response.data;
        total = body['total_results'];
        for (var data in body['results']) {
          AudiovisualProvider av;
          if (type == TMDB_API_TYPE.TV_SHOW) {
            av = new AudiovisualProvider.fromJsonTypeTv(data);
          } else if (type == TMDB_API_TYPE.MOVIE) {
            av = new AudiovisualProvider.fromJsonTypeMovie(data);
          }
          if (av != null) result.add(av);
        }
      }
    } catch (e) {
      print(e);
      if (e is SocketException) {
        throw e;
      }
    }
    return SearchResponse(result: result, totalResult: total);
  }
}