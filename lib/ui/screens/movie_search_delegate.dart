import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/rest/resolver.dart';
import 'package:movie_search/ui/widgets/audiovisual_list_item.dart';
import 'package:provider/provider.dart';

class SearchCategory {
  String label, value;
}

class Searcher with ChangeNotifier {
  Set<SearchCategory> categories;

  Searcher({categories}) {
    this.categories = categories ?? HashSet();
  }

  final RestResolver _resolver = RestResolver.getInstance();

  List<AudiovisualProvider> _movies = [];

  List<AudiovisualProvider> get movies => [..._movies];

  int _total = -1;
  int _page = 1;

  bool get hasMore => _movies.length < _total;

  String _query;

  search(String query) async {
    try {
      _page = 1;
      if (query == null || query.isEmpty) {
        _total = -1;
        _movies = [];
        _query = '';
      } else {
        final response = await _resolver.search(query, page: _page);
        if (response != null) _movies = response.result;
        _total = response.totalResult;
        _query = query;
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  fetchMore(BuildContext context) async {
    _page++;
    var result = await _resolver.search(_query, page: _page);
    if (result != null) _movies.addAll(result.result);
    notifyListeners();
  }
}

class MovieSearchDelegate extends SearchDelegate {
  Searcher _searcher = Searcher();
  final _debounce = Debounce(milliseconds: 300);

//  MovieSearchDelegate() : super(searchFieldStyle: theme.inputDecorationTheme.hintStyle);

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      textTheme: theme.textTheme.copyWith(
        title: theme.textTheme.subtitle1,
      ),
    );
  }

  @override
  String get searchFieldLabel => "Buscar película o serie..";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, color: Theme.of(context).iconTheme.color),
        onPressed: () {
          query = '';
        },
      ),
//      MyEasyDynamicThemeBtn()
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(FrinoIcons.f_arrow_left),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    _debounce.run(() => _searcher.search(query));
    return ChangeNotifierProvider.value(
        value: _searcher,
        child: Consumer<Searcher>(
          builder: (context, searcher, child) => Builder(
            builder: (context) =>
                searcher._movies == null || searcher._movies.length == 0
                    ? Container(
                        child: Center(
                          child: Text('Sin resultados'),
                        ),
                      )
                    : ListView.builder(
                        itemCount: searcher._movies.length + 1,
                        itemBuilder: (ctx, i) => i < searcher._movies.length
                            ? ChangeNotifierProvider.value(
                                value: searcher._movies[i],
                                child: AudiovisualListItem())
                            : searcher.hasMore
                                ? Builder(
                                    builder: (context) {
                                      searcher.fetchMore(context);
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: LinearProgressIndicator(),
                                      );
                                    },
                                  )
                                : Container()),
          ),
        ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
