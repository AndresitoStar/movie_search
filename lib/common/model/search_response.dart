import 'package:movie_search/common/domain/search_result.dart';
import 'package:movie_search/common/model/tmdb_type.dart';

class BaseResult {
  final Map<String, dynamic> data = {};

  BaseResult();

  factory BaseResult.fromJson(Map<String, dynamic> json) {
    final result = BaseResult();
    result.data.addAll(json);
    return result;
  }

  BaseSearchResult buildFrom(String type) {
    try {
      final tmdbType = tmdbFromString(type);
      return BaseSearchResult.fromJson(tmdbType.type, data);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}

class SearchResponse {
  final List<BaseSearchResult> result;
  final int totalResult;
  final int totalPageResult;
  final int page;

  SearchResponse({required this.totalResult, required this.totalPageResult, required this.result, this.page = 1});

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    List<BaseSearchResult> result = [];
    int total = 0;
    int totalPagesResult = -1;
    int page = 1;

    result = [];
    total = json['total_results'];
    totalPagesResult = json['total_pages'];
    page = json['page'];
    for (var data in json['results']) {
      BaseSearchResult b = BaseSearchResult.fromJson(data['media_type'], data);
      result.add(b);
    }
    return SearchResponse(result: result, totalResult: total, totalPageResult: totalPagesResult, page: page);
  }

  fixResultsWithType(String type) {
    for (var r in result) {
      if (r.type == TMDB_API_TYPE.UNKNOWN) {
        r.completeWithExtraData(type);
      }
    }
  }

  // empty response
  static SearchResponse empty() {
    return SearchResponse(result: [], totalResult: 0, totalPageResult: 0);
  }

  //copy with
  SearchResponse copyWith({
    List<BaseSearchResult>? result,
    int? totalResult,
    int? totalPageResult,
    int? page,
  }) {
    return SearchResponse(
      result: result ?? this.result,
      totalResult: totalResult ?? this.totalResult,
      totalPageResult: totalPageResult ?? this.totalPageResult,
      page: page ?? this.page,
    );
  }

  bool get hasMorePages {
    return page < totalPageResult;
  }
}
