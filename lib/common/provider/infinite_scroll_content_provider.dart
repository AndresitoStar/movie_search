import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search/common/domain/paginated_state.dart';
import 'package:movie_search/common/domain/search_result.dart';
import 'package:movie_search/common/model/search_response.dart';
import 'package:movie_search/common/model/tmdb_type.dart';
import 'package:movie_search/common/repository/content_preview_repository.dart';
import 'package:movie_search/core/di/injection.dart';
import 'package:movie_search/features/audiovisual/repository/audiovisual_repository.dart';
import 'package:movie_search/features/home/provider/home_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'infinite_scroll_content_provider.g.dart';

@riverpod
Future<List<BaseSearchResult>> fetchBaseContent(
  Ref ref,
  ContentConfig apiPath,
  TMDB_API_TYPE? requiredType,
  Map<ApiParams, String> params,
) async {
  final contentType = await ref.watch(homeContentTypeProvider.future);
  if (requiredType != null && contentType != requiredType) {
    // return error state
    throw ArgumentError('Content type mismatch: expected ${requiredType.type}, got ${contentType.type}');
  }

  switch(apiPath) {
    case ContentConfig.credits:
      if (!params.containsKey(ApiParams.id) || !params.containsKey(ApiParams.type)) {
        throw ArgumentError('Params "id" and "type" are required for credits API path');
      }
      final repository = getIt<AudiovisualRepository>();
      final response = await repository.getCredit(params[ApiParams.type]!, params[ApiParams.id]!);
      return response.toBaseSearchResultList();
    case ContentConfig.recommendations:
      if (!params.containsKey(ApiParams.id) || !params.containsKey(ApiParams.type)) {
        throw ArgumentError('Params "id" and "type" are required for credits API path');
      }
      final repository = getIt<AudiovisualRepository>();
      final response = await repository.getRecommendations(params[ApiParams.type]!, params[ApiParams.id]!);
      return response.result;
    case ContentConfig.personCredits:
      if (!params.containsKey(ApiParams.id)) {
        throw ArgumentError('Params "id" and "type" are required for persons credits API path');
      }
      final repository = getIt<AudiovisualRepository>();
      final response = await repository.getCombinedCreditsForPerson(params[ApiParams.id]!);
      return response.toBaseSearchResultList();
    default:
      final repository = getIt<ContentPreviewRepository>();

      final response = await repository.fetchContentPreviews(type: contentType.type, apiPath: apiPath);
      return response.result;
  }
}

enum ContentConfig {
  popular("/{{type}}/popular"),
  popularPerson("/person/popular"),
  trending("/trending/{{type}}/week"),
  topRated("/{{type}}/top_rated"),
  upcoming("/{{type}}/upcoming"),
  nowPlaying("/{{type}}/now_playing"),
  airingToday("/{{type}}/airing_today"),
  onTheAir("/{{type}}/on_the_air"),
  recommendations(""),
  none(""),
  personCredits(""),
  credits("");

  final String path;

  const ContentConfig(this.path);
}

extension ApiPathExtension on ContentConfig {
  String? get forcedType {
    switch (this) {
      case ContentConfig.popularPerson:
        return 'person';
      default:
        return null;
    }
  }
}

enum ApiParams {
  id("id"),
  type("type");

  final String key;

  const ApiParams(this.key);
}

@riverpod
class ContentPreviewListItems extends _$ContentPreviewListItems {
  @override
  PaginatedState build(ContentConfig apiPath, TMDB_API_TYPE? requiredType, Map<ApiParams, String> params) {
    state = PaginatedState();
    _fetchNextPage();
    return PaginatedState();
  }

  Future<void> _fetchNextPage() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true);

    try {
      final contentType = await ref.watch(homeContentTypeProvider.future);
      if (requiredType != null && contentType != requiredType) {
        // return error state
        throw ArgumentError('Content type mismatch: expected ${requiredType!.type}, got ${contentType.type}');
      }

      SearchResponse? response;
      if (apiPath == ContentConfig.credits) {
        if (!params.containsKey(ApiParams.id) || !params.containsKey(ApiParams.type)) {
          throw ArgumentError('Params "id" and "type" are required for credits API path');
        }
        final repository = getIt<AudiovisualRepository>();
        final creditResponse = await repository.getCredit(params[ApiParams.type]!, params[ApiParams.id]!);
        response = creditResponse.toSearchResponse();
      }

      final repository = getIt<ContentPreviewRepository>();
      response = await repository.fetchContentPreviews(
        type: contentType.type,
        apiPath: apiPath,
        page: state.currentPage + 1,
      );

      final newItems = [...state.items, ...response.result];

      state = state.copyWith(
        items: newItems,
        isLoading: false,
        hasMore: response.hasMorePages,
        currentPage: response.page,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  /// Método público para la vista
  Future<void> loadMore() async => _fetchNextPage();

  /// Refresca toda la lista
  Future<void> refresh() async {
    state = PaginatedState();
    await _fetchNextPage();
  }
}
