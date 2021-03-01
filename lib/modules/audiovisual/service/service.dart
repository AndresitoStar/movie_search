import 'package:flutter/cupertino.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_recomendations_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/rest/resolver.dart';

class AudiovisualService extends BaseService {
  static AudiovisualService _instance;

  static AudiovisualService getInstance() {
    if (_instance == null) _instance = AudiovisualService._();
    return _instance;
  }

  AudiovisualService._() : super();

  Future<dynamic> getById({@required String type,@required int id}) async {
    Map<String, String> params = {
      ...baseParams,
      'include_image_language': 'en,null'
    };

    var response = await clientTMDB.get('$type/$id', queryParameters: params);
    if (response.statusCode == 200) {
      final data = response.data;
      if (type == 'person') {
        return ResponseApiParser.personFromJsonApi(data);
      } else if (type == 'movie') {
        return ResponseApiParser.movieFromJsonApi(data);
      } else if (type == 'tv') {
        return ResponseApiParser.tvFromJsonApi(data);
      }
    }
    return null;
  }

  Future<List<BaseSearchResult>> getRecommendations(
      String type, int typeId, ERecommendationType recommendationType) async {
    List<BaseSearchResult> result = [];
    try {
      var response = await clientTMDB.get('$type/$typeId/${recommendationType.type}',
          queryParameters: baseParams);
      if (response.statusCode == 200) {
        final data = response.data;
        final list = data['results'] as List;
        if (list != null) {
          for (var i = 0; i < list.length; i++) {
            BaseSearchResult b = BaseSearchResult.fromJson(type, list[i]);
            if (b != null) result.add(b);
          }
        }
      }
    } catch (e) {
    }
    return result;
  }

  Future<String> _getImdbRating(String imdbId) async {
    try {
      var params = {'apikey': '9eb7fce9', 'i': imdbId, 'r': 'json'};
      var response = await clientOMDB.get('/', queryParameters: params);
      if (response.statusCode == 200) {
        var result = response.data;
        return result["imdbRating"];
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
