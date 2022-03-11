import 'package:movie_search/model/api/models/video.dart';
import 'package:movie_search/rest/resolver.dart';

class VideoService extends BaseService {
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
    );
  }
}
