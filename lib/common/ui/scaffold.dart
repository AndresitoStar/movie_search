import 'package:flutter/material.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'bottom_bar.dart';

class CustomScaffold extends StatelessWidget {
  final int bottomBarIndex;
  final Widget body;
  final Widget? endDrawer;
  final List<Widget> actions;
  final String? title;
  final bool forceAppbar;
  final PreferredSizeWidget? appBar;
  final FloatingActionButton? floatingActionButton;
  final Key? childKey;
  final Color? backgroundColor;

  const CustomScaffold({
    super.key,
    this.childKey,
    required this.bottomBarIndex,
    required this.body,
    this.endDrawer,
    this.title,
    this.appBar,
    this.forceAppbar = false,
    this.floatingActionButton,
    this.actions = const [],
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Device.screenType == ScreenType.mobile;

    return Scaffold(
      bottomNavigationBar: !isMobile || bottomBarIndex < 0 ? null : MyBottomBar(index: bottomBarIndex),
      endDrawer: endDrawer,
      floatingActionButton: floatingActionButton,
      key: childKey,
      backgroundColor: backgroundColor ?? context.theme.scaffoldBackgroundColor,
      appBar:
          appBar ??
          (!isMobile && bottomBarIndex >= 0
              ? AppBar(
                  actions: [
                    MyNavigationBar(index: bottomBarIndex),
                    ...actions,
                  ],
                  forceMaterialTransparency: true,
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
              : null),
      body: body,
    );
  }
}

class CustomScaffoldAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomScaffoldAppbar({
    super.key,
    this.customActions = const [],
    this.title,
    this.bottomBarIndex = -1,
    this.bottom,
  });

  final Widget? title;
  final List<Widget> customActions;
  final int bottomBarIndex;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight * ((bottom != null) ? 2 : 1));

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'custom_app_bar',
      child: AppBar(
        // centerTitle: false,
        backgroundColor: context.colors.primary,
        automaticallyImplyLeading: context.isMobile,
        title: title,
        bottom: bottom,
        // leading: isMobile
        //     ? Center(
        //         child: CircleAvatar(
        //           backgroundColor: Colors.transparent,
        //           radius: kToolbarHeight / 3,
        //           child: Image.asset('assets/images/ic_launcher.png'),
        //         ),
        //       )
        //     : bottomBarIndex >= 0
        //     ? Center(child: Text(' Movie Search', style: context.theme.primaryTextTheme.titleLarge))
        //     : IconButton(onPressed: context.pop, icon: Icon(Icons.arrow_back)),
        // leadingWidth: 160,
        forceMaterialTransparency: true,
        actions: [
          ...customActions,
          if (context.isMobile) SizedBox(width: 10),
          if (!context.isMobile && bottomBarIndex >= 0) MyNavigationBar(index: bottomBarIndex),
        ],
      ),
    );
  }
}
