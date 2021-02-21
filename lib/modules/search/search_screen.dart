import 'package:flutter/material.dart';
import 'package:movie_search/modules/search/search_bar.dart';
import 'package:movie_search/modules/search/search_results.dart';
import 'package:movie_search/modules/search/search_service.dart';
import 'package:movie_search/modules/search/search_viewmodel.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';
import 'package:stacked/stacked.dart';

class SearchScreen extends StatelessWidget {
  static String routeName = "/search";

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      viewModelBuilder: () => SearchViewModel(SearchService()),
      builder: (context, model, child) => CustomScaffold(
        bottomBarIndex: 1,
        body: Container(
          padding: MediaQuery.of(context)
              .padding
              .copyWith(left: 0, right: 0, bottom: 0),
          child: Column(
            children: [
              SearchBar(),
              Expanded(child: SearchResults()),
            ],
          ),
        ),
      ),
    );
  }
}
