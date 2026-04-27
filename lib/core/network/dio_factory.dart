import 'package:dio/dio.dart';

class MyDioFactory {
  static BaseOptions get defaultOptions => BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
    headers: <String, dynamic>{
      'Accept-Encoding': 'gzip, deflate, br',
      'Accept': 'application/json',
      'Connection': 'keep-alive',
    },
  );

  static Dio get tmdbDio {
    return Dio(defaultOptions.copyWith(
        queryParameters: <String, dynamic>{
          'api_key': '3e56846ee7cfb0b7d870484a9f66218c',
          'language': 'es-ES',
          'include_adult': 'false',
        },
        baseUrl: ServicesPaths.tmdbBaseUrl
    ));
  }

  static Dio get omdbDio {
    return Dio(BaseOptions(
      queryParameters: {"apikey": "9eb7fce9"},
      baseUrl: ServicesPaths.omdbBaseUrl,
    ));
  }
}

class ServicesPaths {
  static const String tmdbBaseUrl = 'https://api.themoviedb.org/3';
  static const String omdbBaseUrl = 'https://www.omdbapi.com/';
}

class MyClientsConst {
  static const String tmdbClient = 'tmdbClient';
  static const String omdbClient = 'omdbClient';
}