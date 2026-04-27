import 'dart:async';

import 'package:movie_search/common/domain/paginated_state.dart';
import 'package:movie_search/common/model/search_response.dart';
import 'package:movie_search/core/di/injection.dart';
import 'package:movie_search/features/search/search_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_provider.g.dart';

@Riverpod(keepAlive: false)
class Search extends _$Search {
  Timer? _debounce;

  @override
  SearchPaginatedState build() {
    return InitialSearchPaginatedState();
  }

  void onQueryChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      _search(query);
    });
  }

  Future<void> _search(String query) async {
    final selectedIndexNotifier = ref.read(searchSelectedIndexProvider.notifier);
    selectedIndexNotifier.reset();

    if (query == state.query) return;
    if (state.isLoading) return;
    if (query.length < 2 && query.isNotEmpty) return;
    if (query.isEmpty) {
      state = InitialSearchPaginatedState();
      return;
    }
    state = state.copyWith(query: query, isLoading: true);

    try {
      final repository = getIt<SearchRepository>();
      SearchResponse response = await repository.search(query: query, page: 1);

      final newItems = [...response.result];

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
  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true);

    try {
      final repository = getIt<SearchRepository>();
      SearchResponse response = await repository.search(query: state.query, page: state.currentPage + 1);

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
}

@Riverpod(keepAlive: false)
class SearchSelectedIndex extends _$SearchSelectedIndex {
  @override
  num build() {
    return -1;
  }

  void setIndex(num? index) {
    state = index ?? -1;
  }

  void reset() {
    state = -1;
  }
}
