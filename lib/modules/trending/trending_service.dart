import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
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
  final Map<String, SearchResponse> _cachePopular = {};
  final Map<String, SearchResponse> _cacheDiscover = {};
  final Map<String, List<WatchProvider>> _cacheNetworks = {};
  final Map<String, String> _cacheRegion = {};

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

  Future<SearchResponse> getDiscover(
    String type, {
    int page = 1,
    List<String>? genres,
    List<String>? cast,
    WatchProvider? watchProvider,
  }) async {
    List<BaseSearchResult> result = [];
    int total = 0;
    int totalPages = 0;
    final region = await _fetchRegion();
    Map<String, String> params = {
      ...baseParams,
      if (genres != null && genres.isNotEmpty) 'with_genres': genres.join(','),
      if (cast != null && cast.isNotEmpty) 'with_people': cast.join(','),
      if (watchProvider != null) 'with_watch_providers': '${watchProvider.providerId}',
      if (watchProvider != null) 'watch_region': region,
      'page': page.toString(),
    };
    StringBuffer key = StringBuffer('$type$page');
    if (genres != null && genres.length > 0) {
      key.write('-${genres.join('-')}');
    }
    if (watchProvider != null) {
      key.write('-${watchProvider.providerId}');
    }
    if (_cacheDiscover.containsKey(key.toString())) return _cacheDiscover[key.toString()]!;

    try {
      var response = await clientTMDB.get('discover/$type', queryParameters: params);
      if (response.statusCode == 200) {
        result = [];
        final body = response.data;
        total = body['total_results'];
        totalPages = body['total_pages'];
        for (var data in body['results']) {
          BaseSearchResult b = BaseSearchResult.fromJson(type, data);
          result.add(b);
        }
      }
    } catch (e) {
      print(e);
      if (e is SocketException) {
        throw e;
      }
    }
    final r = SearchResponse(result: result, totalResult: total, totalPageResult: totalPages);
    _cacheDiscover.putIfAbsent(key.toString(), () => r);
    return r;
  }

  Future<List<WatchProvider>> getWatchProviders(String type) async {
    final region = await _fetchRegion();
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

  Future<String> _fetchRegion() async {
    if (_cacheRegion.containsKey('region')) return _cacheRegion['region']!;
    final response = await http.get(Uri.parse('http://ipwho.is/'));
    final region = jsonDecode(response.body)['country_code'];
    _cacheRegion.putIfAbsent('region', () => region);
    return region;
  }
}
