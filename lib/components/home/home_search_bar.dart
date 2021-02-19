import 'package:flutter/material.dart';
import 'package:movie_search/components/search/search_screen.dart';
import 'package:movie_search/ui/icons.dart';

class HomeSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            IconButton(
              onPressed: () => _onPressed(context),
              icon: Icon(MyIcons.search),
              iconSize: 20,
            ),
            Expanded(
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Buscar...',
                  contentPadding: const EdgeInsets.only(bottom: 8),
                ),
                onTap: () => _onPressed(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  _onPressed(BuildContext context) {
    Navigator.of(context).pushNamed(SearchScreen.routeName);
  }
}
