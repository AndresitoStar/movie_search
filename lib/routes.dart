import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_collection.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_page.dart';
import 'package:movie_search/modules/audiovisual/componets/review_page.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/discover/discover_screen.dart';
import 'package:movie_search/modules/favourite/views/favs_screen.dart';
import 'package:movie_search/modules/home/home_screen.dart';
import 'package:movie_search/modules/search/search_screen.dart';
import 'package:movie_search/modules/splash/splash_screen.dart';
import 'package:movie_search/modules/video/video_screen.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/screens/onboard.dart';
import 'package:movie_search/ui/screens/settings.dart';

final Map<String, Widget> routes = {
  SplashScreen.route: SplashScreen(),
  HomeScreen.routeName: HomeScreen(),
  SearchScreen.routeName: SearchScreen(),
  FavouriteScreen.routeName: FavouriteScreen(),
  SettingsScreen.routeName: SettingsScreen(),
  OnboardScreen.routeName: OnboardScreen(),
  ItemCollectionScreen.route: ItemCollectionScreen(),
  VideoScreen.route: VideoScreen(),
  DiscoverScreen.routeName: DiscoverScreen(),
  ReviewPage.routeName: ReviewPage(),
};

class Routes {
  static const Duration _transitionDuration = Duration(milliseconds: 400);

  static _getTransitions(context, Animation<double> animation,
      Animation<double> secondary, Widget child) {
    // switch (name) {
    //   case SearchScreen.routeName:
    //     // case SettingsScreen.routeName:
    //     return SlideTransition(
    //       position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0)).animate(animation),
    //       child: child,
    //     );
    //     break;
    // }
    return FadeTransition(opacity: animation, child: child);
  }

  static Route<dynamic> defaultRoute(RouteSettings? settings, Widget child) {
    return PageRouteBuilder(
      transitionDuration: _transitionDuration,
      pageBuilder: (_, __, ___) => SafeArea(
        top: false,
        bottom: false,
        child: Builder(builder: (context) => child),
      ),
      settings: settings,
    );
  }

  static Route<dynamic> generateRoute(BuildContext context, RouteSettings settings) {
    Map<String, Widget> _routes = routes;
    if (_routes.containsKey(settings.name)) {
      return PageRouteBuilder(
        transitionDuration: _transitionDuration,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            _getTransitions(context, animation, secondaryAnimation, child),
        pageBuilder: (_, __, ___) => Builder(builder: (context) => Container(child: _routes[settings.name])),
        settings: settings,
      );
    } else if (settings.name?.startsWith(ItemDetailPage.route) ?? false) {
      try {
        final paths = Uri.parse(settings.name!).pathSegments;
        if (paths.length >= 3) {
          final type = paths[1];
          final id = num.parse(paths[2]);
          final BaseSearchResult item = BaseSearchResult.lite(mediaType: type, id: id);
          return defaultRoute(settings, ItemDetailPage(item: item, heroTagPrefix: 'lala'));
        }
      } on Exception {
        return defaultRoute(settings, routes[SplashScreen.route]!);
      }
    }
    return MaterialPageRoute(settings: settings, builder: (_) => Container());
  }
}
