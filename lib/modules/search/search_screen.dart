import 'package:flutter/material.dart';
import 'package:movie_search/modules/search/search_bar.dart';
import 'package:movie_search/modules/search/search_results.dart';
import 'package:movie_search/modules/search/search_service.dart';
import 'package:movie_search/modules/search/search_viewmodel.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';
import 'package:stacked/stacked.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = "/search";

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      viewModelBuilder: () => SearchViewModel(SearchService()),
      builder: (context, model, child) => CustomScaffold(
        bottomBarIndex: 1,
        body: Column(
          children: [
            AppBar(
              leading: IconButton(icon: Icon(MyIcons.arrow_left), onPressed: () => Navigator.of(context).pop()),
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              title: Text('Búsqueda'),
              primary: true,
            ),
            SearchBar(),
            SizedBox(height: 10),
            Expanded(child: SearchResults()),
          ],
        ),
      ),
    );
  }
}
