import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search/modules/account/viewModel/account_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:movie_search/modules/discover/discover_screen.dart';
import 'package:movie_search/modules/favourite/views/favs_screen.dart';
import 'package:movie_search/modules/home/home_screen.dart';
import 'package:movie_search/ui/frino_icons.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/screens/settings.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class _Item {
  final Widget icon;
  final String label;
  final String tooltip;

  _Item({required this.icon, required this.label, required this.tooltip});
}

mixin _BottomBar {
  late final int index;

  final items = [
    _Item(icon: Icon(MyIcons.home), label: 'Inicio', tooltip: 'Inicio'),
    _Item(icon: Icon(MyIcons.discover), label: 'Explorar', tooltip: 'Explorar'),
    _Item(
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
      label: 'Mis Favoritos',
      tooltip: 'Mis Favoritos',
    ),
    _Item(icon: Icon(MyIcons.settings), label: 'Ajustes', tooltip: 'Ajustes'),
  ];

  onSelectIndex({required int i, required BuildContext context}) {
    switch (i) {
      case 0:
        if (index != 0) context.go(HomeScreen.routeName);
        break;
      case 1:
        if (index != 1) context.go('/${DiscoverScreen.routeName}');
        break;
      case 2:
        if (index != 2) context.go('/${FavouriteScreen.routeName}');
        break;
      case 3:
        if (index != 3) context.go('/${SettingsScreen.routeName}');
        break;
    }
  }
}

class MyBottomBar extends StatelessWidget with _BottomBar {
  MyBottomBar({super.key, required int index}) {
    this.index = index;
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = Device.screenType == ScreenType.desktop || Device.screenType == ScreenType.tablet;
    return SizedBox(
      width: isLandscape ? Adaptive.pc(20) : 100.w,
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
            currentIndex: index,
            mouseCursor: MouseCursor.uncontrolled,
            elevation: 2,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
            type: BottomNavigationBarType.fixed,
            onTap: (i) => onSelectIndex(i: i, context: context),
            items: items
                .map(
                  (e) => BottomNavigationBarItem(
                    icon: e.icon,
                    label: '',
                    tooltip: e.tooltip,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class MyNavigationBar extends StatelessWidget with _BottomBar {
  MyNavigationBar({super.key, required int index}) {
    this.index = index;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      // selectedIndex: index,
      // onDestinationSelected: (i) => onSelectIndex(i: i, context: context),
      children: [
        for (var i = 0; i < items.length; ++i)
          TextButton(
            child: Text(
              items[i].label,
              style: TextStyle(
                color: i == index ? Colors.amber : Colors.white,
                fontWeight: i == index ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            onPressed: () => onSelectIndex(i: i, context: context),
          ),
      ],
    );
  }
}
