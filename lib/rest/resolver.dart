import 'package:dio/dio.dart';
import 'package:movie_search/model/api/models/api.dart';
import 'package:movie_search/modules/audiovisual/model/image.dart';

enum MediaImageType { POSTER, BACKDROP, PROFILES }

extension MediaImageTypeExtension on MediaImageType {
  String get title {
    if (this == MediaImageType.POSTER) {
      return 'Poster';
    } else if (this == MediaImageType.BACKDROP) {
      return 'Backdrop';
    } else if (this == MediaImageType.PROFILES) {
      return 'Profiles';
    }
    return this.toString();
  }
}

abstract class BaseService {
  late Dio clientTMDB;
  late Dio clientOMDB;
  late Dio parseClient;

  static const _DEFAULT_TIMEOUT = 20 * 1000;

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
        final profiles = data['profiles'] as List;
        final backdrops = data['backdrops'] as List;
        final posters = data['posters'] as List;
        final list = [...profiles, ...posters, ...backdrops];
        for (var i = 0; i < list.length; i++) {
          result.add(MediaImage.fromJson(list[i]));
        }
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future<Map<MediaImageType, List<MediaImage>>> getImagesGroup(String type, num typeId) async {
    Map<MediaImageType, List<MediaImage>> result = {};
    try {
      var response = await clientTMDB.get(
        '$type/$typeId/images',
        queryParameters: {
          ...baseParams,
          'include_image_language': 'en,null',
        },
      );
      if (response.statusCode == 200) {
        final data = response.data as Map;
        if (data.containsKey('profiles')) {
          final profiles = data['profiles'] as List;
          result.putIfAbsent(MediaImageType.PROFILES, () => profiles.map((e) => MediaImage.fromJson(e)).toList());
        }
        if (data.containsKey('backdrops')) {
          final backdrops = data['backdrops'] as List;
          result.putIfAbsent(MediaImageType.BACKDROP, () => backdrops.map((e) => MediaImage.fromJson(e)).toList());
        }
        if (data.containsKey('posters')) {
          final posters = data['posters'] as List;
          result.putIfAbsent(MediaImageType.POSTER, () => posters.map((e) => MediaImage.fromJson(e)).toList());
        }
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future<T> sendGET<T>(
    String path,
    T Function(dynamic data) onResult, {
    Map<String, T>? cacheMap,
    String? idCache,
    Map<String, dynamic> params = const {},
  }) async {
    try {
      if (cacheMap != null && idCache != null) if (cacheMap.containsKey(idCache)) return cacheMap[idCache]!;

      var response = await clientTMDB.get(path, queryParameters: {...params, ...baseParams});
      if (response.statusCode == 200) {
        final result = onResult(response.data);
        if (cacheMap != null && idCache != null) cacheMap.putIfAbsent(idCache, () => result);
        return result;
      }
      throw ApiException('<<$path>> ${response.statusMessage}');
    } catch (e) {
      print('<<$path>> $e');
      throw ApiException(e);
    }
  }
}
