import 'package:movie_search/providers/util.dart';

class SearchCategory {
  String label, value;

  SearchCategory(this.label, this.value);

  SearchCategory.all()
      : label = 'Todos',
        value = null;

  static Set<SearchCategory> getAll() {
    final categories =
        TMDB_API_TYPE.values.map((e) => SearchCategory(e.name, e.type)).toSet();
    categories.add(SearchCategory.all());
    return categories;
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SearchCategory && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
