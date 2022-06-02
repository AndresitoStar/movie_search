import 'package:flutter/material.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';

class MovieHomeScreen extends HomeCategoryScreen {
  static String routeName = "/movieScreen";

  @override
  TMDB_API_TYPE get type => TMDB_API_TYPE.MOVIE;
}

abstract class HomeCategoryScreen extends StatelessWidget {
  TMDB_API_TYPE get type;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomBarIndex: 0,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppBar(title: Text(type.name), titleSpacing: 0),
        ],
      ),
    );
  }
}
