
import 'package:injectable/injectable.dart';
import 'package:movie_search/common/model/search_response.dart';
import 'package:movie_search/features/search/network/search_service.dart';

@lazySingleton
class SearchRepository {
  final SearchService _service;

  SearchRepository(this._service);

  Future<SearchResponse> search({
    required String query,
    int page = 1
  }) async {
    final response = await _service.search(
      query: query,
      page: page,
    );
    return response;
  }
}