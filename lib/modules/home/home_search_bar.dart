import 'package:flutter/material.dart';
import 'package:movie_search/modules/search/search_screen.dart';
import 'package:movie_search/ui/icons.dart';

class HomeSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final landscape = MediaQuery.of(context).size.aspectRatio > 0.7;

    return AppBar(
      toolbarHeight: kToolbarHeight + 10,
      automaticallyImplyLeading: false,
      backgroundColor: landscape
          ? Theme.of(context).scaffoldBackgroundColor
          : Theme.of(context).primaryColor,
      titleSpacing: 0,
      title: Container(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          readOnly: true,
          autofocus: true,
          decoration: InputDecoration(
            prefix: Container(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                MyIcons.search,
                size: 20,
                color: Colors.white,
              ),
            ),
            hintText: 'Buscar...',
            hintStyle: const TextStyle(fontSize: 20, color: Colors.white38),
            contentPadding: const EdgeInsets.only(bottom: 5, left: 10),
          ),
          onTap: () => _onPressed(context),
        ),
      ),
    );
  }

  _onPressed(BuildContext context) {
    Navigator.of(context).pushNamed(SearchScreen.routeName);
  }
}
