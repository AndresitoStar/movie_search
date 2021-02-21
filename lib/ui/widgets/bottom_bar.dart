import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:movie_search/modules/home/home_screen.dart';
import 'package:movie_search/modules/search/search_screen.dart';
import 'package:movie_search/ui/screens/dashboard.dart';
import 'package:movie_search/ui/screens/favs_screen.dart';
import 'package:movie_search/ui/screens/settings.dart';

class MyBottomBar extends StatelessWidget {
  final int index;

  const MyBottomBar({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      showSelectedLabels: false,
      elevation: 10,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).cardColor,
      iconSize: 30,
      onTap: (i) {
        switch (i) {
          case 0:
            if (index != 0)
              Navigator.of(context)
                  .popUntil(ModalRoute.withName(HomeScreen.routeName));
            break;
          case 1:
            if (index != 1) goToSearch(context);
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
        BottomNavigationBarItem(icon: Icon(FrinoIcons.f_home), label: ''),
        BottomNavigationBarItem(icon: Icon(FrinoIcons.f_search), label: ''),
        BottomNavigationBarItem(icon: Icon(FrinoIcons.f_heart), label: ''),
        BottomNavigationBarItem(icon: Icon(FrinoIcons.f_settings), label: ''),
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

  Future goToSearch(BuildContext context) {
    return Navigator.of(context).pushNamed(SearchScreen.routeName);
  }

  Future goToSettings(BuildContext context) {
    return Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 400),
            pageBuilder: (_, __, ___) => SettingsScreen()));
  }
}
