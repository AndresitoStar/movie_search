import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/model/movie.dart';
import 'package:movie_search/modules/audiovisual/model/serie.dart';
import 'package:movie_search/modules/home/home_search_bar.dart';
import 'package:movie_search/modules/trending/trending_horizontal_list.dart';
import 'package:movie_search/modules/trending/trending_viewmodel.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomBarIndex: 0,
      body: Container(
        padding: MediaQuery.of(context)
            .padding
            .copyWith(left: 0, right: 0, bottom: 0),
        child: Column(
          children: [
            HomeSearchBar(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  TrendingHorizontalList<Movie>(content: TrendingContent.MOVIE),
                  TrendingHorizontalList<TvShow>(content: TrendingContent.TV),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
