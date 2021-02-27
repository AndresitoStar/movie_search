import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_main_image.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_detail_viewmodel.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/circular_button.dart';
import 'package:stacked/stacked.dart';

import 'dart:math' as math;

class ItemDetailSliverAppBar extends ViewModelWidget<ItemDetailViewModel> {
  @override
  Widget build(BuildContext context, model) {
    final mq = MediaQuery.of(context);
    final theme = Theme.of(context);
    return SliverAppBar(
      pinned: true,
      expandedHeight: mq.size.height * 2/3,
      elevation: 0,
      primary: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      leading: MyCircularButton(
        icon: Icon(MyIcons.arrow_left),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        MyCircularButton(
          icon: Icon(MyIcons.quality),
          onPressed: () => model.toggleHighQualityImage(),
        )
      ],
      flexibleSpace: LayoutBuilder(
        builder: (context, c) {
          final settings = context
              .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
          final deltaExtent = settings.maxExtent - settings.minExtent;
          final t = (1.0 -
                  (settings.currentExtent - settings.minExtent) / deltaExtent)
              .clamp(0.0, 1.0) as double;
          final fadeStart = math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
          const fadeEnd = 1.0;
          final opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(t);

          return Opacity(
            opacity: opacity,
            child: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                width: double.infinity,
                child: ItemDetailMainImage(),
              ),
            ),
          );
        },
      ),
    );
  }
}
