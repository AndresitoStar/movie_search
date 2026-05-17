import 'package:injectable/injectable.dart';
import 'package:movie_search/common/domain/search_result.dart';
import 'package:movie_search/common/model/media_image.dart';
import 'package:movie_search/common/model/movie.dart';
import 'package:movie_search/common/model/person.dart';
import 'package:movie_search/common/model/search_response.dart';
import 'package:movie_search/common/model/tv.dart';
import 'package:movie_search/common/model/video.dart';
import 'package:movie_search/features/audiovisual/service/audiovisual_service.dart';
import 'package:movie_search/features/audiovisual/service/imdb_service.dart';

@lazySingleton
class AudiovisualRepository {
  final AudiovisualService _service;
  final ImdbService _imdbService;
  final Map<String, BaseSearchResult> _cache = {};
  final Map<String, MediaImageResponse> _imageCache = {};
  final Map<num, num> _cacheImdbRating = {};
  final Map<String, ContentRatings> _contentRatingsCache = {};
  final Map<String, Videos> _contentVideosCache = {};
  final Map<String, Credit> _contentCreditCache = {};
  final Map<String, CombinedCredits> _contentCombinedCreditCache = {};
  final Map<String, SearchResponse> _recommendationsCache = {};
  final Map<String, Collection> _contentCollectionCache = {};
  final Map<String, WatchProviderResponse> _contentWatchProvidersCache = {};

  AudiovisualRepository(this._service, this._imdbService);

  Future<BaseSearchResult> getDetails(String type, num id) async {
    final cacheKey = '$type-$id';
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey]!;
    } else {
      final result = await _service.getDetails(type, id);
      final baseResult = result.buildFrom(type);
      _cache[cacheKey] = baseResult;
      return baseResult;
    }
  }

  Future<MediaImageResponse> getImages(String type, num id) async {
    final cacheKey = '$type-$id';
    if (_imageCache.containsKey(cacheKey)) {
      return _imageCache[cacheKey]!;
    } else {
      final images = await _service.getImages(type, id);
      _imageCache[cacheKey] = images;
      return images;
    }
  }

  Future<num> getImdbRating({String? imdbId, required String type, required num id}) async {
    try {
      if (imdbId == null) {
        final externalId = await _service.getExternalIds(type, id);
        imdbId = externalId.imdbId;
      }
      if (imdbId != null) {
        final result = await _imdbService.getImdbRating(imdbId);
        if (result.imdbRating != null) {
          if (result.imdbRating == 'N/A') return -1;
          final numResult = num.parse(result.imdbRating!);
          _cacheImdbRating.putIfAbsent(id, () => numResult);
          return numResult;
        }
      }
    } catch (e) {
      rethrow;
    }
    return -1;
  }

  Future<ContentRatings> getContentRatings(String type, num id) async {
    final cacheKey = '$type-$id';
    if (_contentRatingsCache.containsKey(cacheKey)) {
      return _contentRatingsCache[cacheKey]!;
    } else {
      final ratings = await _service.getContentRatings(type, id);
      _contentRatingsCache[cacheKey] = ratings;
      return ratings;
    }
  }

  Future<Videos> getVideos(String type, num id) async {
    final cacheKey = '$type-$id';
    if (_contentVideosCache.containsKey(cacheKey)) {
      return _contentVideosCache[cacheKey]!;
    } else {
      final videos = await _service.getVideos(type, id);
      _contentVideosCache[cacheKey] = videos;
      return videos;
    }
  }

  Future<Credit> getCredit(String type, String id) async {
    final cacheKey = '$type-$id';
    if (_contentCreditCache.containsKey(cacheKey)) {
      return _contentCreditCache[cacheKey]!;
    } else {
      final credits = await _service.getCredits(type, id);
      _contentCreditCache[cacheKey] = credits;
      return credits;
    }
  }

  Future<SearchResponse> getRecommendations(String type, String id) async {
    final cacheKey = '$type-$id';
    if (_recommendationsCache.containsKey(cacheKey)) {
      return _recommendationsCache[cacheKey]!;
    } else {
      final recommendations = await _service.getRecommendation(type, id);
      _recommendationsCache[cacheKey] = recommendations;
      return recommendations;
    }
  }

  Future<Collection> getCollectionDetails(String id) async {
    final cacheKey = id;
    if (_contentCollectionCache.containsKey(cacheKey)) {
      return _contentCollectionCache[cacheKey]!;
    } else {
      final result = await _service.getCollectionDetail(id);
      _contentCollectionCache[cacheKey] = result;
      return result;
    }
  }

  Future<WatchProviderResponse> getWatchProviders(String type, String id) async {
    final cacheKey = '$type-$id';
    if (_contentWatchProvidersCache.containsKey(cacheKey)) {
      return _contentWatchProvidersCache[cacheKey]!;
    } else {
      final result = await _service.getWatchProviders(type, id);
      _contentWatchProvidersCache[cacheKey] = result;
      return result;
    }
  }

  Future<CombinedCredits> getCombinedCreditsForPerson(String id) async {
    final cacheKey = id;
    if (_contentCombinedCreditCache.containsKey(cacheKey)) {
      return _contentCombinedCreditCache[cacheKey]!;
    } else {
      final credits = await _service.getCombinedCredits(id);
      _contentCombinedCreditCache[cacheKey] = credits;
      return credits;
    }
  }
}
