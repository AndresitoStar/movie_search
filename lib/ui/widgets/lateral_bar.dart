import 'package:flutter/material.dart';
import 'package:movie_search/modules/favourite/views/favs_screen.dart';
import 'package:movie_search/modules/home/home_screen.dart';
import 'package:movie_search/modules/search/search_screen.dart';
import 'package:movie_search/modules/themes/theme_viewmodel.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/screens/settings.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';

class MyLateralBar extends StatelessWidget {
  final int index;

  const MyLateralBar({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ViewModelBuilder<ThemeViewModel>.reactive(
      viewModelBuilder: () => context.read(),
      disposeViewModel: false,
      builder: (context, model, _) => AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: model.drawerOpened ? 160 : 50,
        color: theme.primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(MyIcons.drawerHamburger),
                  onPressed: () => model.toggleOpenDrawer(),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: index == 0
                              ? Theme.of(context).primaryColorDark
                              :  Colors.transparent,
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(MyIcons.home),
                                tooltip: 'Inicio',
                                color: Theme.of(context).primaryColorLight,
                                onPressed: () => _onTap(context, 0),
                              ),
                              if (model.drawerOpened) SizedBox(width: 5),
                              if (model.drawerOpened) drawerText(context, 'Inicio', 0)
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          color: index == 1
                              ? Theme.of(context).primaryColorDark
                              : Colors.transparent,
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(MyIcons.search),
                                tooltip: 'Buscar',
                                color: Theme.of(context).primaryColorLight,
                                onPressed: () => _onTap(context, 1),
                              ),
                              if (model.drawerOpened) SizedBox(width: 5),
                              if (model.drawerOpened) drawerText(context, 'Buscar', 1)
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          color: index == 2
                              ? Theme.of(context).primaryColorDark
                              :  Colors.transparent,
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(MyIcons.favourite_off),
                                onPressed: () => _onTap(context, 2),
                                color: Theme.of(context).primaryColorLight,
                                tooltip: 'Favoritos',
                              ),
                              if (model.drawerOpened) SizedBox(width: 5),
                              if (model.drawerOpened)
                                drawerText(context, 'Favoritos', 2)
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          color: index == 3
                              ? Theme.of(context).primaryColorDark
                              :  Colors.transparent,
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(MyIcons.settings),
                                tooltip: 'Ajustes',
                                color: Theme.of(context).primaryColorLight,
                                onPressed: () => _onTap(context, 3),
                              ),
                              if (model.drawerOpened) SizedBox(width: 5),
                              if (model.drawerOpened) drawerText(context, 'Ajustes', 3)
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
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

  Widget drawerText(BuildContext context, String text, int index) =>
      AnimatedOpacity(
        duration: Duration(seconds: 1),
        opacity: 1,
        child: InkWell(
          onTap: () => _onTap(context, index),
          child: Text(
            text.toUpperCase(),
            style: Theme.of(context).textTheme.headline6.copyWith(
                color: Theme.of(context).primaryColorLight),
          ),
        ),
      );
}