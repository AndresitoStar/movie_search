import 'package:flutter/material.dart';
import 'package:movie_search/components/home/home_screen.dart';
import 'package:movie_search/components/search/search_screen.dart';
import 'package:movie_search/components/splash/splash_screen.dart';
import 'package:movie_search/ui/screens/dashboard.dart';
import 'package:movie_search/ui/screens/onboard.dart';
import 'package:provider/provider.dart';

class Routes {
  static final routes = {
    SplashScreen.route: (ctx) => SplashScreen(),
    HomeScreen.routeName: (ctx) => HomeScreen(),
    Dashboard.routeName: (ctx) => Dashboard(),
    SearchScreen.routeName: (ctx) => SearchScreen(),
    OnboardScreen.routeName: (ctx) => OnboardScreen(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    Map<String, dynamic> _routes = routes;
    if (_routes.containsKey(settings.name)) {
      return PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 400),
        // transitionsBuilder: (_, a, __, c) =>
        //     FadeTransition(opacity: a, child: c),
        pageBuilder: (_, __, ___) => Builder(builder: _routes[settings.name]),
        settings: settings,
      );
    }
    return MaterialPageRoute(
        settings: settings, builder: (_) => Container());
  }
}
