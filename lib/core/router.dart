import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search/common/domain/search_result.dart';
import 'package:movie_search/common/model/media_image.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:movie_search/features/audiovisual/ui/pages/basic_list.dart';
import 'package:movie_search/features/audiovisual/ui/pages/detail_page.dart';
import 'package:movie_search/features/audiovisual/ui/pages/images_page.dart';
import 'package:movie_search/features/audiovisual/ui/pages/season_detail.dart';
import 'package:movie_search/features/audiovisual/ui/pages/videos_page.dart';
import 'package:movie_search/features/discover/ui/discover_page.dart';
import 'package:movie_search/features/home/ui/home_page.dart';
import 'package:movie_search/features/user/ui/favourites_page.dart';
import 'package:movie_search/features/user/ui/profile_page.dart';
import 'package:movie_search/features/search/ui/search_page.dart';
import 'package:movie_search/features/settings/ui/settings_page.dart';
import 'package:movie_search/features/splash/splash_page.dart';

part 'router.g.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

@Riverpod(keepAlive: true)
GoRouter approuter(Ref ref) {
  return GoRouter(
    navigatorKey: AppNotificationsService.navigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: true,
    observers: [routeObserver],
    routes: [
      GoRoute(path: '/', builder: (context, state) => SplashPage()),
      GoRoute(path: HomePage.routeName, builder: (context, state) => const HomePage()),
      GoRoute(path: '/search', builder: (context, state) => const SearchPage()),
      GoRoute(path: '/discover', builder: (context, state) => const DiscoverPage()),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
        routes: [GoRoute(path: '/favourites', builder: (context, state) => const FavouritesPage())],
      ),
      GoRoute(path: '/settings', builder: (context, state) => const SettingsPage()),
      // GoRoute(
      //   path: '/person/:id/combined_credits',
      //   builder: (context, state) => const AudiovisualListPage(title: 'Combined Credits'),
      // ),
      // GoRoute(
      //   path: '/person/:id/tagged_images',
      //   builder: (context, state) => const AudiovisualListPage(title: 'Tagged Images'),
      // ),

      GoRoute(path: '/tv/:id/season/:season_number', builder: (context, state) => const SeasonDetail()),
      ...types.map((type) {
        return GoRoute(
          path: '/$type/:id',
          builder: (context, state) {
            final extra = state.extra;
            if (extra != null &&
                extra is Map<String, dynamic> &&
                extra.containsKey('item') &&
                extra.containsKey('tag')) {
              final item = extra['item'];
              final tag = extra['tag'];
              if (item != null && item is BaseSearchResult && tag != null && tag is String) {
                final heroTagPrefix = '$tag-${item.id}';
                return DetailPage(item: item, heroTagPrefix: heroTagPrefix);
              }
            }
            throw Exception('DetailPage requires a BaseSearchResult item passed in extra parameter');
          },
        );
      }),
      GoRoute(
        path: '/images',
        builder: (context, state) {
          final extra = state.extra;
          if (extra != null &&
              extra is Map<String, dynamic> &&
              extra.containsKey('title') &&
              extra.containsKey('images')) {
            final title = extra['title'];
            final images = extra['images'];
            if (title != null &&
                title is String &&
                images != null &&
                images is Map<MediaImageType, List<MediaImage>>) {
              return ImagesPage(title: title, imagesMap: images);
            }
          }
          throw Exception('ImagesPage requires a title and imagesMap passed in extra parameter');
        },
      ),
      GoRoute(
        path: '/album',
        builder: (context, state) {
          final extra = state.extra;
          if (extra != null &&
              extra is Map<String, dynamic> &&
              extra.containsKey('type') &&
              extra.containsKey('images')) {
            final type = extra['type'];
            final images = extra['images'];
            if (type != null && type is MediaImageType && images != null && images is List<MediaImage>) {
              return AlbumPage(type: type, images: images);
            }
          }
          throw Exception('AlbumPage requires a type and images passed in extra parameter');
        },
      ),
      // GoRoute(
      //   path: 'recommendations',
      //   builder: (context, state) => const AudiovisualListPage(title: 'Recommendations'),
      // ),
      // GoRoute(
      //   path: 'similar',
      //   builder: (context, state) => const AudiovisualListPage(title: 'Similar'),
      // ),
      GoRoute(
        path: '/items-preview',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return AudiovisualListPage(params: extra);
        },
      ),
      GoRoute(path: 'videos', builder: (context, state) => const VideosPage()),
    ],
  );
}

class AppNotificationsService {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

List<String> get types => ['movie', 'tv', 'person'];

List<String> get typesWithoutPerson => ['movie', 'tv'];
