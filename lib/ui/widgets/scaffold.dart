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
  final FloatingActionButton? floatingActionButton;
  final Key? childKey;

  const CustomScaffold({
    Key? key,
    this.childKey,
    required this.bottomBarIndex,
    required this.body,
    this.endDrawer,
    this.title,
    this.forceAppbar = false,
    this.floatingActionButton,
    this.actions = const [],
    // this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showAppbar = Device.screenType != ScreenType.mobile;

    return Scaffold(
      bottomNavigationBar: showAppbar || bottomBarIndex < 0
          ? null
          : MyBottomBar(index: bottomBarIndex),
      endDrawer: endDrawer,
      floatingActionButton: floatingActionButton,
      key: this.childKey,
      appBar: showAppbar && bottomBarIndex >= 0
          ? AppBar(
              actions: actions,
              forceMaterialTransparency: true,
              elevation: 2,
              title: SizedBox(
                height: kToolbarHeight + 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(child: Text(title ?? 'Movie Search')),
                    Spacer(),
                    MyBottomBar(index: bottomBarIndex),
                  ],
                ),
              ),
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
