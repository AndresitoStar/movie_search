import 'package:flutter/material.dart';
import 'package:movie_search/modules/account/viewModel/account_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:movie_search/modules/discover/discover_screen.dart';
import 'package:movie_search/modules/favourite/views/favs_screen.dart';
import 'package:movie_search/modules/home/home_screen.dart';
import 'package:movie_search/modules/search/search_screen.dart';
import 'package:movie_search/ui/frino_icons.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/screens/settings.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyBottomBar extends StatelessWidget {
  final int index;

  const MyBottomBar({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [
      BottomNavigationBarItem(
          icon: Icon(MyIcons.home), label: '', tooltip: 'Inicio'),
      // BottomNavigationBarItem(icon: Icon(MyIcons.search), label: '', tooltip: 'Buscar'),
      BottomNavigationBarItem(
          icon: Icon(MyIcons.discover), label: '', tooltip: 'Explorar'),
      // BottomNavigationBarItem(
      //     icon: Icon(FrinoIcons.f_user_circle),
      //     label: '',
      //     tooltip: 'Favoritos'),
      BottomNavigationBarItem(
        icon: Consumer<AccountViewModel>(builder: (context, provider, child) {
          return provider.isLogged
              ? ClipOval(
                  child: Image.network(
                    provider.photoUrl!,
                    height: kBottomNavigationBarHeight - 25,
                    fit: BoxFit.cover,
                  ),
                )
              : Icon(FrinoIcons.f_user_circle);
        }),
        label: '',
        tooltip: 'Ajustes',
      ),
      BottomNavigationBarItem(
          icon: Icon(MyIcons.settings), label: '', tooltip: 'Ajustes'),
    ];

    return SizedBox(
      width: Device.screenType == ScreenType.desktop ||
              Device.screenType == ScreenType.tablet
          ? Adaptive.pc(20)
          : 100.w,
      child: Stack(
        children: [
          Positioned(
            left: MediaQuery.of(context).size.width / items.length * index,
            bottom: 7,
            child: Container(
              width: MediaQuery.of(context).size.width / items.length,
              height: 4,
              child: Center(
                child: Container(
                  width: 5,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),
          BottomNavigationBar(
            // backgroundColor: Colors.transparent,
            currentIndex: index,
            mouseCursor: MouseCursor.uncontrolled,
            elevation: 2,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            // selectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
            type: BottomNavigationBarType.fixed,
            onTap: (i) {
              switch (i) {
                case 0:
                  if (index != 0)
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName(HomeScreen.routeName));
                  break;
                case 1:
                  if (index != 1) goToDiscover(context);
                  break;
                case 2:
                  if (index != 2) goToFavourites(context);
                  break;
                case 3:
                  if (index != 3) goToSettings(context);
                  break;
                // case 4:
                //   if (index != 4) goToSettings(context);
                //   break;
              }
            },
            items: items,
          ),
        ],
      ),
    );
  }

  Future goToFavourites(BuildContext context) {
    if (index == 0)
      return Navigator.of(context).pushNamed(FavouriteScreen.routeName);
    return Navigator.of(context)
        .pushReplacementNamed(FavouriteScreen.routeName);
  }

  Future goToSearch(BuildContext context) {
    if (index == 0)
      return Navigator.of(context).pushNamed(SearchScreen.routeName);
    return Navigator.of(context).pushReplacementNamed(SearchScreen.routeName);
  }

  Future goToSettings(BuildContext context) {
    if (index == 0)
      return Navigator.of(context).pushNamed(SettingsScreen.routeName);
    return Navigator.of(context).pushReplacementNamed(SettingsScreen.routeName);
  }

  Future goToDiscover(BuildContext context) {
    if (index == 0)
      return Navigator.of(context).pushNamed(DiscoverScreen.routeName);
    return Navigator.of(context).pushReplacementNamed(DiscoverScreen.routeName);
  }
}
