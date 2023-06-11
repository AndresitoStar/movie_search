import 'package:flutter/material.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/circular_button.dart';

class ItemDetailSliverAppBar extends StatelessWidget {
  final Widget child;

  const ItemDetailSliverAppBar(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return SliverAppBar(
      pinned: true,
      expandedHeight: mq.size.width * 12 / 16,
      elevation: 0,
      automaticallyImplyLeading: false,
      // colorScheme.background: Colors.transparent,
      leading: MyCircularButton(
        // color: Colors.transparent,
        icon: Icon(
          MyIcons.arrow_left,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: child,
        collapseMode: CollapseMode.pin,
      ),
    );
  }
}
