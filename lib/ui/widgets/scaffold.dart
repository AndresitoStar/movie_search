import 'package:flutter/material.dart';
import 'package:movie_search/ui/widgets/theme_switcher.dart';

import 'bottom_bar.dart';

class CustomScaffold extends StatelessWidget {
  final int bottomBarIndex;
  final Widget body;
  final AppBar appBar;

  const CustomScaffold({Key key, @required this.bottomBarIndex, @required this.body, this.appBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        bottomNavigationBar: MyBottomBar(index: bottomBarIndex),
        appBar: appBar,
        body: body,
      ),
    );
  }
}
