import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_search/common/model/search_response.dart';
import 'package:movie_search/core/network/dio_factory.dart';
import 'package:retrofit/retrofit.dart';

part 'search_service.g.dart';

@injectable
@RestApi()
abstract class SearchService {
  @factoryMethod
  factory SearchService.create(@Named(MyClientsConst.tmdbClient) Dio dio) = _SearchService;

  @GET('/search/multi')
  Future<SearchResponse> search({
    @Query('page') int page = 1,
    @Query('query') required String query,
  });
}