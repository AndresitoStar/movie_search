import 'package:flutter/material.dart';
import 'package:movie_search/modules/favourite/views/favs_screen.dart';
import 'package:movie_search/modules/home/home_screen.dart';
import 'package:movie_search/modules/search/search_screen.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/screens/settings.dart';
import 'package:stacked/stacked.dart';

class MyLateralBar extends StatelessWidget {
  final int index;

  const MyLateralBar({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ViewModelBuilder<LateralBarViewModel>.reactive(
      viewModelBuilder: () => LateralBarViewModel(),
      builder: (context, model, _) => AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: model.opened ? 160 : 50,
        color: Colors.black12,
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
                  onPressed: () => model.toggle(),
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
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(MyIcons.home),
                              tooltip: 'Inicio',
                              color:
                                  index == 0 ? theme.accentColor : Colors.white,
                              onPressed: () => _onTap(context, 0),
                            ),
                            if (model.opened) SizedBox(width: 20),
                            if (model.opened) drawerText(context, 'Inicio', 0)
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(MyIcons.search),
                              tooltip: 'Buscar',
                              color:
                                  index == 1 ? theme.accentColor : Colors.white,
                              onPressed: () => _onTap(context, 1),
                            ),
                            if (model.opened) SizedBox(width: 20),
                            if (model.opened) drawerText(context, 'Buscar', 1)
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(MyIcons.favourite_off),
                              onPressed: () => _onTap(context, 2),
                              color:
                                  index == 2 ? theme.accentColor : Colors.white,
                              tooltip: 'Favoritos',
                            ),
                            if (model.opened) SizedBox(width: 20),
                            if (model.opened)
                              drawerText(context, 'Favoritos', 2)
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(MyIcons.settings),
                              tooltip: 'Ajustes',
                              color:
                                  index == 3 ? theme.accentColor : Colors.white,
                              onPressed: () => _onTap(context, 3),
                            ),
                            if (model.opened) SizedBox(width: 20),
                            if (model.opened) drawerText(context, 'Ajustes', 3)
                          ],
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
                color: this.index == index
                    ? Theme.of(context).accentColor
                    : Colors.white),
          ),
        ),
      );
}

class LateralBarViewModel extends BaseViewModel {
  bool opened = false;

  toggle() {
    opened = !opened;
    notifyListeners();
  }
}
