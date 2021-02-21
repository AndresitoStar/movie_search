import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/rest/resolver.dart';

class SearchService extends BaseService {

  Future<SearchResponse> search(String query,
      {String type, int page = 0}) async {
    List<AudiovisualProvider> result = [];
    int totalResults = -1;
    int totalPagesResult = -1;
    print('page: $page');

    try {
      Map<String, String> params = {
        ...baseParams,
        'query': query,
        'page': page.toString(),
      };

      var response = await clientTMDB.get('search/${type ?? 'multi'}',
          queryParameters: params);
      if (response.statusCode == 200) {
        result = [];
        var body = response.data;
        totalResults = body['total_results'];
        totalPagesResult = body['total_pages'];
        if (totalResults > 0) {
          for (var data in body['results']) {
            final mediaType = data['media_type'] ?? type;
            if (mediaType == 'person')
              continue; // TODO quitar para buscar personas
            else {
              AudiovisualProvider av;
              if (mediaType == 'movie') {
                av = AudiovisualProvider.fromJsonTypeMovie(data);
              } else if (mediaType == 'tv') {
                av = AudiovisualProvider.fromJsonTypeTv(data);
              }
              if (av != null &&
                  av.sinopsis != null &&
                  av.yearOriginal != null /*&& av.image != null*/)
                result.add(av);
            }
          }
        }
      } else {
        print(response.statusCode);
        //TODO LANZAR EXCEPTION
      }
    } catch (e) {
      print(e);
    }

    return new SearchResponse(
        result: result,
        totalResult: totalResults,
        totalPageResult: totalPagesResult);
  }
}