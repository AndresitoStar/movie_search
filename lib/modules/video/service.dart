import 'package:movie_search/model/api/models/video.dart';
import 'package:movie_search/rest/resolver.dart';

class VideoService extends BaseService {
  static VideoService? _instance;

  static VideoService getInstance() {
    if (_instance == null) _instance = VideoService._();
    return _instance!;
  }

  VideoService._() : super();

  final Map<String, List<Video>> _cacheVideos = {};
  final Map<String, List<Video>> _cacheEpisodesVideos = {};

  Future<List<Video>> getVideos(String type, num typeId) async {
    return sendGET<List<Video>>(
      '$type/$typeId/videos',
      (data) {
        List<Video> result = [];
        final list = data['results'] as List?;
        if (list != null) {
          for (var i = 0; i < list.length; i++) {
            Video v = Video.fromJson(list[i]);
            result.add(v);
          }
        }
        return result;
      },
      idCache: '$type-$typeId',
      cacheMap: _cacheVideos,
    );
  }

  Future<List<Video>> getEpisodeVideos(num tvShowId, num seasonNumber, num episodeNumber) async {
    return sendGET<List<Video>>(
      'tv/$tvShowId/season/$seasonNumber/episode/$episodeNumber/videos',
      (data) {
        List<Video> result = [];
        final list = data['results'] as List?;
        if (list != null) {
          for (var i = 0; i < list.length; i++) {
            Video v = Video.fromJson(list[i]);
            result.add(v);
          }
        }
        return result;
      },
      idCache: '$tvShowId-$seasonNumber-$episodeNumber',
      cacheMap: _cacheEpisodesVideos,
    );
  }
}
