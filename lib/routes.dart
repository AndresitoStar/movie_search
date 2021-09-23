import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_collection.dart';
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
  ItemCollectionScreen.route: (ctx) => ItemCollectionScreen(),
};

class Routes {
  static const Duration _transitionDuration = Duration(milliseconds: 400);

  static _getTransitions(String name, context, Animation<double> animation, Animation<double> secondary, Widget child) {
    switch (name) {
      case SearchScreen.routeName:
      case SettingsScreen.routeName:
        return SlideTransition(
          position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0)).animate(animation),
          child: child,
        );
        break;
    }
    return FadeTransition(opacity: animation, child: child);
  }

  static Route<dynamic> defaultRoute(RouteSettings settings, Widget child) {
    return PageRouteBuilder(
      transitionDuration: _transitionDuration,
      pageBuilder: (_, __, ___) => SafeArea(top: false, bottom: false, child: Builder(builder: (context) => child)),
      settings: settings,
    );
  }

  static Route<dynamic> generateRoute(BuildContext context, RouteSettings settings) {
    Map<String, dynamic> _routes = routes;
    if (_routes.containsKey(settings.name)) {
      return PageRouteBuilder(
        transitionDuration: _transitionDuration,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            _getTransitions(settings.name, context, animation, secondaryAnimation, child),
        pageBuilder: (_, __, ___) => Platform.isAndroid || Platform.isIOS || Platform.isLinux
            ? Builder(builder: _routes[settings.name])
            : Column(
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
