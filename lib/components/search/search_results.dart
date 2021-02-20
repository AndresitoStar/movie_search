import 'package:flutter/material.dart';
import 'package:movie_search/components/search/search_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'search_result_list_item.dart';

class SearchResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.nonReactive(
      viewModelBuilder: () => context.read(),
      builder: (context, searcher, child) => Scrollbar(
        child: searcher.isBusy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : searcher.movies == null
                ? Container()
                : searcher.movies.isEmpty
                    ? Center(child: Text('Sin resultados'))
                    : ListView.builder(
                        itemCount: searcher.movies.length + 1,
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (ctx, i) => i < searcher.movies.length
                            ? AudiovisualListItem(
                                audiovisual: searcher.movies[i])
                            : searcher.hasMore
                                ? Builder(
                                    builder: (context) {
                                      searcher.fetchMore(context);
                                      return LinearProgressIndicator();
                                    },
                                  )
                                : Container()),
      ),
    );
  }
}
