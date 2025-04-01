import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_search/modules/discover/discover_results.dart';
import 'package:movie_search/modules/discover/discover_viewmodel.dart';
import 'package:movie_search/modules/discover/search_advanced_filters.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stacked/stacked.dart';

class DiscoverScreen extends StatelessWidget {
  static const String routeName = "/discover";

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return ViewModelBuilder<DiscoverViewModel>.reactive(
      viewModelBuilder: () => DiscoverViewModel(),
      onViewModelReady: (model) => model.initializeFilters(),
      builder: (context, model, child) => CustomScaffold(
        childKey: scaffoldKey,
        bottomBarIndex: 1,
        endDrawer: SearchAdvancedFilterView(),
        body: DiscoverResults(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
          child: Icon(FontAwesomeIcons.filter),
        ),
        actions: [Container()],
        forceAppbar: Device.screenType == ScreenType.mobile /*true*/,
        title: "Explorar",
      ),
    );
  }
}
