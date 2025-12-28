import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_search/common/model/external_id.dart';
import 'package:movie_search/core/network/dio_factory.dart';
import 'package:retrofit/retrofit.dart';

part 'imdb_service.g.dart';

@injectable
@RestApi()
abstract class ImdbService {
  @factoryMethod
  factory ImdbService.create(@Named(MyClientsConst.omdbClient) Dio dio) = _ImdbService;

  @GET('/')
  Future<ImdbRatingResponse> getImdbRating(@Query('i') String imdbId);
}