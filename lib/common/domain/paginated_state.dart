import 'package:movie_search/common/domain/search_result.dart';

class PaginatedState {
  final List<BaseSearchResult> items;
  final bool isLoading;
  final bool hasMore;
  final int currentPage;

  PaginatedState({
    this.items = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.currentPage = 1,
  });

  PaginatedState copyWith({
    List<BaseSearchResult>? items,
    bool? isLoading,
    bool? hasMore,
    int? currentPage,
  }) {
    return PaginatedState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  bool get isEmpty => items.isEmpty;

  int get itemCount => items.length;
}

class InitialPaginatedState extends PaginatedState {
  InitialPaginatedState() : super(isLoading: true);
}

class SearchPaginatedState extends PaginatedState {
  final String query;
  SearchPaginatedState({
    required this.query,
    super.items,
    super.isLoading,
    super.hasMore,
    super.currentPage,
  });

  @override
  SearchPaginatedState copyWith({
    String? query,
    List<BaseSearchResult>? items,
    bool? isLoading,
    bool? hasMore,
    int? currentPage,
  }) {
    return SearchPaginatedState(
      query: query ?? this.query,
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class InitialSearchPaginatedState extends SearchPaginatedState {
  InitialSearchPaginatedState() : super(query: '');
}