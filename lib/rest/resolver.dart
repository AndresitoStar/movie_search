
import 'package:dio/dio.dart';

abstract class BaseService {
  Dio clientTMDB;
  Dio clientOMDB;

  final Map<String, dynamic> _baseParams = {
    'api_key': '3e56846ee7cfb0b7d870484a9f66218c',
    'language': 'es-ES',
  };

  Map<String, dynamic> get baseParams => {..._baseParams};

  BaseService() {
    clientTMDB = new Dio();
    clientTMDB.options.baseUrl = 'https://api.themoviedb.org/3/';
    clientTMDB.options.connectTimeout = 20000; //5s
    clientTMDB.options.receiveTimeout = 20000;

    clientOMDB = new Dio();
    clientOMDB.options.baseUrl = 'https://www.omdbapi.com';
    clientOMDB.options.connectTimeout = 20000;
    clientOMDB.options.receiveTimeout = 20000;
  }
}
