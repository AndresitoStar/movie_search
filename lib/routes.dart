import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search/core/content_preview_page.dart';
import 'package:movie_search/modules/audiovisual/componets/item_collection.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_page.dart';
import 'package:movie_search/modules/audiovisual/componets/item_images_page.dart';
import 'package:movie_search/modules/audiovisual/componets/items_images_button.dart';
import 'package:movie_search/modules/audiovisual/componets/review_page.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/discover/discover_screen.dart';
import 'package:movie_search/modules/favourite/views/favs_screen.dart';
import 'package:movie_search/modules/home/home_screen.dart';
import 'package:movie_search/modules/search/search_screen.dart';
import 'package:movie_search/modules/splash/splash_screen.dart';
import 'package:movie_search/modules/video/video_screen.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/rest/resolver.dart';
import 'package:movie_search/ui/screens/onboard.dart';
import 'package:movie_search/ui/screens/settings.dart';

import 'modules/audiovisual/model/image.dart';

class Routes {
  static final List<GoRoute> _routes = [
    GoRoute(
      path: SplashScreen.route,
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
      routes: [
        GoRoute(
          path: SearchScreen.routeName,
          builder: (context, state) => SearchScreen(),
        ),
        GoRoute(
          path: FavouriteScreen.routeName,
          builder: (context, state) => FavouriteScreen(),
        ),
        GoRoute(
          path: SettingsScreen.routeName,
          builder: (context, state) => SettingsScreen(),
        ),
        GoRoute(
          path: DiscoverScreen.routeName,
          builder: (context, state) => DiscoverScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/preview/:key',
      builder: (context, state) {
        final key = state.pathParameters['key']!;
        return ContentPreviewPage(viewModelInstanceName: key);
      },
    ),
    ...TMDB_API_TYPE.values
        .map(
          (type) => GoRoute(
            path: '/${type.type}/:id',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              final item = BaseSearchResult.lite(
                mediaType: type.type,
                id: int.parse(id),
              );
              return ItemDetailPage(item: item, heroTagPrefix: 'lala');
            },
          ),
        )
        .toList(),
    GoRoute(
      path: '/images',
      builder: (context, state) {
        if (state.extra is Map) {
          final args = state.extra as Map;
          final title = args['title'] as String;
          final images = args['imagesMap'] as Map<MediaImageType, List<MediaImage>>;
          return ItemImagesGroup(title: title, imagesMap: images);
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('Error'),
          ),
          body: Center(
            child: Text('No se proporcionaron argumentos válidos para las imágenes.'),
          ),
        );
      },
      routes: [
        GoRoute(
          path: 'list',
          builder: (context, state) {
            if (state.extra is Map) {
              final args = state.extra as Map;
              final type = args['type'] as MediaImageType;
              final images = args['images'] as List<MediaImage>;
              return ItemImagesPage(type: type, images: images);
            }
            return Scaffold(
              appBar: AppBar(
                title: Text('Error'),
              ),
              body: Center(
                child: Text('No se proporcionaron argumentos válidos para las imágenes.'),
              ),
            );
          },
        )
      ],
    )
  ];

  static GoRouter get go_routes {
    // Print all routes for debugging
    printRoutes(_routes.whereType<GoRoute>().toList());
    return GoRouter(
        initialLocation: SplashScreen.route,
        routes: _routes,
      );
  }

  static Route<dynamic> defaultRoute(String? coso, Widget child) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text('404 - Not Found'),
        ),
      ),
    );
  }
}

void printRoutes(List<GoRoute> routes, [String parentPath = '']) {
  for (final route in routes) {
    final fullPath = parentPath + route.path;
    print('📍 Ruta: $fullPath');

    // Si hay subrutas (GoRoute en child routes)
    if (route.routes.isNotEmpty) {
      printRoutes(route.routes.whereType<GoRoute>().toList(), fullPath.endsWith('/') ? fullPath : '$fullPath/');
    }
  }
}
