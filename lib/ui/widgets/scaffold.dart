import 'package:flutter/material.dart';

import 'bottom_bar.dart';
import 'dart:ui' as ui;

class CustomScaffold extends StatelessWidget {
  final int bottomBarIndex;
  final Widget body;
  final AppBar appBar;

  const CustomScaffold(
      {Key key,
      @required this.bottomBarIndex,
      @required this.body,
      this.appBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: Container(
                decoration:
                    BoxDecoration(color: Colors.black.withOpacity(0.2)),
              ),
            ),
          ),
          Scaffold(
            appBar: appBar,
            bottomNavigationBar: MyBottomBar(index: bottomBarIndex),
            body: body,
          ),
        ],
      ),
    );
  }
}
