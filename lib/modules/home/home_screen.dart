import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/home/home_popular.dart';
import 'package:movie_search/modules/home/home_screen_content_indicator.dart';
import 'package:movie_search/modules/home/home_search_bar.dart';
import 'package:movie_search/modules/trending/trending_horizontal_list.dart';
import 'package:movie_search/modules/trending/trending_viewmodel.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
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
        return CustomScaffold(
          bottomBarIndex: 0,
          body: DefaultTabController(
            length: TrendingContent.values.length,
            child: Column(
              children: [
                HomeSearchBar(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: HomeScreenContentIndicator(),
                ),
                ReactiveFormField(
                  formControl: model.typeControl,
                  builder: (field) => Expanded(
                    child: ListView(
                      children: [
                        HomePopularWidget(),
                        Divider(),
                        if (model.genresMap != null &&
                            model.genresMap[field.value] != null &&
                            model.genresMap[field.value].isNotEmpty)
                          ...model.genresMap[field.value].map(
                            (e) => Container(
                              key: UniqueKey(),
                              height: 350,
                              child: TrendingHorizontalList(content: model.typeSelected, genre: e),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
