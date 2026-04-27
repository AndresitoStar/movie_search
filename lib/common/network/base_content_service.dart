import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_search/common/model/search_response.dart';
import 'package:movie_search/core/network/dio_factory.dart';

@injectable
class BaseContentService {
  final Dio dio;

  @factoryMethod
  BaseContentService.create(@Named(MyClientsConst.tmdbClient) this.dio);

  Future<SearchResponse> getContent(String uri) async {
    try {
      final response = await dio.get(uri);
      return SearchResponse.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<SearchResponse> getContentPaginated(String uri, int page) async {
    try {
      final response = await dio.get(uri, queryParameters: {'page': page});
      return SearchResponse.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
