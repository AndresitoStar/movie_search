import 'package:flutter/material.dart';

import 'bottom_bar.dart';

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
    return Container(
      // padding: appBar == null
      //     ? MediaQuery.of(context)
      //         .padding
      //         .copyWith(left: 0, right: 0, bottom: 0)
      //     : null,
      color: Theme.of(context).accentColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: appBar,
          bottomNavigationBar: MyBottomBar(index: bottomBarIndex),
          body: body,
        ),
      ),
    );
  }
}
