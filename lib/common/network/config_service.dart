import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_search/common/model/country.dart';
import 'package:movie_search/common/model/genre.dart';
import 'package:retrofit/retrofit.dart';
import 'package:movie_search/core/network/dio_factory.dart';

part 'config_service.g.dart';

@injectable
@RestApi()
abstract class ConfigService {
  @factoryMethod
  factory ConfigService.create(@Named(MyClientsConst.tmdbClient) Dio dio) = _ConfigService;

  @GET('/configuration/countries')
  Future<List<Country>> getCountries();

  // get genres by type, type is path parameter
  @GET('/genre/{type}/list')
  Future<GenreListResponse> getGenresByType(@Path('type') String type);
}

// class ConfigRepository for manage cache
@injectable
class ConfigRepository {
  final ConfigService _service;
  List<Country>? _countries;
  final Map<String, List<Genre>> _genresByType = {};

  ConfigRepository(this._service);

  Future<List<Country>> getCountries() async {
    if (_countries != null) {
      return _countries!;
    }
    _countries = await _service.getCountries();
    return _countries!;
  }

  Future<List<Genre>> getGenresByType(String type) async {
    if (_genresByType.containsKey(type)) {
      return _genresByType[type]!;
    }
    final response = await _service.getGenresByType(type);
    _genresByType[type] = response.genres;
    return _genresByType[type]!;
  }
}
