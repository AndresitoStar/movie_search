import 'package:dio/dio.dart';
import 'package:movie_search/modules/audiovisual/model/image.dart';

abstract class BaseService {
  Dio clientTMDB;
  Dio clientOMDB;
  Dio parseClient;

  static const _DEFAULT_TIMEOUT = 5 * 1000;

  final Map<String, dynamic> _baseParams = {
    'api_key': '3e56846ee7cfb0b7d870484a9f66218c',
    'language': 'es-ES',
    'include_adult': 'false',
  };

  Map<String, dynamic> get baseParams => {..._baseParams};

  final Map<String, dynamic> _baseParseHeaders = {
    'X-Parse-Application-Id': 'gvoaJEkVpRdAftO8vI9uKQZZA6m7llGC05QkQBa1',
    'X-Parse-REST-API-Key': '7BYTnyTQt9Pw1XEpSF0k6ygIF4f0VxXUnKcOdVSC',
  };

  Map<String, dynamic> get baseParseParams => {..._baseParseHeaders};

  BaseService() {
    clientTMDB = new Dio();
    clientTMDB.options.baseUrl = 'https://api.themoviedb.org/3/';
    clientTMDB.options.connectTimeout = _DEFAULT_TIMEOUT; //5s
    clientTMDB.options.receiveTimeout = _DEFAULT_TIMEOUT;

    clientOMDB = new Dio();
    clientOMDB.options.baseUrl = 'https://www.omdbapi.com';
    clientOMDB.options.connectTimeout = _DEFAULT_TIMEOUT;
    clientOMDB.options.receiveTimeout = _DEFAULT_TIMEOUT;
    clientOMDB.options.queryParameters = {"apikey": "9eb7fce9"};

    parseClient = new Dio();
    parseClient.options.baseUrl = 'https://parseapi.back4app.com/parse/';
    parseClient.options.connectTimeout = _DEFAULT_TIMEOUT; //5s
    parseClient.options.receiveTimeout = _DEFAULT_TIMEOUT;
    parseClient.options.headers = _baseParseHeaders;
  }

  Future<List<MediaImage>> getImages(String type, int typeId) async {
    List<MediaImage> result = [];
    try {
      var response = await clientTMDB.get(
        '$type/$typeId/images',
        queryParameters: {
          ...baseParams,
          'include_image_language': 'en,null',
        },
      );
      if (response.statusCode == 200) {
        final data = response.data;
        final profiles = data['profiles'] as List ?? [];
        final posters = data['posters'] as List ?? [];
        final list = [...profiles, ...posters];
        if (list != null) {
          for (var i = 0; i < list.length; i++) {
            MediaImage b = MediaImage.fromJson(list[i]);
            if (b != null) result.add(b);
          }
        }
      }
    } catch (e) {
      print(e);
    }
    return result;
  }
}
