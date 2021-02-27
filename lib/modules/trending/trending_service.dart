import 'dart:io';

import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/rest/resolver.dart';

class TrendingResponse {
  final List<ModelBase> result;
  final int totalResult;
  final int totalPageResult;

  TrendingResponse({this.result, this.totalResult, this.totalPageResult});
}

class TrendingService extends BaseService {
  Future<TrendingResponse> getTrending<T extends ModelBase>(String type, {int page = 1}) async {
    List<ModelBase> result = [];
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
          T av = ModelBase.fromJson(T, data);
          if (av != null) result.add(av);
        }
      }
    } catch (e) {
      print(e);
      if (e is SocketException) {
        throw e;
      }
    }
    return TrendingResponse(result: result, totalResult: total);
  }

  Future<TrendingResponse> getPopular<T extends ModelBase>(String type, {int page = 1}) async {
    List<ModelBase> result = [];
    int total = 0;
    Map<String, String> params = {...baseParams, 'page': page.toString()};

    try {
      var response = await clientTMDB.get('$type/popular',
      // var response = await clientTMDB.get('trending/$type/week',
          queryParameters: params);
      if (response.statusCode == 200) {
        result = [];
        final body = response.data;
        total = body['total_results'];
        for (var data in body['results']) {
          T av = ModelBase.fromJson(T, data);
          if (av != null) result.add(av);
        }
      }
    } catch (e) {
      print(e);
      if (e is SocketException) {
        throw e;
      }
    }
    return TrendingResponse(result: result, totalResult: total);
  }
}