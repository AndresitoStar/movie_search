import 'package:movie_search/model/api/models/api.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/rest/resolver.dart';

class SearchService extends BaseService {
  final String? type;

  SearchService({this.type});

  Future<SearchResponse> search(String query,
      {String? type, int page = 0}) async {
    final realType = type ?? this.type ?? 'multi';
    return sendGET<SearchResponse>(
      'search/$realType',
      (body) {
        List<BaseSearchResult> searchResult = [];
        int totalResults = -1;
        int totalPagesResult = -1;

        totalResults = body['total_results'];
        totalPagesResult = body['total_pages'];
        if (totalResults > 0) {
          for (var data in body['results']) {
            try {
              final mediaType = data['media_type'] ?? realType;
              BaseSearchResult b = BaseSearchResult.fromJson(mediaType, data);
              searchResult.add(b);
            } on ApiException catch (e) {
              continue;
            } on Exception catch (e) {
              print(e);
            }
          }
        }

        return SearchResponse(
            result: searchResult,
            totalResult: totalResults,
            totalPageResult: totalPagesResult);
      },
      params: {...baseParams, 'query': query, 'page': page.toString()},
    );
  }
}
