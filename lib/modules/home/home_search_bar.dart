import 'package:flutter/material.dart';
import 'package:movie_search/modules/search/search_screen.dart';
import 'package:movie_search/ui/icons.dart';

class HomeSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'searchBar',
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 1,
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          readOnly: true,
          autofocus: true,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            prefixIcon: Icon(MyIcons.search, size: 16),
            hintText: 'Buscar una película, serie, persona...',
          ),
          onTap: () => _onPressed(context),
        ),
      ),
    );
  }

  _onPressed(BuildContext context) => Navigator.of(context).pushNamed(SearchScreen.routeName);
}
