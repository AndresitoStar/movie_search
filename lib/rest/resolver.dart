
import 'package:dio/dio.dart';

abstract class BaseService {
  Dio clientTMDB;
  Dio clientOMDB;
  Dio parseClient;

  final Map<String, dynamic> _baseParams = {
    'api_key': '3e56846ee7cfb0b7d870484a9f66218c',
    'language': 'es-ES',
  };

  Map<String, dynamic> get baseParams => {..._baseParams};
  
  final Map<String, dynamic> _baseParseParams = {
    'X-Parse-Application-Id': 'gvoaJEkVpRdAftO8vI9uKQZZA6m7llGC05QkQBa1',
    'X-Parse-REST-API-Key': '7BYTnyTQt9Pw1XEpSF0k6ygIF4f0VxXUnKcOdVSC',
  };

  Map<String, dynamic> get baseParseParams => {..._baseParseParams};

  BaseService() {
    clientTMDB = new Dio();
    clientTMDB.options.baseUrl = 'https://api.themoviedb.org/3/';
    clientTMDB.options.connectTimeout = 20000; //5s
    clientTMDB.options.receiveTimeout = 20000;

    clientOMDB = new Dio();
    clientOMDB.options.baseUrl = 'https://www.omdbapi.com';
    clientOMDB.options.connectTimeout = 20000;
    clientOMDB.options.receiveTimeout = 20000;

    parseClient = new Dio();
    parseClient.options.baseUrl = 'https://parseapi.back4app.com/parse/';
    parseClient.options.connectTimeout = 20000; //5s
    parseClient.options.receiveTimeout = 20000;
    parseClient.options.headers = _baseParseParams;
  }
}
