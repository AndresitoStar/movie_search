import 'package:flutter/material.dart';
import 'package:movie_search/modules/search/search_history.dart';
import 'package:movie_search/modules/search/search_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

import 'search_result_list_item.dart';

class SearchResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.nonReactive(
      viewModelBuilder: () => context.read(),
      builder: (context, model, child) => Container(
        child: model.isBusy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : model.searchResults.isEmpty &&
                    model.queryControl.value != null &&
                    model.queryControl.isNullOrEmpty &&
                    !model.showFilter
                ? SearchHistoryView(onTap: (value) => model.queryControl.value = value)
                : model.searchResults.isEmpty
                    ? Center(child: Text('Sin resultados'))
                    : GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onPanDown: (_) => FocusScope.of(context).requestFocus(FocusNode()),
                        child: Scrollbar(
                          child: GridView.builder(
                              itemCount: model.searchResults.length + 1,
                              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                  // crossAxisCount: getColumns(context),
                                  maxCrossAxisExtent: 600,
                                  mainAxisExtent: 150,
                                  childAspectRatio:
                                      MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 4),
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                              padding: EdgeInsets.zero,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (ctx, i) => i < model.searchResults.length
                                  ? SearchResultListItem(
                                      searchResult: model.searchResults[i],
                                      searchCriteria: model.queryControl.value,
                                    )
                                  : model.hasMore
                                      ? Builder(
                                          builder: (context) {
                                            model.fetchMore(context);
                                            return SizedBox(
                                              height: 10,
                                              child: LinearProgressIndicator(),
                                            );
                                          },
                                        )
                                      : Container()),
                        ),
                      ),
      ),
    );
  }

  int getColumns(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    int columns = 1;

    if (width > 750) {
      columns = 2;
    }
    return columns;
  }
}
