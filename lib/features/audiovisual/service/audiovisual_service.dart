import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_search/common/model/external_id.dart';
import 'package:movie_search/common/model/media_image.dart';
import 'package:movie_search/common/model/movie.dart';
import 'package:movie_search/common/model/person.dart';
import 'package:movie_search/common/model/search_response.dart';
import 'package:movie_search/common/model/tv.dart';
import 'package:movie_search/common/model/video.dart';
import 'package:movie_search/core/network/dio_factory.dart';
import 'package:retrofit/retrofit.dart';

part 'audiovisual_service.g.dart';

@injectable
@RestApi()
abstract class AudiovisualService {
  @factoryMethod
  factory AudiovisualService.create(@Named(MyClientsConst.tmdbClient) Dio dio) = _AudiovisualService;

  @GET('/{type}/{id}')
  Future<BaseResult> getDetails(@Path('type') String type, @Path('id') num id);

  @GET('/{type}/{id}/images')
  Future<MediaImageResponse> getImages(
    @Path('type') String type,
    @Path('id') num id, {
    @Query('include_image_language') String includeImageLanguage = 'en,null',
  });

  @GET('/{type}/{id}/external_ids')
  Future<ExternalIdResponse> getExternalIds(@Path('type') String type, @Path('id') num id);

  @GET('/{type}/{id}/content_ratings')
  Future<ContentRatings> getContentRatings(@Path('type') String type, @Path('id') num id);

  @GET('/{type}/{id}/videos')
  Future<Videos> getVideos(@Path('type') String type, @Path('id') num id);

  @GET('/{type}/{id}/credits')
  Future<Credit> getCredits(@Path('type') String type, @Path('id') String id);

  @GET('/{type}/{id}/recommendations')
  Future<SearchResponse> getRecommendation(@Path('type') String type, @Path('id') String id);

  @GET('/collection/{id}')
  Future<Collection> getCollectionDetail(@Path('id') String id);

  @GET('/{type}/{id}/watch/providers')
  Future<WatchProviderResponse> getWatchProviders(@Path('type') String type, @Path('id') String id);
}
