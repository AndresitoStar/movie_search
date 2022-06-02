import 'package:flutter/material.dart';
import 'package:movie_search/modules/favourite/views/favs_screen.dart';
import 'package:movie_search/modules/search/search_screen.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/screens/settings.dart';

class HomeSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final landscape = MediaQuery.of(context).size.aspectRatio > 0.7;

    return AppBar(
      toolbarHeight: kToolbarHeight + 10,
      automaticallyImplyLeading: false,
      primary: true,
      titleSpacing: 0,
      actions: [
        IconButton(onPressed: () => _onPressed(context), icon: Icon(MyIcons.search)),
        IconButton(onPressed: () => _goToFavourites(context), icon: Icon(MyIcons.favourite_home_bar)),
        IconButton(onPressed: () => _goToSettings(context), icon: Icon(MyIcons.settings)),
      ],
      // title: Container(
      //   clipBehavior: Clip.hardEdge,
      //   margin: const EdgeInsets.only(left: 10),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(20),
      //     color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
      //   ),
      //   child: TextField(
      //     readOnly: true,
      //     autofocus: true,
      //     decoration: InputDecoration(
      //       prefix: Container(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Icon(MyIcons.search, size: 20),
      //       ),
      //       hintText: 'Buscar...',
      //       contentPadding: const EdgeInsets.only(bottom: 5, left: 10),
      //     ),
      //     onTap: () => _onPressed(context),
      //   ),
      // ),
    );
  }

  _onPressed(BuildContext context) => Navigator.of(context).pushNamed(SearchScreen.routeName);

  _goToFavourites(BuildContext context) => Navigator.of(context).pushNamed(FavouriteScreen.routeName);

  _goToSettings(BuildContext context) => Navigator.of(context).pushNamed(SettingsScreen.routeName);
}
