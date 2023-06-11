import 'package:flutter/material.dart';
import 'package:movie_search/modules/discover/discover_results.dart';
import 'package:movie_search/modules/discover/discover_viewmodel.dart';
import 'package:movie_search/modules/discover/search_advanced_filters.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class DiscoverScreen extends StatelessWidget {
  static const String routeName = "/discover";

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    print(myLocale);
    return ViewModelBuilder<DiscoverViewModel>.reactive(
      viewModelBuilder: () => DiscoverViewModel(context.read()),
      onViewModelReady: (model) => model.initializeFilters(),
      builder: (context, model, child) => CustomScaffold(
        bottomBarIndex: 2,
        endDrawer: SearchAdvancedFilterView(),
        body: Column(
          children: [
            AppBar(
              leading: IconButton(icon: Icon(MyIcons.arrow_left), onPressed: () => Navigator.of(context).pop()),
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              title: Text('Explorar'),
              primary: true,
            ),
            Expanded(child: DiscoverResults()),
          ],
        ),
      ),
    );
  }
}
