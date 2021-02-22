import 'package:flutter/material.dart';
import 'package:movie_search/modules/search/search_history.dart';
import 'package:movie_search/modules/search/search_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'search_result_list_item.dart';

class SearchResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.nonReactive(
      viewModelBuilder: () => context.read(),
      builder: (context, model, child) => model.isBusy
          ? Center(
              child: CircularProgressIndicator(),
            )
          : model.movies == null
              ? SearchHistoryView(
                  onTap: (value) => model.queryControl.value = value)
              : model.movies.isEmpty
                  ? Center(child: Text('Sin resultados'))
                  : Scrollbar(
                      child: ListView.builder(
                          itemCount: model.movies.length + 1,
                          padding: EdgeInsets.zero,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (ctx, i) => i < model.movies.length
                              ? SearchResultListItem(
                                  audiovisual: model.movies[i],
                                  searchCriteria: model.queryControl.value,
                                )
                              : model.hasMore
                                  ? Builder(
                                      builder: (context) {
                                        model.fetchMore(context);
                                        return LinearProgressIndicator();
                                      },
                                    )
                                  : Container()),
                    ),
    );
  }
}
