// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:movie_search/common/network/base_content_service.dart' as _i349;
import 'package:movie_search/common/network/config_service.dart' as _i224;
import 'package:movie_search/common/repository/content_preview_repository.dart'
    as _i273;
import 'package:movie_search/core/di/register_modules/dio_register.dart'
    as _i120;
import 'package:movie_search/features/audiovisual/repository/audiovisual_repository.dart'
    as _i836;
import 'package:movie_search/features/audiovisual/service/audiovisual_service.dart'
    as _i737;
import 'package:movie_search/features/audiovisual/service/imdb_service.dart'
    as _i493;
import 'package:movie_search/features/discover/discover_repository.dart'
    as _i240;
import 'package:movie_search/features/discover/network/discover_service.dart'
    as _i721;
import 'package:movie_search/features/search/network/search_service.dart'
    as _i107;
import 'package:movie_search/features/search/search_repository.dart' as _i729;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioRegister = _$DioRegister();
    gh.lazySingleton<_i273.ContentPreviewRepository>(
      () => _i273.ContentPreviewRepository(),
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioRegister.omdbDio,
      instanceName: 'omdbClient',
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioRegister.tmdbDio,
      instanceName: 'tmdbClient',
    );
    gh.factory<_i493.ImdbService>(
      () => _i493.ImdbService.create(gh<_i361.Dio>(instanceName: 'omdbClient')),
    );
    gh.factory<_i349.BaseContentService>(
      () => _i349.BaseContentService.create(
        gh<_i361.Dio>(instanceName: 'tmdbClient'),
      ),
    );
    gh.factory<_i224.ConfigService>(
      () =>
          _i224.ConfigService.create(gh<_i361.Dio>(instanceName: 'tmdbClient')),
    );
    gh.factory<_i737.AudiovisualService>(
      () => _i737.AudiovisualService.create(
        gh<_i361.Dio>(instanceName: 'tmdbClient'),
      ),
    );
    gh.factory<_i721.DiscoverService>(
      () => _i721.DiscoverService.create(
        gh<_i361.Dio>(instanceName: 'tmdbClient'),
      ),
    );
    gh.factory<_i107.SearchService>(
      () =>
          _i107.SearchService.create(gh<_i361.Dio>(instanceName: 'tmdbClient')),
    );
    gh.factory<_i224.ConfigRepository>(
      () => _i224.ConfigRepository(gh<_i224.ConfigService>()),
    );
    gh.lazySingleton<_i240.DiscoverRepository>(
      () => _i240.DiscoverRepository(gh<_i721.DiscoverService>()),
    );
    gh.lazySingleton<_i836.AudiovisualRepository>(
      () => _i836.AudiovisualRepository(
        gh<_i737.AudiovisualService>(),
        gh<_i493.ImdbService>(),
      ),
    );
    gh.lazySingleton<_i729.SearchRepository>(
      () => _i729.SearchRepository(gh<_i107.SearchService>()),
    );
    return this;
  }
}

class _$DioRegister extends _i120.DioRegister {}
