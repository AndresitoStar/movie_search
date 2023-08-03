import 'package:flutter/material.dart';
import 'package:movie_search/ui/widgets/theme_switcher.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'bottom_bar.dart';

class CustomScaffold extends StatelessWidget {
  final int bottomBarIndex;
  final Widget body;
  final Widget? endDrawer;
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
    // this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showAppbar = Device.screenType == ScreenType.desktop || Device.screenType == ScreenType.tablet;

    return Scaffold(
      bottomNavigationBar: showAppbar ? null : MyBottomBar(index: bottomBarIndex),
      endDrawer: endDrawer,
      floatingActionButton: floatingActionButton,
      key: this.childKey,
      appBar: showAppbar
          ? AppBar(
              title: SizedBox(
                height: kToolbarHeight + 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(child: Text(title ?? 'Movie Search')),
                    Spacer(),
                    MyBottomBar(index: bottomBarIndex),
                    Spacer(),
                    Center(child: MyThemeBtn()),
                  ],
                ),
              ),
            )
          : forceAppbar
              ? AppBar(title: Text(title ?? 'Movie Search'))
              : null,
      body: Center(child: body),
    );
  }
}
