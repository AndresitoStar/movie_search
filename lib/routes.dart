import 'package:flutter/material.dart';
import 'package:movie_search/components/splash/splash_screen.dart';
import 'package:movie_search/ui/screens/config_splash.dart';
import 'package:movie_search/ui/screens/dashboard.dart';
import 'package:movie_search/ui/screens/onboard.dart';
import 'package:provider/provider.dart';

class Routes {
  static final routes = {
    SplashScreen.route: (ctx) => SplashScreen(),
    Dashboard.routeName: (ctx) => Dashboard(),
    ConfigSplashScreen.route: (ctx) =>
        ChangeNotifierProvider.value(value: ConfigSplashViewModel(), child: ConfigSplashScreen()),
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
