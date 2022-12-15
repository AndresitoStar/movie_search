import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'discover_viewmodel.dart';

class DiscoverResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DiscoverViewModel>.nonReactive(
      viewModelBuilder: () => context.read(),
      builder: (context, model, child) => Container(
        child: model.isBusy
            ? Center(child: CircularProgressIndicator())
            : model.searchResults.isEmpty
                ? Center(child: Text('Sin resultados'))
                : GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onPanDown: (_) => FocusScope.of(context).requestFocus(FocusNode()),
                    child: Scrollbar(
                      child: MasonryGridView.count(
                        padding: const EdgeInsets.all(10.0),
                        itemCount: model.searchResults.length + 2,
                        crossAxisCount: getColumns(context),
                        itemBuilder: (ctx, i) => AspectRatio(
                          aspectRatio: 0.667,
                          child: i < model.searchResults.length
                              ? ItemGridView(
                                  item: model.searchResults[i],
                                  showData: false,
                                  heroTagPrefix: '',
                                )
                              : model.hasMore
                                  ? Builder(
                                      builder: (context) {
                                        if (i == model.searchResults.length) model.fetchMore();
                                        return GridItemPlaceholder();
                                      },
                                    )
                                  : Container(),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }

  int getColumns(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return (width ~/ 150).clamp(1, 8);
  }
}
