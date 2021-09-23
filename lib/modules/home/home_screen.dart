import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/home/home_popular.dart';
import 'package:movie_search/modules/home/home_search_bar.dart';
import 'package:movie_search/modules/trending/trending_horizontal_list.dart';
import 'package:movie_search/modules/trending/trending_viewmodel.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'home_screen_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeScreenViewModel>.reactive(
      viewModelBuilder: () => HomeScreenViewModel(context.read()),
      onModelReady: (model) => model.synchronize(),
      builder: (context, model, _) {
        final child = Column(children: [
          HomePopularWidget(),
          Container(
            height: 20,
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.13),
          ),
          Container(
            height: 350,
            child: TrendingHorizontalList(content: TrendingContent.MOVIE),
          ),
          Divider(),
          SizedBox(height: 10),
          Container(
            height: 350,
            child: TrendingHorizontalList(content: TrendingContent.TV),
          ),
          SizedBox(height: 10),
        ]);
        return CustomScaffold(
          bottomBarIndex: 0,
          body: Column(
            children: [
              HomeSearchBar(),
              Expanded(child: SingleChildScrollView(child: child)),
            ],
          ),
        );
      },
    );
  }
}
