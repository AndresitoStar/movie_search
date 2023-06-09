import 'package:flutter/material.dart';
import 'package:movie_search/modules/search/search_bar.dart' as sb;
import 'package:movie_search/modules/search/search_results.dart';
import 'package:movie_search/modules/search/search_service.dart';
import 'package:movie_search/modules/search/search_viewmodel.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = "/search";

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      viewModelBuilder: () => SearchViewModel(SearchService(), context.read()),
      builder: (context, model, child) => CustomScaffold(
        bottomBarIndex: 1,
        body: Column(
          children: [
            AppBar(
              leading: IconButton(icon: Icon(MyIcons.arrow_left), onPressed: () => Navigator.of(context).pop()),
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              title: Text(model.showFilter ? 'Búsqueda Avanzada' : 'Búsqueda'),
              primary: true,
            ),
            sb.SearchBar(),
            // SizedBox(height: 10),
            Expanded(child: SearchResults()),
          ],
        ),
      ),
    );
  }
}
