import 'package:movie_search/providers/audiovisuales_provider.dart';
import 'package:movie_search/providers/games_provider.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/widgets/audiovisual_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/audiovisual_list.dart';
import '../widgets/games_list.dart';


class FavouriteScren extends StatefulWidget {
  static const routeNameFilms = '/film_fav';
  static const routeNameSeries = '/series_fav';
  static const routeNameGames = '/game_fav';
  final FAVOURITE_THINGS param;

  FavouriteScren({Key key, @required this.param}) : super(key: key);

  @override
  _FavouriteScrenState createState() => _FavouriteScrenState();
}

class _FavouriteScrenState extends State<FavouriteScren>
    with WidgetsBindingObserver {
  final titles = {
    FAVOURITE_THINGS.FILMS: 'Películas',
    FAVOURITE_THINGS.GAMES: 'Juegos',
    FAVOURITE_THINGS.SERIES: 'Series',
  };

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    switch (widget.param) {
      case FAVOURITE_THINGS.FILMS:
        final provider =
            Provider.of<AudiovisualListProvider>(context, listen: false);
        provider.loadFavorites(context, type: FAVOURITE_THINGS.FILMS);
        body = Consumer<AudiovisualListProvider>(
          builder: (_, provider, child) => AudiovisualGrid(
            isShowingFavs: true,
          ),
        );
        break;
      case FAVOURITE_THINGS.SERIES:
        final provider =
            Provider.of<AudiovisualListProvider>(context, listen: false);
        provider.loadFavorites(context, type: FAVOURITE_THINGS.SERIES);
        body = Consumer<AudiovisualListProvider>(
          builder: (_, provider, child) => AudiovisualGrid(
            isShowingFavs: true,
          ),
        );
        break;
      case FAVOURITE_THINGS.GAMES:
        final provider = Provider.of<GameListProvider>(context, listen: false);
        provider.loadFavorites(context);
        body = Consumer<GameListProvider>(
          builder: (_, provider, child) => GameList(
            isShowingFavs: true,
          ),
        );
        break;
      default:
        body = Container();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[widget.param],
        ),
        backgroundColor: Colors.white,
        elevation: 5,
//        backgroundColor: HexColor('#252525'),
      ),
      body: body,
    );
  }
}
