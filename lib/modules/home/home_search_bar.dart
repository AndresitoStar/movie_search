import 'package:flutter/material.dart';
import 'package:movie_search/modules/search/search_screen.dart';
import 'package:movie_search/ui/icons.dart';

class HomeSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      color: Theme.of(context).cardColor.withOpacity(0.28),
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
                hintStyle: TextStyle(fontSize: 20),
                contentPadding: EdgeInsets.zero,
              ),
              onTap: () => _onPressed(context),
            ),
          )
        ],
      ),
    );
  }

  _onPressed(BuildContext context) {
    Navigator.of(context).pushNamed(SearchScreen.routeName);
  }
}
