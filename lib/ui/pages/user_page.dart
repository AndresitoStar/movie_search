import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

import '../../providers/audiovisuales_provider.dart';
import '../../providers/games_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/favs_screen.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final avProvider =
        Provider.of<AudiovisualListProvider>(context, listen: false);
    avProvider.calculateCountFavorites(context);
//    final gameProvider = Provider.of<GameListProvider>(context, listen: false);
//    gameProvider.calculateCountFavorites(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: Column(
        children: <Widget>[
          Expanded(child: boxMovie(context)),
          Divider(
            color: Colors.white70,
            height: 1,
          ),
          Expanded(child: boxSeries(context))
        ],
      ),
    );
  }

  Widget boxMovie(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(FavouriteScren.routeNameFilms)
          .then((_) {
        onBackFromFavsScreen(context);
      }),
      child: Consumer<AudiovisualListProvider>(
        builder: (__, provider, _) => Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: provider.moviesFavsCount == 0
                ? AssetImage('assets/images/movies.webp')
                : CachedNetworkImageProvider(provider.favsMovieImage),
            colorFilter: ColorFilter.mode(
                Colors.black.withAlpha(192).withOpacity(0.8),
                BlendMode.srcOver),
            fit: BoxFit.cover,
          )),
          child: Center(
            child: ListTile(
              title: Text(
                'PELICULAS',
                textAlign: TextAlign.end,
                style: Theme.of(context)
                    .textTheme
                    .display1
                    .copyWith(color: Colors.white70),
              ),
              subtitle: Text(
                provider.moviesFavsCount.toString(),
                textAlign: TextAlign.end,
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(color: Colors.white70),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget boxSeries(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(FavouriteScren.routeNameSeries)
          .then((_) {
        onBackFromFavsScreen(context);
      }),
      child: Consumer<AudiovisualListProvider>(
        builder: (__, provider, _) => Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: provider.seriesFavsCount == 0
                ? AssetImage('assets/images/series.webp')
                : CachedNetworkImageProvider(provider.favsSeriesImage),
            colorFilter: ColorFilter.mode(
                Colors.black.withAlpha(192).withOpacity(0.8),
                BlendMode.srcOver),
            fit: BoxFit.cover,
          )),
          child: Center(
            child: ListTile(
              title: Text(
                'SERIES',
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .display1
                    .copyWith(color: Colors.white70),
              ),
              subtitle: Text(
                provider.seriesFavsCount.toString(),
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(color: Colors.white70),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onBackFromFavsScreen(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
