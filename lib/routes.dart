import 'package:flutter/material.dart';
import 'package:movie_search/modules/favourite/views/favs_screen.dart';
import 'package:movie_search/modules/home/home_screen.dart';
import 'package:movie_search/modules/search/search_screen.dart';
import 'package:movie_search/modules/splash/splash_screen.dart';
import 'package:movie_search/ui/screens/onboard.dart';
import 'package:movie_search/ui/screens/settings.dart';
import 'package:movie_search/ui/widgets/windows_bar.dart';

final routes = {
  SplashScreen.route: (ctx) => SplashScreen(),
  HomeScreen.routeName: (ctx) => HomeScreen(),
  SearchScreen.routeName: (ctx) => SearchScreen(),
  FavouriteScreen.routeName: (ctx) => FavouriteScreen(),
  SettingsScreen.routeName: (ctx) => SettingsScreen(),
  OnboardScreen.routeName: (ctx) => OnboardScreen(),
};

class Routes {
  static final defaultTransition = (context, Animation<double> animation,
          Animation<double> secondary, Widget child) =>
      FadeTransition(
        opacity: animation,
        child: child,
      );

  static Route<dynamic> generateRoute(RouteSettings settings) {
    Map<String, dynamic> _routes = routes;
    if (_routes.containsKey(settings.name)) {
      return PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 100),
        transitionsBuilder: defaultTransition,
        pageBuilder: (_, __, ___) => Column(
          children: [
            WindowsBar(),
            Expanded(child: Builder(builder: _routes[settings.name])),
          ],
        ),
        settings: settings,
      );
    }
    return MaterialPageRoute(settings: settings, builder: (_) => Container());
  }

}
