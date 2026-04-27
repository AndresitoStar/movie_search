import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_search/core/network/dio_factory.dart';

@module
abstract class DioRegister {
  @Named(MyClientsConst.tmdbClient)
  @lazySingleton
  Dio get tmdbDio => MyDioFactory.tmdbDio;

  @Named(MyClientsConst.omdbClient)
  @lazySingleton
  Dio get omdbDio => MyDioFactory.omdbDio;
}
