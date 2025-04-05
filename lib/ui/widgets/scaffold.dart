import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'bottom_bar.dart';

class CustomScaffold extends StatelessWidget {
  final int bottomBarIndex;
  final Widget body;
  final Widget? endDrawer;
  final List<Widget> actions;
  final String? title;
  final bool forceAppbar;
  final AppBar? appBar;
  final FloatingActionButton? floatingActionButton;
  final Key? childKey;

  const CustomScaffold({
    Key? key,
    this.childKey,
    required this.bottomBarIndex,
    required this.body,
    this.endDrawer,
    this.title,
    this.appBar,
    this.forceAppbar = false,
    this.floatingActionButton,
    this.actions = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = Device.screenType == ScreenType.mobile;

    return Scaffold(
      bottomNavigationBar: !isMobile || bottomBarIndex < 0
          ? null
          : MyBottomBar(index: bottomBarIndex),
      endDrawer: endDrawer,
      floatingActionButton: floatingActionButton,
      key: this.childKey,
      appBar: appBar != null
          ? appBar
          : !isMobile && bottomBarIndex >= 0
              ? AppBar(
                  actions: [
                    MyNavigationBar(index: bottomBarIndex),
                    ...actions,
                  ],
                  forceMaterialTransparency: true,
                  automaticallyImplyLeading: bottomBarIndex > 0,
                  elevation: 2,
                  title: Text(title ?? 'Movie Search'),
                )
              : forceAppbar
                  ? AppBar(
                      title: Text(title ?? 'Movie Search'),
                      forceMaterialTransparency: true,
                      elevation: 1,
                      actions: actions,
                    )
                  : null,
      body: Center(child: body),
    );
  }
}
