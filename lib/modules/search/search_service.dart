import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/rest/resolver.dart';

class SearchService extends BaseService {
  Future<SearchResponse> search(String query,
      {String type, int page = 0}) async {
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
        var body = response.data;
        totalResults = body['total_results'];
        totalPagesResult = body['total_pages'];
        if (totalResults > 0) {
          for (var data in body['results']) {
            final mediaType = data['media_type'] ?? type;
            BaseSearchResult b = BaseSearchResult.fromJson(mediaType, data);
            if (b != null) {
              searchResult.add(b);
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

    return SearchResponse(
        result: searchResult,
        totalResult: totalResults,
        totalPageResult: totalPagesResult);
  }
}
