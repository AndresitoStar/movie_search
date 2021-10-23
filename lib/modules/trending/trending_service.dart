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
    List<BaseSearchResult> result = [];
    int total = 0;
    Map<String, String> params = {...baseParams, 'page': page.toString()};

    final key = '$type$page';
    if (_cacheTrending.containsKey(key)) return _cacheTrending[key];

    try {
      var response = await clientTMDB.get('trending/$type/day', queryParameters: params);
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
    final r = SearchResponse(result: result, totalResult: total);
    _cacheTrending.putIfAbsent(key, () => r);
    return r;
  }

  Future<SearchResponse> getPopular(String type, {int page = 1}) async {
    List<BaseSearchResult> result = [];
    int total = 0;
    Map<String, String> params = {...baseParams, 'page': page.toString()};
    final key = '$type$page';
    if (_cachePopular.containsKey(key)) return _cachePopular[key];

    try {
      var response = await clientTMDB.get('$type/popular', queryParameters: params);
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
    final r = SearchResponse(result: result, totalResult: total);
    _cachePopular.putIfAbsent(key, () => r);
    return r;
  }

  Future<SearchResponse> getDiscover(String type, {int page = 1, List<int> genres, int year}) async {
    List<BaseSearchResult> result = [];
    int total = 0;
    Map<String, String> params = {
      ...baseParams,
      if (genres != null && genres.isNotEmpty) 'with_genres': genres.join(','),
      if (year != null) 'year': year.toString(),
      'page': page.toString(),
    };
    final key = '$type$page-${genres.first}';
    if (genres?.length == 1 && year == null) {
      if (_cacheDiscover.containsKey(key)) return _cacheDiscover[key];
    }

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
    final r = SearchResponse(result: result, totalResult: total);
    if (genres?.length == 1 && year == null) {
      _cacheDiscover.putIfAbsent(key, () => r);
    }
    return r;
  }
}
