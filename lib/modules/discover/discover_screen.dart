import 'package:flutter/material.dart';
import 'package:movie_search/modules/discover/discover_results.dart';
import 'package:movie_search/modules/discover/discover_viewmodel.dart';
import 'package:movie_search/modules/discover/search_advanced_filters.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stacked/stacked.dart';

class DiscoverScreen extends StatelessWidget {
  static const String routeName = "/discover";

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DiscoverViewModel>.reactive(
      viewModelBuilder: () => DiscoverViewModel(context.read()),
      onViewModelReady: (model) => model.initializeFilters(),
      builder: (context, model, child) => CustomScaffold(
        bottomBarIndex: 2,
        endDrawer: SearchAdvancedFilterView(),
        body: DiscoverResults(),
        forceAppbar: true,
      ),
    );
  }
}
