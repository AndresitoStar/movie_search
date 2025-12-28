import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search/core/di/injection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:movie_search/common/model/genre.dart';
import 'package:movie_search/common/model/tmdb_type.dart';
import 'package:movie_search/common/network/config_service.dart';

part 'genres_provider.g.dart';

@riverpod
Future<List<Genre>> genresByType(Ref ref, TMDB_API_TYPE type) async {
  final repository = getIt<ConfigRepository>();
  return repository.getGenresByType(type.type);
}
