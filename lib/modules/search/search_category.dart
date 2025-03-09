import 'package:movie_search/providers/util.dart';

class SearchCategory {
  String label, value;

  SearchCategory(this.label, this.value);

  static Set<SearchCategory> getAll() {
    // final categories = TMDB_API_TYPE.values.map((e) => SearchCategory(e.name, e.type)).toSet();
    // categories.add(SearchCategory.all());
    // return categories;
    return {
      SearchCategory(TMDB_API_TYPE.MOVIE.name, TMDB_API_TYPE.MOVIE.type),
      SearchCategory(TMDB_API_TYPE.TV_SHOW.name, TMDB_API_TYPE.TV_SHOW.type),
    };
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SearchCategory && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
