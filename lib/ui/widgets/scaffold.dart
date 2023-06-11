import 'package:flutter/material.dart';
import 'package:movie_search/ui/widgets/theme_switcher.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'bottom_bar.dart';

class CustomScaffold extends StatelessWidget {
  final int bottomBarIndex;
  final Widget body;
  final Widget? endDrawer;
  final String? title;

  const CustomScaffold({
    Key? key,
    required this.bottomBarIndex,
    required this.body,
    this.endDrawer,
    this.title,
    // this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showAppbar = Device.screenType == ScreenType.desktop || Device.screenType == ScreenType.tablet;

    return Scaffold(
      bottomNavigationBar: showAppbar ? null : MyBottomBar(index: bottomBarIndex),
      endDrawer: endDrawer,
      appBar: showAppbar
          ? AppBar(
              title: SizedBox(
                height: kToolbarHeight,
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
          : null,
      body: Center(child: body),
    );
  }
}
