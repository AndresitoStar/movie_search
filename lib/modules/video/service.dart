import 'package:movie_search/modules/audiovisual/model/serie.dart';
import 'package:movie_search/rest/resolver.dart';

class VideoService extends BaseService {
  Future<List<Video>> getVideos(String type, int typeId) async {
    List<Video> result = [];
    try {
      var response = await clientTMDB.get('$type/$typeId/videos',
          queryParameters: baseParams);
      if (response.statusCode == 200) {
        final data = response.data;
        final list = data['results'] as List;
        if (list != null) {
          for (var i = 0; i < list.length; i++) {
            Video v = Video.fromJson(list[i]);
            if (v != null) result.add(v);
          }
        }
      }
    } catch (e) {}
    return result;
  }
}
