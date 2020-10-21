import 'dart:collection';

import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/repository/repository_movie.dart';
import 'package:movie_search/rest/resolver.dart';
import 'package:movie_search/ui/util_ui.dart';
import 'package:movie_search/ui/widgets/audiovisual_list_item.dart';
import 'package:movie_search/ui/widgets/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Searcher with ChangeNotifier {
  Set<String> categories;

  Searcher({categories}) {
    this.categories = categories ?? HashSet();
  }

  final RestResolver _resolver = RestResolver();

  List<AudiovisualProvider> _movies = [];
  int _total = -1;
  int _page = 1;

  bool get hasMore => _movies.length < _total;

  search(String query) async {
    try {
      _page = 1;
      final response = await _resolver.searchMovie(query, page: _page);
      if (response != null) _movies = response.result;
      _total = response.totalResult;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  fetchMore(BuildContext context, String query) async {
    _page++;
    var result = await _resolver.searchMovie(query, page: _page);
    if (result != null) _movies.addAll(result.result);
    notifyListeners();
  }
}

class MovieSearchDelegate extends SearchDelegate {
  Searcher _searcher = Searcher();

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      textTheme: theme.textTheme.copyWith(
        title: TextStyle(color: HexColor('#252525')),
      ),
    );
  }

  @override
  String get searchFieldLabel => "Buscar película o serie..";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Debe buscar con más de 2 letras",
            ),
          )
        ],
      );
    }

    Future.delayed(Duration(milliseconds: 100),
        () => UtilView.showLongTaskDialogDynamic(context, () => _searcher.search(query)));
    return ChangeNotifierProvider.value(
        value: _searcher,
        child: Consumer<Searcher>(
          builder: (context, searcher, child) => Builder(
            builder: (context) => searcher._movies == null || searcher._movies.length == 0
                ? Container(
                    child: Center(
                      child: Text('Sin resultados'),
                    ),
                  )
                : ListView.builder(
                    itemCount: searcher._movies.length + 1,
                    itemBuilder: (ctx, i) => i < searcher._movies.length
                        ? ChangeNotifierProvider.value(
                            value: searcher._movies[i], child: AudiovisualListItem())
                        : searcher.hasMore
                            ? Builder(
                                builder: (context) {
                                  searcher.fetchMore(context, query);
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
    return Container();
  }
}

