import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_search/common/model/search_response.dart';
import 'package:movie_search/core/network/dio_factory.dart';
import 'package:retrofit/retrofit.dart';

part 'discover_service.g.dart';

@injectable
@RestApi()
abstract class DiscoverService {
  @factoryMethod
  factory DiscoverService.create(@Named(MyClientsConst.tmdbClient) Dio dio) = _DiscoverService;

  @GET('/discover/{type}')
  Future<SearchResponse> getDiscover({
    @Path('type') required String type,
    @Query('page') int page = 1,
    @Query('with_genres') String? genre,
    @Query('with_people') String? cast,
    @Query('sort_by') String? sortBy,
    @Query('with_watch_providers') String? watchProviders,
    @Query('watch_region') String? watchRegion,
  });
}