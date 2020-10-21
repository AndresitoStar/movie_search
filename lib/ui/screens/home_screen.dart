import 'package:bmnav/bmnav.dart';
import 'package:movie_search/ui/pages/dashboard.dart';
import 'package:movie_search/ui/pages/trending_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../pages/search_movie_page.dart';
import '../pages/user_page.dart';
import '../widgets/hex_color.dart';

class ImbdScreen extends StatefulWidget {
  @override
  _ImbdScreenState createState() => _ImbdScreenState();
}

class _ImbdScreenState extends State<ImbdScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final _pages = <Widget>[
    TrendingPage(),
//    Dashboard(),
    SearchScreen(),
//    SearchGameScreen(),
    UserScreen(),
  ];
  TabController _controller;

  @override
  void initState() {
    _controller =
        TabController(length: _pages.length, vsync: this, initialIndex: 1);
    _controller
        .addListener(() => FocusScope.of(context).requestFocus(FocusNode()));
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    final _onTap = (i) {
      _controller.animateTo(i);
    };
    final bmnav = BottomNav(
      items: [
        BottomNavItem(FontAwesomeIcons.solidStar, label: "Trending"),
        BottomNavItem(FontAwesomeIcons.home, label: "Media"),
//        BottomNavItem(FontAwesomeIcons.gamepad, label: "Juegos"),
        BottomNavItem(FontAwesomeIcons.solidHeart, label: "Favoritos")
      ],
      iconStyle: IconStyle(onSelectColor: Theme.of(context).primaryColor),
      labelStyle: LabelStyle(visible: false),
      onTap: _onTap,
      color: HexColor('#252525'),
      index: 1,
    );

//    final native = BottomNavigationBar(
//      items: [
//        BottomNavigationBarItem(
//            icon: Icon(FontAwesomeIcons.trophy),
//            label: "Trending"),
//        BottomNavigationBarItem(
//            icon: Icon(FontAwesomeIcons.film), title: Text("Media")),
//        BottomNavigationBarItem(
//            icon: Icon(FontAwesomeIcons.gamepad), title: Text("Juegos")),
//        BottomNavigationBarItem(
//            icon: Icon(FontAwesomeIcons.userAlt), title: Text("Favoritos"))
//      ],
//      type: BottomNavigationBarType.fixed,
//      onTap: _onTap,
//      unselectedItemColor: Colors.grey,
//      backgroundColor: HexColor('#252525'),
//      currentIndex: _controller.index,
//    );

    return Scaffold(
      body: Container(
        margin: MediaQuery.of(context).padding,
        child: TabBarView(
          children: _pages,
          physics: NeverScrollableScrollPhysics(),
          controller: _controller,
        ),
      ),
      bottomNavigationBar: bmnav,
    );
  }
}
