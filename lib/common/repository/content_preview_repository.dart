import 'package:injectable/injectable.dart';
import 'package:movie_search/common/model/search_response.dart';
import 'package:movie_search/common/network/base_content_service.dart';
import 'package:movie_search/common/provider/infinite_scroll_content_provider.dart';
import 'package:movie_search/core/di/injection.dart';

@lazySingleton
class ContentPreviewRepository {
  final Map<String, SearchResponse> _cache = {};
  Future<SearchResponse> fetchContentPreviews({
    required String type,
    required ContentConfig apiPath,
    String? extraCacheKey,
    bool forceRefresh = false,
    int page = 1,
  }) async {
    final typeValid = apiPath.forcedType ?? type;
    final cacheKey = 'p:$page-$typeValid-${apiPath.path}-${extraCacheKey != null ? '-$extraCacheKey' : ''}';
    if (!forceRefresh && _cache.containsKey(cacheKey)) {
      return _cache[cacheKey]!;
    } else {
      final service = getIt<BaseContentService>();
      final uri = apiPath.path.replaceAll('{{type}}', typeValid);
      final response = await service.getContentPaginated(uri, page);
      response.fixResultsWithType(typeValid);
      _cache[cacheKey] = response;
      return response;
    }
  }
}

