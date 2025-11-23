import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_content.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_detail_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:stacked/stacked.dart';

import 'item_detail_main_image.dart';

class ItemDetailAppbarContentExtended
    extends ViewModelWidget<ItemDetailViewModel> {
  final String heroTagPrefix;
  final bool isLandscape;

  ItemDetailAppbarContentExtended(
      {required this.heroTagPrefix, this.isLandscape = false});

  @override
  Widget build(BuildContext context, ItemDetailViewModel model) {
    final useBackdrop = model.backDropImageUrl != null;
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: IgnorePointer(
            child: ContentImageWidget(
              model.backDropImageUrl ?? model.posterImageUrl,
              fit: useBackdrop ? BoxFit.fill : BoxFit.fitHeight,
            ),
          ),
        ),
        Positioned(
          right: 0,
          left: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
                  Theme.of(context).colorScheme.surface.withValues(alpha: 0.6),
                  Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
                  Theme.of(context).colorScheme.surface,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: ItemDetailMainContent(isSliver: false, showActions: true),
          ),
        ),
      ],
    );
  }
}

class ItemDetailAppbarContentSimple
    extends ViewModelWidget<ItemDetailViewModel> {
  @override
  Widget build(BuildContext context, ItemDetailViewModel model) {
    return Stack(
      fit: StackFit.expand,
      children: [
        IgnorePointer(
          ignoring: true,
          child: ContentImageWidget(
            model.posterImageUrl,
            fit: BoxFit.cover,
            isBackdrop: model.backDropImageUrl != null,
          ),
        ),
        IgnorePointer(
          ignoring: true,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  context.theme.colorScheme.surface.withOpacity(0.2),
                  context.theme.colorScheme.surface.withOpacity(0.2),
                  context.theme.colorScheme.surface.withOpacity(0.8),
                  context.theme.scaffoldBackgroundColor,
                ],
              ),
              border: Border.symmetric(
                vertical:
                    BorderSide(color: context.theme.scaffoldBackgroundColor),
              ),
            ),
          ),
        ),
        if (model.dataReady)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ItemDetailMainContent(
              isSliver: false,
              showActions: false,
              showOverview: false,
            ),
          ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 1,
            color: context.theme.colorScheme.onSurface.withOpacity(0.2),
          ),
        ),
      ],
    );
  }
}
