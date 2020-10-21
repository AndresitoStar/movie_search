import 'package:movie_search/ui/pages/dashboard.dart';

import 'data/moor_database.dart';
import 'providers/util.dart';
import 'ui/screens/audiovisual_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/audiovisuales_provider.dart';
import 'providers/games_provider.dart';
import 'ui/screens/home_screen.dart';

import 'ui/screens/favs_screen.dart';
import 'ui/screens/onboard.dart';

//LoginService service = new LoginService();

//void main() => runApp(Home());
void main() => runApp(HomeImbd(showOnboard: false,));

class HomeImbd extends StatelessWidget {
  final bool showOnboard;

  const HomeImbd({Key key, @required this.showOnboard}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AudiovisualListProvider()),
        ChangeNotifierProvider.value(value: GameListProvider()),
        Provider<MyDatabase>(
          create: (context) => MyDatabase(),
          dispose: (context, db) => db.close(),
        )
      ],
      child: MaterialApp(
        title: 'Melon App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.amber,
            accentColor: Colors.amberAccent,
            fontFamily: 'Dosis'),
        themeMode: ThemeMode.dark,
        home: showOnboard ? OnboardScreen() : Dashboard(),
        routes: {
          AudiovisualDetail.routeName: (ctx) => AudiovisualDetail(),
          FavouriteScren.routeNameFilms: (ctx) => FavouriteScren(
                param: FAVOURITE_THINGS.FILMS,
              ),
          FavouriteScren.routeNameGames: (ctx) => FavouriteScren(
                param: FAVOURITE_THINGS.GAMES,
              ),
          FavouriteScren.routeNameSeries: (ctx) => FavouriteScren(
                param: FAVOURITE_THINGS.SERIES,
              ),
        },
      ),
    );
  }
}
