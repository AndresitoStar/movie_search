import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/rest/resolver.dart';

class SearchService extends BaseService {
  Future<SearchResponse> search(String query, {String? type, int page = 0}) async {
    return sendGET<SearchResponse>(
      'search/${type ?? 'multi'}',
      (body) {
        List<BaseSearchResult> searchResult = [];
        int totalResults = -1;
        int totalPagesResult = -1;

        totalResults = body['total_results'];
        totalPagesResult = body['total_pages'];
        if (totalResults > 0) {
          for (var data in body['results']) {
            final mediaType = data['media_type'] ?? type;
            BaseSearchResult b = BaseSearchResult.fromJson(mediaType, data);
            searchResult.add(b);
          }
        }

        return SearchResponse(result: searchResult, totalResult: totalResults, totalPageResult: totalPagesResult);
      },
      params: {...baseParams, 'query': query, 'page': page.toString()},
    );
  }
}
