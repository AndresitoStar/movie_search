import 'dart:io';

import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/rest/resolver.dart';

class TrendingService extends BaseService {
  Future<SearchResponse> getTrending(String type, {int page = 1}) async {
    List<BaseSearchResult> result = [];
    int total = 0;
    Map<String, String> params = {...baseParams, 'page': page.toString()};

    try {
      var response = await clientTMDB.get('trending/$type/day',
          // var response = await clientTMDB.get('trending/$type/week',
          queryParameters: params);
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
    return SearchResponse(result: result, totalResult: total);
  }

  Future<SearchResponse> getPopular(String type, {int page = 1}) async {
    List<BaseSearchResult> result = [];
    int total = 0;
    Map<String, String> params = {...baseParams, 'page': page.toString()};

    try {
      var response =
          await clientTMDB.get('$type/popular', queryParameters: params);
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
    return SearchResponse(result: result, totalResult: total);
  }

  Future<SearchResponse> getDiscover(String type,
      {int page = 1, List<int> genres}) async {
    List<BaseSearchResult> result = [];
    int total = 0;
    Map<String, String> params = {
      ...baseParams,
      if (genres != null && genres.isNotEmpty) 'with_genres': genres.join(','),
      'page': page.toString(),
    };

    try {
      var response =
          await clientTMDB.get('discover/$type', queryParameters: params);
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
    return SearchResponse(result: result, totalResult: total);
  }
}
