import 'package:movie_search/model/api/models/api.dart';
import 'package:movie_search/model/api/models/tv.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/rest/resolver.dart';

class TrendingService extends BaseService {
  static final TrendingService singleton = TrendingService._internal();

  factory TrendingService() {
    return singleton;
  }

  TrendingService._internal() : super();

  final Map<String, SearchResponse> _cacheTrending = {};
  final Map<String, SearchResponse> _cacheAny = {};
  final Map<String, SearchResponse> _cachePopular = {};
  final Map<String, SearchResponse> _cacheDiscover = {};
  final Map<String, List<WatchProvider>> _cacheNetworks = {};

  Future<SearchResponse> getTrending(String type, {int page = 1}) async {
    return sendGET<SearchResponse>(
      'trending/$type/day',
      (body) {
        List<BaseSearchResult> result = [];
        int total = 0;
        int totalPagesResult = -1;

        result = [];
        total = body['total_results'];
        totalPagesResult = body['total_pages'];
        for (var data in body['results']) {
          BaseSearchResult b = BaseSearchResult.fromJson(type, data);
          result.add(b);
        }
        return SearchResponse(result: result, totalResult: total, totalPageResult: totalPagesResult);
      },
      idCache: '$type$page',
      cacheMap: _cacheTrending,
      params: {...baseParams, 'page': page.toString()},
    );
  }

  Future<SearchResponse> getAny(
    String first,
    String second, {
    int page = 1,
    String? mediaType,
    bool force = false,
  }) async {
    return sendGET<SearchResponse>(
      '$first/$second',
      (body) => SearchResponse.parseResponse(body, mediaType: mediaType),
      idCache: '$first-$second-$page',
      cacheMap: _cacheAny,
      force: force,
      params: {...baseParams, 'page': page.toString()},
    );
  }

  Future<SearchResponse> getPopular(String type, {int page = 1}) async {
    return sendGET<SearchResponse>(
      '$type/popular',
      (body) {
        List<BaseSearchResult> result = [];
        int total = 0;
        int totalPagesResult = -1;

        result = [];
        total = body['total_results'];
        totalPagesResult = body['total_pages'];
        for (var data in body['results']) {
          BaseSearchResult b = BaseSearchResult.fromJson(type, data);
          result.add(b);
        }
        return SearchResponse(result: result, totalResult: total, totalPageResult: totalPagesResult);
      },
      idCache: '$type$page',
      cacheMap: _cachePopular,
      params: {...baseParams, 'page': page.toString()},
    );
  }

  Future<SearchResponse> getDiscover(
    String type, {
    int page = 1,
    List<String>? genres,
    List<String>? cast,
    List<int>? watchProvider,
    SortDirection? sortDirection,
    SortOrder? sortOrder,
  }) async {
    Map<String, String> params = {
      'page': page.toString(),
      if (genres != null && genres.isNotEmpty) 'with_genres': genres.join(','),
      if (cast != null && cast.isNotEmpty) 'with_people': cast.join(','),
      if (watchProvider != null) 'with_watch_providers': '${watchProvider.join('|')}',
      if (watchProvider != null) 'watch_region': await fetchRegion(),
      if (sortDirection != null && sortOrder != null) 'sort_by': '${sortOrder.value}.${sortDirection.value}',
    };

    return sendGET<SearchResponse>(
      'discover/$type',
      (body) {
        List<BaseSearchResult> result = [];
        int total = 0;
        int totalPagesResult = -1;

        result = [];
        total = body['total_results'];
        totalPagesResult = body['total_pages'];
        for (var data in body['results']) {
          BaseSearchResult b = BaseSearchResult.fromJson(type, data);
          result.add(b);
        }
        return SearchResponse(result: result, totalResult: total, totalPageResult: totalPagesResult);
      },
      params: params,
    );
  }

  Future<List<WatchProvider>> getWatchProviders(String type) async {
    final region = await fetchRegion();
    return sendGET<List<WatchProvider>>(
      '/watch/providers/$type',
      (body) {
        List<WatchProvider> result = [];
        for (var data in body['results']) {
          WatchProvider b = WatchProvider.fromJson(data);
          result.add(b);
        }
        return result;
      },
      idCache: '$type',
      cacheMap: _cacheNetworks,
      params: {
        ...baseParams,
        'watch_region': region,
      },
    );
  }
}
