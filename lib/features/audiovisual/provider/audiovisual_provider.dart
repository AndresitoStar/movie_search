import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search/common/domain/search_result.dart';
import 'package:movie_search/common/model/media_image.dart';
import 'package:movie_search/common/model/movie.dart';
import 'package:movie_search/common/model/tv.dart';
import 'package:movie_search/common/model/video.dart';
import 'package:movie_search/core/di/injection.dart';
import 'package:movie_search/features/audiovisual/repository/audiovisual_repository.dart';
import 'package:movie_search/features/settings/provider/south_american_countries_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'audiovisual_provider.g.dart';

@riverpod
Future<BaseSearchResult> fetchDetails(Ref ref, num id, String type) async {
  final repository = getIt<AudiovisualRepository>();
  return repository.getDetails(type, id);
}

@riverpod
Future<MediaImageResponse> fetchImages(Ref ref, num id, String type) async {
  final repository = getIt<AudiovisualRepository>();
  return repository.getImages(type, id);
}

@riverpod
Future<num> fetchImdbRating(Ref ref, num id, String type, String? imdbId) async {
  final repository = getIt<AudiovisualRepository>();
  return repository.getImdbRating(id: id, type: type, imdbId: imdbId);
}

@riverpod
Future<ContentRatings> fetchContentRatings(Ref ref, num id, String type) async {
  final repository = getIt<AudiovisualRepository>();
  return repository.getContentRatings(type, id);
}

@riverpod
Future<Videos> fetchVideos(Ref ref, num id, String type) async {
  final repository = getIt<AudiovisualRepository>();
  return repository.getVideos(type, id);
}

@riverpod
Future<Collection> fetchCollectionDetails(Ref ref, String id) async {
  final repository = getIt<AudiovisualRepository>();
  return repository.getCollectionDetails(id);
}

@riverpod
Future<List<WatchProvider>> fetchWatchProvider(Ref ref, num id, String type) async {
  final repository = getIt<AudiovisualRepository>();
  final response = await repository.getWatchProviders(type, id.toString());
  final region = await ref.read(selectedCountryProvider.future);
  return response.results[region.iso31661] ?? [];
}
