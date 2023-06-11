import 'package:flutter/material.dart';
import 'package:movie_search/modules/discover/discover_screen.dart';
import 'package:movie_search/modules/favourite/views/favs_screen.dart';
import 'package:movie_search/modules/home/home_screen.dart';
import 'package:movie_search/modules/search/search_screen.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/screens/settings.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyBottomBar extends StatelessWidget {
  final int index;

  const MyBottomBar({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:
          Device.screenType == ScreenType.desktop || Device.screenType == ScreenType.tablet ? Adaptive.pc(20) : 100.w,
      child: BottomNavigationBar(
        currentIndex: index,
        mouseCursor: MouseCursor.uncontrolled,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (i) {
          switch (i) {
            case 0:
              if (index != 0) Navigator.of(context).popUntil(ModalRoute.withName(HomeScreen.routeName));
              break;
            case 1:
              if (index != 1) goToSearch(context);
              break;
            case 2:
              if (index != 2) goToDiscover(context);
              break;
            case 3:
              if (index != 3) goToFavourites(context);
              break;
            case 4:
              if (index != 4) goToSettings(context);
              break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(MyIcons.home), label: '', tooltip: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(MyIcons.search), label: '', tooltip: 'Buscar'),
          BottomNavigationBarItem(icon: Icon(MyIcons.discover), label: '', tooltip: 'Explorar'),
          BottomNavigationBarItem(
              icon: Icon(MyIcons.favourite_off),
              label: '',
              activeIcon: Icon(MyIcons.favourite_on),
              tooltip: 'Favoritos'),
          BottomNavigationBarItem(icon: Icon(MyIcons.settings), label: '', tooltip: 'Ajustes'),
        ],
      ),
    );
  }

  Future goToFavourites(BuildContext context) {
    if (index == 0) return Navigator.of(context).pushNamed(FavouriteScreen.routeName);
    return Navigator.of(context).pushReplacementNamed(FavouriteScreen.routeName);
  }

  Future goToSearch(BuildContext context) {
    if (index == 0) return Navigator.of(context).pushNamed(SearchScreen.routeName);
    return Navigator.of(context).pushReplacementNamed(SearchScreen.routeName);
  }

  Future goToSettings(BuildContext context) {
    if (index == 0) return Navigator.of(context).pushNamed(SettingsScreen.routeName);
    return Navigator.of(context).pushReplacementNamed(SettingsScreen.routeName);
  }

  Future goToDiscover(BuildContext context) {
    if (index == 0) return Navigator.of(context).pushNamed(DiscoverScreen.routeName);
    return Navigator.of(context).pushReplacementNamed(DiscoverScreen.routeName);
  }
}
