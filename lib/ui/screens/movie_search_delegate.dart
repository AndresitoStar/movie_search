import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:movie_search/components/search/search_category.dart';
import 'package:provider/provider.dart';

import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/rest/resolver.dart';
import 'package:movie_search/ui/widgets/audiovisual_list_item.dart';

class Searcher with ChangeNotifier {
  Set<SearchCategory> _categories;

  Set<SearchCategory> get categories => {..._categories}.toSet();

  SearchCategory actualCategory;

  Searcher() {
    this.actualCategory = SearchCategory('Todos', null);
    this._categories =
        TMDB_API_TYPE.values.map((e) => SearchCategory(e.name, e.type)).toSet();
    this._categories.add(actualCategory);
  }

  selecCategory(SearchCategory category) {
    this.actualCategory = category;
    notifyListeners();
  }

  final RestResolver _resolver = RestResolver.getInstance();

  List<AudiovisualProvider> _movies = [];

  List<AudiovisualProvider> get movies => [..._movies];

  int _total = -1;
  int _page = 1;
  int _totalPage = -1;

  bool get hasMore => _movies.length < _total && _page < _totalPage;

  String _query;

  search(String query) async {
    try {
      _page = 1;
      if (query == null || query.isEmpty) {
        _total = -1;
        _movies = [];
        _query = '';
      } else {
        final response = await _resolver.search(query,
            page: _page, type: actualCategory.value);
        if (response != null) _movies = response.result;
        _total = response.totalResult;
        _totalPage = response.totalPageResult;
        _query = query;
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  fetchMore(BuildContext context) async {
    _page++;
    var result =
        await _resolver.search(_query, page: _page, type: actualCategory.value);
    if (result != null) {
      _movies.addAll(result.result);
      _totalPage = result.totalPageResult;
    }
    notifyListeners();
  }
}

class MovieSearchDelegate extends SearchDelegate {
  Searcher _searcher = Searcher();
  final _debounce = Debounce(milliseconds: 300);

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
      PopupMenuButton<SearchCategory>(
        icon: Icon(Icons.filter_alt,
            color: _searcher.actualCategory.value != null
                ? Theme.of(context).accentColor
                : Theme.of(context).iconTheme.color),
        initialValue: _searcher.actualCategory,
        onSelected: (category) => _searcher.selecCategory(category),
        offset: Offset(0, 100),
        itemBuilder: (context) => _searcher.categories
            .map((e) => PopupMenuItem<SearchCategory>(
                  child: Text(e.label),
                  value: e,
                ))
            .toList(),
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
    // return buildResults(context);
    return Container();
  }
}
