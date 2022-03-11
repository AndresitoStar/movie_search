import 'dart:io';

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
  final Map<String, SearchResponse> _cachePopular = {};
  final Map<String, SearchResponse> _cacheDiscover = {};

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

  Future<SearchResponse> getDiscover(String type, {int page = 1, List<int>? genres}) async {
    List<BaseSearchResult> result = [];
    int total = 0;
    Map<String, String> params = {
      ...baseParams,
      if (genres != null && genres.isNotEmpty) 'with_genres': genres.join(','),
      'page': page.toString(),
    };
    String key = '$type$page';
    if (genres?.length == 1) {
      final key = '$type$page-${genres!.first}';
    }
    if (_cacheDiscover.containsKey(key)) return _cacheDiscover[key]!;

    try {
      var response = await clientTMDB.get('discover/$type', queryParameters: params);
      if (response.statusCode == 200) {
        result = [];
        final body = response.data;
        total = body['total_results'];
        for (var data in body['results']) {
          BaseSearchResult b = BaseSearchResult.fromJson(type, data);
          if (b != null) result.add(b);
        }
      }
    } catch (e) {
      print(e);
      if (e is SocketException) {
        throw e;
      }
    }
    final r = SearchResponse(result: result, totalResult: total, totalPageResult: 1);
    _cacheDiscover.putIfAbsent(key, () => r);
    return r;
  }
}
