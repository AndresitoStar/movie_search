import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/model/movie.dart';
import 'package:movie_search/modules/audiovisual/model/serie.dart';
import 'package:movie_search/modules/person/model/person.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/rest/resolver.dart';

class SearchService extends BaseService {
  Future<SearchResponse> search(String query,
      {String type, int page = 0}) async {
    List<ModelBase> result = [];
    List<BaseSearchResult> searchResult = [];
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
            if (mediaType == 'person') {
              BaseSearchResult b =
                  BaseSearchResult.fromPerson(Person.fromJson(data));
              searchResult.add(b);
            } else {
              ModelBase av;
              BaseSearchResult b;
              if (mediaType == 'movie') {
                av = MovieOld()..fromJsonP(data);
                b = BaseSearchResult.fromMovie(Movie.fromJson(data));
              } else if (mediaType == 'tv') {
                av = Serie()..fromJsonP(data);
                b = BaseSearchResult.fromTv(TvShow.fromJson(data));
              }
              if (b != null) {
                searchResult.add(b);
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
        searchResult: searchResult,
        totalResult: totalResults,
        totalPageResult: totalPagesResult);
  }
}
