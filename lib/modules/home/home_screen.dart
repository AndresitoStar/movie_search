import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie_search/modules/home/home_search_bar.dart';
import 'package:movie_search/modules/trending/trending_horizontal_list.dart';
import 'package:movie_search/modules/trending/trending_viewmodel.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';
import 'package:stacked/stacked.dart';

import 'home_screen_content_indicator.dart';
import 'home_screen_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeScreenViewModel>.reactive(
      viewModelBuilder: () => HomeScreenViewModel(),
      builder: (context, model, _) => CustomScaffold(
        bottomBarIndex: 0,
        body: SafeArea(
          child: Column(
            children: [
              HomeSearchBar(),
              Expanded(
                child: TrendingHorizontalList(content: TrendingContent.MOVIE),
              ),
              SizedBox(height: 10),
              Expanded(
                child: TrendingHorizontalList(content: TrendingContent.TV),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
