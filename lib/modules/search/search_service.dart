import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/model/movie.dart';
import 'package:movie_search/modules/audiovisual/model/serie.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/rest/resolver.dart';

class SearchService extends BaseService {

  Future<SearchResponse> search(String query,
      {String type, int page = 0}) async {
    List<ModelBase> result = [];
    int totalResults = -1;
    int totalPagesResult = -1;

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
              ModelBase av;
              if (mediaType == 'movie') {
                av = Movie()..fromJsonP(data);
              } else if (mediaType == 'tv') {
                av = TvShow()..fromJsonP(data);
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