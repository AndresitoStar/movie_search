import 'package:movie_search/rest/resolver.dart';

class SplashService extends BaseService {

  static SplashService _instance;

  static SplashService getInstance() {
    if (_instance == null) _instance = SplashService._();
    return _instance;
  }

  SplashService._() : super();

  Future<Map<String, String>> getCountries() async {
    Map<String, String> result = {};

    try {
      var response = await clientTMDB.get('/configuration/countries',
          queryParameters: baseParams);
      if (response.statusCode == 200) {
        var body = response.data as List<dynamic>;
        if (body.isNotEmpty) {
          result = Map.fromIterable(body,
              key: (item) => item['iso_3166_1'],
              value: (item) => item['english_name']);
        }
      } else {
        print(response.statusCode);
        //TODO LANZAR EXCEPTION
      }
    } catch (e) {
      print(e);
    }

    return result;
  }

  Future<Map<String, String>> getLanguages() async {
    Map<String, String> result = {};

    try {
      var response = await clientTMDB.get('/configuration/languages',
          queryParameters: baseParams);
      if (response.statusCode == 200) {
        var body = response.data as List<dynamic>;
        if (body.isNotEmpty) {
          result = Map.fromIterable(body,
              key: (item) => item['iso_639_1'],
              value: (item) => item['english_name']);
        }
      } else {
        print(response.statusCode);
        //TODO LANZAR EXCEPTION
      }
    } catch (e) {
      print(e);
    }

    return result;
  }

  Future<Map<int, String>> getGenres(String type) async {
    Map<int, String> result = {};

    try {
      var response = await clientTMDB.get('/genre/$type/list',
          queryParameters: baseParams);
      if (response.statusCode == 200) {
        var body = response.data['genres'] as List<dynamic>;
        if (body.isNotEmpty) {
          result = Map.fromIterable(body,
              key: (item) => item['id'],
              value: (item) => item['name']);
        }
      } else {
        print(response.statusCode);
        //TODO LANZAR EXCEPTION
      }
    } catch (e) {
      print(e);
    }

    return result;
  }
}
