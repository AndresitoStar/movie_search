import 'package:flutter/material.dart';
import 'package:movie_search/modules/favourite/views/favs_screen.dart';
import 'package:movie_search/modules/home/home_screen.dart';
import 'package:movie_search/modules/search/search_screen.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/screens/settings.dart';

class MyLateralBar extends StatelessWidget {
  final int index;

  const MyLateralBar({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 32,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                IconButton(
                  icon: Icon(MyIcons.home),
                  tooltip: 'Inicio',
                  color: index == 0 ? theme.accentColor : Colors.white,
                  onPressed: () => _onTap(context, 0),
                ),
                IconButton(
                  icon: Icon(MyIcons.search),
                  tooltip: 'Buscar',
                  color: index == 1 ? theme.accentColor : Colors.white,
                  onPressed: () => _onTap(context, 1),
                ),
                IconButton(
                  icon: Icon(MyIcons.favourite_off),
                  onPressed: () => _onTap(context, 2),
                  color: index == 2 ? theme.accentColor : Colors.white,
                  tooltip: 'Favoritos',
                ),
                IconButton(
                  icon: Icon(MyIcons.settings),
                  tooltip: 'Ajustes',
                  color: index == 3 ? theme.accentColor : Colors.white,
                  onPressed: () => _onTap(context, 3),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onTap(BuildContext context, int i) {
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
  }

  Future goToFavourites(BuildContext context) {
    return Navigator.of(context).pushNamed(FavouriteScreen.routeName);
  }

  Future goToSearch(BuildContext context) {
    return Navigator.of(context).pushNamed(SearchScreen.routeName);
  }

  Future goToSettings(BuildContext context) {
    return Navigator.of(context).pushNamed(SettingsScreen.routeName);
  }
}
