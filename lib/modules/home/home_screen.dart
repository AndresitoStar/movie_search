import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/main.dart';
import 'package:movie_search/modules/home/home_search_bar.dart';
import 'package:movie_search/modules/trending/trending_horizontal_list.dart';
import 'package:movie_search/modules/trending/trending_viewmodel.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';
import 'package:stacked/stacked.dart';

import 'home_screen_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    final applyLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape &&
            Platform.isAndroid;

    return ViewModelBuilder<HomeScreenViewModel>.reactive(
      viewModelBuilder: () => HomeScreenViewModel(),
      builder: (context, model, _) {
        final child = Column(children: [
          HomeSearchBar(),
          if (!applyLandscape)
            Expanded(
                child: TrendingHorizontalList(content: TrendingContent.MOVIE)),
          if (applyLandscape)
            Container(
              height: 300,
              child: TrendingHorizontalList(content: TrendingContent.MOVIE),
            ),
          Divider(),
          SizedBox(height: 10),
          if (!applyLandscape)
            Expanded(
              child: TrendingHorizontalList(content: TrendingContent.TV),
            ),
          if (applyLandscape)
            Container(
              height: 300,
              child: TrendingHorizontalList(content: TrendingContent.TV),
            ),
          SizedBox(height: 10),
        ]);
        return CustomScaffold(
          bottomBarIndex: 0,
          body: applyLandscape ? SingleChildScrollView(child: child) : child,
        );
      },
    );
  }
}
