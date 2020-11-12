import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/ui/screens/favs_screen.dart';
import 'package:movie_search/ui/screens/movie_search_delegate.dart';
import 'package:movie_search/ui/screens/settings.dart';

class MyBottomBar extends StatelessWidget {
  final int index;

  const MyBottomBar({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      backgroundColor: Theme.of(context).appBarTheme.color,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      unselectedItemColor: EasyDynamicTheme.of(context).themeMode == ThemeMode.light
          ? Colors.black26
          : Colors.white24,
      selectedItemColor: Colors.orangeAccent,
      type: BottomNavigationBarType.fixed,
      iconSize: 30,
      onTap: (i) {
        switch (i) {
          case 0:
            if (index != 0) Navigator.of(context).pop();
            break;
          case 1:
            if (index != 1) showSearch(context: context, delegate: MovieSearchDelegate());
            break;
          case 2:
            if (index != 2) goToFavourites(context);
            break;
          case 3:
            if (index != 3) goToSettings(context);
            break;
        }
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
      ],
    );
  }

  Future goToFavourites(BuildContext context) {
    return Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 400),
            pageBuilder: (_, __, ___) => FavouriteScreen()));
  }

  Future goToSettings(BuildContext context) {
    return Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 400),
            pageBuilder: (_, __, ___) => SettingsScreen()));
  }
}
