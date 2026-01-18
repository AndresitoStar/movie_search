import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search/common/ui/circular_button.dart';
import 'package:movie_search/common/ui/icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ItemDetailSliverAppBar extends StatelessWidget {
  final Widget child;
  final List<Widget>? actions;
  final double? expandedHeight;

  const ItemDetailSliverAppBar(this.child, {super.key, this.actions, this.expandedHeight});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: expandedHeight ?? 75.w,
      forceMaterialTransparency: false,
      elevation: 0,
      automaticallyImplyLeading: false,
      // colorScheme.background: Colors.transparent,
      leading: MyCircularButton(
        color: Colors.transparent,
        icon: Icon(MyIcons.arrow_left, color: Theme.of(context).colorScheme.onSurface),
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go('/');
          }
        },
      ),
      actions: actions,
      flexibleSpace: FlexibleSpaceBar(background: child, collapseMode: CollapseMode.pin),
    );
  }
}
