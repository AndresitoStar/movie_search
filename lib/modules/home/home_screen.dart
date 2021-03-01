import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            HomeSearchBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  TrendingHorizontalList(content: TrendingContent.MOVIE),
                  TrendingHorizontalList(content: TrendingContent.TV),
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
