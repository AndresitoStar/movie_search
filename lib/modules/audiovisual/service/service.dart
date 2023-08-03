import 'package:movie_search/model/api/models/movie.dart';
import 'package:movie_search/model/api/models/person.dart';
import 'package:movie_search/model/api/models/tv.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_recomendations_viewmodel.dart';
import 'package:movie_search/rest/resolver.dart';

class AudiovisualService extends BaseService {
  static AudiovisualService? _instance;

  static AudiovisualService getInstance() {
    if (_instance == null) _instance = AudiovisualService._();
    return _instance!;
  }

  AudiovisualService._() : super();

  final Map<String, dynamic> _cacheById = {};
  final Map<String, List<BaseSearchResult>> _cacheRecommendation = {};
  final Map<String, Collection> _cacheCollection = {};
  final Map<String, Seasons> _cacheSeason = {};
  final Map<String, Episode> _cacheEpisode = {};
  final Map<String, List<BaseSearchResult>> _cacheCredits = {};

  Future<dynamic> getById({required String type, required num id}) async => sendGET(
        '$type/$id',
        (data) => type == 'person'
            ? Person.fromJson(data)
            : type == 'movie'
                ? Movie.fromJson(data)
                : type == 'tv'
                    ? TvShow.fromJson(data)
                    : null,
        params: {'include_image_language': 'en,null'},
        idCache: '$id',
        cacheMap: _cacheById,
      );

  Future<List<BaseSearchResult>> getRecommendations(
          String type, num typeId, ERecommendationType recommendationType) async =>
      sendGET<List<BaseSearchResult>>(
        '$type/$typeId/${recommendationType.type}',
        (data) {
          final list = data['results'] as List;
          final result = list.map((e) => BaseSearchResult.fromJson(type, e)).toList();
          if (result.isNotEmpty)
            result.sort((a, b) => a.year == null || b.year == null ? 1 : b.year!.compareTo(a.year!));
          return result;
        },
        cacheMap: _cacheRecommendation,
        idCache: '$typeId$type${recommendationType.type}',
      );

  Future<Collection> getCollection(num id) async => sendGET<Collection>(
        'collection/$id',
        (data) => Collection.fromJson(data),
        idCache: '$id',
        cacheMap: _cacheCollection,
      );

  Future<Seasons> getSeason(num id, num seasonNumber) async => sendGET<Seasons>(
        'tv/$id/season/$seasonNumber',
        (data) => Seasons.fromJson(data),
        cacheMap: _cacheSeason,
        idCache: '$id$seasonNumber',
      );

  Future<Episode> getEpisode(num tvShowId, num seasonNumber, num episodeNumber) async => sendGET<Episode>(
        'tv/$tvShowId/season/$seasonNumber/episode/$episodeNumber',
        (data) => Episode.fromJson(data),
        cacheMap: _cacheEpisode,
        idCache: '$tvShowId-$seasonNumber-$episodeNumber',
      );

  Future<WatchProviderResponse> getWatchProviders({required String type, required num id}) async =>
      sendGET<WatchProviderResponse>(
        '$type/$id/watch/providers',
        (data) => WatchProviderResponse.fromJson(data['results']),
        cacheMap: {},
        idCache: '$type-$id-watch/providers',
      );

  Future<List<BaseSearchResult>> getPersonCombinedCredits(num id) async =>
      sendGET<List<BaseSearchResult>>('person/$id/combined_credits', (data) {
        List<BaseSearchResult> result = [];
        if (data['cast'] != null) {
          data['cast'].forEach((v) {
            final type = v['media_type'];
            result.add(BaseSearchResult.fromJson(type, v));
          });
        }
        if (data['crew'] != null) {
          data['crew'].forEach((v) {
            final type = v['media_type'];
            result.add(BaseSearchResult.fromJson(type, v));
          });
        }
        result.sort((a, b) => a.year == null || b.year == null ? 1 : b.year!.compareTo(a.year!));
        return result;
      }, cacheMap: _cacheCredits, idCache: '$id');
}
