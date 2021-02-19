class SearchCategory {
  String label, value;

  SearchCategory(this.label, this.value);

  SearchCategory.all() : label = 'Todos', value = null;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SearchCategory && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}