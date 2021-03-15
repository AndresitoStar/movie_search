import 'package:movie_search/rest/resolver.dart';

class SplashService extends BaseService {
  static SplashService _instance;

  static SplashService getInstance() {
    if (_instance == null) _instance = SplashService._();
    return _instance;
  }

  SplashService._() : super();

  Future<bool> checkIsDeviceEnable(String deviceId) async {
    // try {
      final response =
          await parseClient.get('/classes/devices', queryParameters: {
        'where': {"deviceId": deviceId},
      });
      final results = response.data['results'] as List;
      if (results.isNotEmpty) {
        final config = results[0]['isEnabled'] as bool;
        return config;
      } else {
        await insertMyDevice(deviceId);
      }
    // }
    // catch (e) {
      // print(e);
    // }
    return false;
  }

  Future updateMyDevice(
      String deviceId, {String email, String phoneModel}) async {
    // try {
      final response =
          await parseClient.get('/classes/devices', queryParameters: {
        'where': {"deviceId": deviceId},
      });
      final results = response.data['results'] as List;
      if (results.isNotEmpty) {
        final id = results[0]['objectId'] as String;
        return parseClient.put('/classes/devices/$id', data: {
          if (email != null) "email": email,
          "phone_model": phoneModel,
        });
      }
    // } catch (e) {}
  }

  Future insertMyDevice(String deviceId) async {
    // try {
      return parseClient.post('/classes/devices', data: {
        "deviceId": deviceId,
      }, queryParameters: {
        ...baseParseParams,
        "Content-Type": 'application/json',
      });
    // } catch (e) {
    //   print(e);
    // }
  }

  Future<Map<String, String>> getCountries() async {
    Map<String, String> result = {};

    // try {
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
    // } catch (e) {
    //   print(e);
    // }

    return result;
  }

  Future<Map<String, String>> getLanguages() async {
    Map<String, String> result = {};

    // try {
      var response = await clientTMDB.get('/configuration/languages',
          queryParameters: baseParams);
      if (response.statusCode == 200) {
        var body = response.data as List<dynamic>;
        if (body.isNotEmpty) {
          result = Map.fromIterable(body,
              key: (item) => item['iso_639_1'],
              value: (item) => item['english_name']);
        }
      // } else {
      //   print(response.statusCode);
        //TODO LANZAR EXCEPTION
      }
    // } catch (e) {
      // print(e);
    // }

    return result;
  }

  Future<Map<int, String>> getGenres(String type) async {
    Map<int, String> result = {};

    // try {
      var response = await clientTMDB.get('/genre/$type/list',
          queryParameters: baseParams);
      if (response.statusCode == 200) {
        var body = response.data['genres'] as List<dynamic>;
        if (body.isNotEmpty) {
          result = Map.fromIterable(body,
              key: (item) => item['id'], value: (item) => item['name']);
        }
      } else {
        print(response.statusCode);
        //TODO LANZAR EXCEPTION
      }
    // } catch (e) {
      // print(e);
    // }

    return result;
  }
}
