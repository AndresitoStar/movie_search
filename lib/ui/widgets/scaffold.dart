import 'package:flutter/material.dart';

import 'bottom_bar.dart';

class CustomScaffold extends StatelessWidget {
  final int bottomBarIndex;
  final Widget body;
  final Widget? endDrawer;
  // final AppBar appBar;

  const CustomScaffold({
    Key? key,
    required this.bottomBarIndex,
    required this.body,
    this.endDrawer,
    // this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final landscape = MediaQuery.of(context).size.aspectRatio > 0.7;
    return Scaffold(
      bottomNavigationBar: /* landscape ? null : */ MyBottomBar(index: bottomBarIndex),
      endDrawer: endDrawer,
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 1080),
          alignment: Alignment.center,
          child: body,
        ),
      ),
    );
  }
}
