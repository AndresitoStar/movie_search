import 'package:flutter/material.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/circular_button.dart';

class ItemDetailSliverAppBar extends StatelessWidget {
  final Widget child;

  const ItemDetailSliverAppBar(this.child, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return SliverAppBar(
      pinned: true,
      expandedHeight: mq.size.width * 12 / 16,
      elevation: 0,
      automaticallyImplyLeading: false,
      // backgroundColor: Colors.transparent,
      leading: MyCircularButton(
        color: Colors.transparent,
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
      // flexibleSpace: LayoutBuilder(
      //   builder: (context, c) {
      //     final settings = context
      //         .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
      //     final deltaExtent = settings.maxExtent - settings.minExtent;
      //     final t = (1.0 -
      //             (settings.currentExtent - settings.minExtent) / deltaExtent)
      //         .clamp(0.0, 1.0) as double;
      //     final fadeStart = math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
      //     const fadeEnd = 1.0;
      //     final opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(t);
      //
      //     return Opacity(
      //       opacity: opacity,
      //       child: Column(
      //         children: [
      //           Flexible(
      //             child: child,
      //           ),
      //         ],
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
