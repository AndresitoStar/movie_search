import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search/common/domain/search_result.dart';
import 'package:movie_search/common/model/genre.dart';
import 'package:movie_search/common/model/tmdb_type.dart';
import 'package:movie_search/core/di/injection.dart';
import 'package:movie_search/features/discover/discover_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_provider.g.dart';

@Riverpod(keepAlive: true)
class HomeContentType extends _$HomeContentType {
  final String key = "home_content_type";

  @override
  Future<TMDB_API_TYPE> build() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final type = prefs.getString(key);
    return tmdbFromString(type);
  }

  Future updateCurrentType(TMDB_API_TYPE type) async {
    state = AsyncData(type);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, type.type);
  }
}

@Riverpod(keepAlive: true)
class HomeGenreCarouseSelected extends _$HomeGenreCarouseSelected {
  @override
  Genre? build() {
    return null;
  }

  void updateSelectedGenre(Genre? genre) {
    state = genre;
  }
}

@Riverpod(keepAlive: true)
Future<List<BaseSearchResult>> itemsForActualGenre(Ref ref) async {
  try {
    final contentTypeProvider = ref.watch(homeContentTypeProvider);
    final genreSelected = ref.watch(homeGenreCarouseSelectedProvider);

    if (!contentTypeProvider.hasValue && genreSelected == null) return [];
    final repository = getIt<DiscoverRepository>();
    final response = await repository.getDiscover(
        type: contentTypeProvider.value!.type,
        genre: genreSelected?.id.toString(), page: 1
    );
    return response.result;
  } catch (e) {
    // Handle error appropriately, e.g., log it or show a message to the user
    print('Error fetching items for genre: $e');
  }
  return [];
}
