import 'package:flutter/material.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/circular_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ItemDetailSliverAppBar extends StatelessWidget {
  final Widget child;
  final List<Widget>? actions;

  const ItemDetailSliverAppBar(this.child, {Key? key, this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 75.w,
      elevation: 0,
      automaticallyImplyLeading: false,
      // colorScheme.background: Colors.transparent,
      leading: MyCircularButton(
        color: Colors.transparent,
        icon: Icon(
          MyIcons.arrow_left,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: actions,
      flexibleSpace: FlexibleSpaceBar(
        background: child,
        collapseMode: CollapseMode.pin,
      ),
    );
  }
}
