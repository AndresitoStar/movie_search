import 'package:movie_search/common/domain/paginated_state.dart';
import 'package:movie_search/common/domain/search_result.dart';
import 'package:movie_search/common/model/country.dart';
import 'package:movie_search/common/model/genre.dart';
import 'package:movie_search/common/model/tmdb_type.dart';
import 'package:movie_search/common/model/tv.dart';
import 'package:movie_search/core/di/injection.dart';
import 'package:movie_search/features/discover/discover_repository.dart';
import 'package:movie_search/features/home/provider/home_provider.dart';
import 'package:movie_search/features/settings/provider/south_american_countries_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'discover_provider.g.dart';

@Riverpod(keepAlive: false)
class Discover extends _$Discover {
  @override
  PaginatedState build() {
    state = InitialPaginatedState();
    _discover();
    return InitialPaginatedState();
  }

  Future<void> _discover() async {
    final contentTypeProvider = ref.read(homeContentTypeProvider);
    final filterProvider = ref.watch(discoverFilterProvider);
    final countrySelected = await ref.read(selectedCountryProvider.future);

    if (!contentTypeProvider.hasValue) return;
    try {
      state = state.copyWith(isLoading: true);

      final repository = getIt<DiscoverRepository>();
      final response = await repository.getDiscoverWithFilter(
          type: contentTypeProvider.value!.type,
          watchRegion: countrySelected.iso31661,
          genre: filterProvider.genres?.map((e) => e.id.toString()).join(','),
          cast: filterProvider.cast?.map((e) => e.id.toString()).join(','),
          sortBy: filterProvider.sortBy,
          watchProviders: filterProvider.watchProviders?.map((e) => e.providerId.toString()).toList(),
          page: 1
      );

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

  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true);

    final contentTypeProvider = ref.read(homeContentTypeProvider);
    final filterProvider = ref.watch(discoverFilterProvider);
    final countrySelected = await ref.read(selectedCountryProvider.future);

    try {
      final repository = getIt<DiscoverRepository>();
      final response = await repository.getDiscoverWithFilter(
        type: contentTypeProvider.value!.type,
        watchRegion: countrySelected.iso31661,
        genre: filterProvider.genres?.map((e) => e.id.toString()).join(','),
        cast: filterProvider.cast?.map((e) => e.id.toString()).join(','),
        sortBy: filterProvider.sortBy,
        watchProviders: filterProvider.watchProviders?.map((e) => e.providerId.toString()).toList(),
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

  Future<void> refresh() async {
    state = PaginatedState();
    await _discover();
  }
}

@Riverpod(keepAlive: true)
class DiscoverFilter extends _$DiscoverFilter {
  @override
  DiscoverFilterState build() {
    return DiscoverFilterState(
      sortOrder: SortOrder.POPULARITY,
      sortDirection: SortDirection.desc,
    );
  }

  void toggleGenreFilter(Genre genre) {
    final currentGenres = state.genres ?? [];
    if (currentGenres.any((g) => g.id == genre.id)) {
      final updatedGenres = currentGenres.where((g) => g.id != genre.id).toList();
      state = state.copyWith(genres: updatedGenres);
    } else {
      final updatedGenres = [...currentGenres, genre];
      state = state.copyWith(genres: updatedGenres);
    }
  }

  void toggleSortOrderFilter(SortOrder sortOrder) {
    state = state.copyWith(sortOrder: sortOrder);
  }

  void toggleSortDirectionFilter(SortDirection sortDirection) {
    state = state.copyWith(sortDirection: sortDirection);
  }

  void toggleWatchProviderFilter(WatchProvider provider) {
    final currentProviders = state.watchProviders ?? [];
    if (currentProviders.any((p) => p.providerId == provider.providerId)) {
      final updatedProviders = currentProviders.where((p) => p.providerId != provider.providerId).toList();
      state = state.copyWith(watchProviders: updatedProviders);
    } else {
      final updatedProviders = [...currentProviders, provider];
      state = state.copyWith(watchProviders: updatedProviders);
    }
  }

  void updateFilter({
    List<Genre>? genres,
    List<BaseSearchResult>? cast,
    String? country,
    List<WatchProvider>? watchProviders,
    SortOrder? sortOrder,
    SortDirection? sortDirection,
  }) {
    state = state.copyWith(
      genres: genres,
      cast: cast,
      country: country,
      watchProviders: watchProviders,
      sortOrder: sortOrder,
      sortDirection: sortDirection,
    );
  }
}

class DiscoverFilterState {
  final List<Genre>? genres;
  final List<BaseSearchResult>? cast;
  final String? country;
  final List<WatchProvider>? watchProviders;
  final SortOrder? sortOrder;
  final SortDirection? sortDirection;

  String? get sortBy {
    if (sortOrder == null) return null;
    String direction = sortDirection == SortDirection.desc ? '.desc' : '.asc';
    return '${sortOrder!.value}$direction';
  }

  DiscoverFilterState({this.genres, this.cast, this.country, this.watchProviders, this.sortOrder, this.sortDirection});

  copyWith({
    List<Genre>? genres,
    List<BaseSearchResult>? cast,
    String? country,
    List<WatchProvider>? watchProviders,
    SortOrder? sortOrder,
    SortDirection? sortDirection,
  }) {
    return DiscoverFilterState(
      genres: genres ?? this.genres,
      cast: cast ?? this.cast,
      country: country ?? this.country,
      watchProviders: watchProviders ?? this.watchProviders,
      sortOrder: sortOrder ?? this.sortOrder,
      sortDirection: sortDirection ?? this.sortDirection,
    );
  }
}
