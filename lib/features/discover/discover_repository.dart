import 'package:injectable/injectable.dart';
import 'package:movie_search/common/model/search_response.dart';
import 'package:movie_search/features/discover/network/discover_service.dart';

@lazySingleton
class DiscoverRepository {
  final DiscoverService _service;
  final Map<String, SearchResponse> _cache = {};
  final Map<String, SearchResponse> _cacheWithFilter = {};

  DiscoverRepository(this._service);

  Future<SearchResponse> getDiscover({
    required String type,
    int page = 1,
    String? genre,
    String? cast,
    bool forceRefresh = false,
  }) async {
    final cacheKey = '$type-$page-g:${genre ?? ''}-c:${cast ?? ''}';
    if (!forceRefresh && _cache.containsKey(cacheKey)) {
      return _cache[cacheKey]!;
    }
    final response = await _service.getDiscover(
      type: type,
      page: page,
      genre: genre,
      cast: cast,
    );
    response.fixResultsWithType(type);
    _cache[cacheKey] = response;
    return response;
  }

  Future<SearchResponse> getDiscoverWithFilter({
    required String type,
    required String watchRegion,
    int page = 1,
    String? genre,
    String? cast,
    String? sortBy,
    List<String>? watchProviders,
    bool forceRefresh = false,
  }) async {
    final cacheKey = '$type-$page-g:${genre ?? ''}-c:${cast ?? ''}-s:${sortBy ?? ''}-w:${watchProviders?.join(',') ?? ''}-r:$watchRegion';
    if (!forceRefresh && _cacheWithFilter.containsKey(cacheKey)) {
      return _cacheWithFilter[cacheKey]!;
    }
    final response = await _service.getDiscover(
      type: type,
      page: page,
      genre: genre,
      cast: cast,
      sortBy: sortBy,
      watchProviders: watchProviders?.join('|'),
      watchRegion: watchRegion,
    );
    response.fixResultsWithType(type);
    _cacheWithFilter[cacheKey] = response;
    return response;
  }
}