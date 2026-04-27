import 'package:flutter/material.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:movie_search/common/ui/frino_icons.dart';
import 'package:movie_search/common/ui/icons.dart';
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
    _Item(icon: Icon(FrinoIcons.f_user_circle), label: 'Mis Favoritos', tooltip: 'Mis Favoritos'),
    _Item(icon: Icon(MyIcons.settings), label: 'Ajustes', tooltip: 'Ajustes'),
  ];

  onSelectIndex({required int i, required BuildContext context}) {
    switch (i) {
      case 0:
        if (index != 0) context.goHome();
        break;
      case 1:
        if (index != 1) context.goDiscover();
        break;
      case 2:
        if (index != 2) context.goFavourites();
        break;
      case 3:
        if (index != 3) context.goSettings();
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
    return Hero(
      tag: 'bottom_bar',
      transitionOnUserGestures: true,
      flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
        return toHeroContext.widget;
      },
      child: SizedBox(
        width: isLandscape ? Adaptive.pc(20) : 100.w,
        child: Stack(
          children: [
            Positioned(
              left: MediaQuery.of(context).size.width / items.length * index,
              bottom: 7,
              child: SizedBox(
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
              items: items.map((e) => BottomNavigationBarItem(icon: e.icon, label: '', tooltip: e.tooltip)).toList(),
            ),
          ],
        ),
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
        IconButton(onPressed: context.goSearch, icon: Icon(MyIcons.search)),
        for (var i = 0; i < items.length; ++i)
          TextButton(
            child: Text(
              items[i].label,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: i == index ? FontWeight.bold : FontWeight.normal,
                color: i == index ? context.colors.primary : context.textTheme.titleMedium?.color,
              ),
            ),
            onPressed: () => onSelectIndex(i: i, context: context),
          ),
      ],
    );
  }
}
