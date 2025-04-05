import 'dart:ui';

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_content.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_like_button.dart';
import 'package:movie_search/modules/audiovisual/componets/items_images_button.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_detail_viewmodel.dart';
import 'package:movie_search/modules/imdb_rating/components/imdb_rating.dart';
import 'package:movie_search/modules/person/components/social_view.dart';
import 'package:movie_search/modules/video/video_button.dart';
import 'package:movie_search/modules/video/video_carousel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
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

  Widget _buildButtons(ItemDetailViewModel model) {
    if (!model.dataReady) return Container();
    return OverflowBar(
      overflowSpacing: 0,
      alignment: MainAxisAlignment.end,
      children: [
        ItemLikeButton(item: model.data!),
        ItemImagesButtonView(
            id: model.itemId, type: model.itemType, title: model.title ?? ''),
        if (model.itemType != TMDB_API_TYPE.PERSON)
          VideoButton(param: model.data!),
      ],
    );
  }

  Widget _buildTitle(ItemDetailViewModel model, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isLandscape) Spacer() else (SizedBox(height: 10)),
          BorderedText(
            strokeWidth: 1,
            strokeColor: context.theme.colorScheme.primary,
            child: Text(
              '${model.title}',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: context.theme.textTheme.headlineSmall!.copyWith(
                color: context.theme.colorScheme.onSurface,
              ),
            ),
          ),
          if (model.initialised)
            if (model.itemType == TMDB_API_TYPE.PERSON &&
                model.data?.person?.birthday != null) ...[
              Text(
                '${model.data!.person!.birthday ?? ''} - ${model.data!.person!.deathday ?? 'actualidad'}',
                textAlign: TextAlign.start,
                style: context.theme.textTheme.titleMedium,
              ),
              Text(
                '${_age(model.data!.person!.birthday!, model.data!.person!.deathday)} años',
                textAlign: TextAlign.start,
                style: context.theme.textTheme.titleMedium,
              ),
            ] else if (model.data!.genres != null &&
                model.data!.genres!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: model.data!.genres!
                      .map(
                        (e) => Container(
                          child: Text(e),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 3, vertical: 1),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.transparent,
                            border: Border.all(
                                color: context
                                    .theme.textTheme.titleMedium!.color!),
                          ),
                        ),
                      )
                      .toList(),
                  runSpacing: 5,
                  spacing: 6,
                ),
              ),
          if (model.itemType != TMDB_API_TYPE.PERSON)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (model.year != null)
                  Chip(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                    elevation: 5,
                    label: Text(
                      '${model.year}',
                      style: TextStyle(
                          color: context.theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: context.theme.colorScheme.secondary,
                  ),
                SizedBox(width: 10),
                Icon(MyIcons.star, size: 18),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: model.initialised
                      ? Text(
                          '${model.data!.voteAverage!.toStringAsFixed(1)}',
                          style: context.theme.textTheme.titleMedium,
                        )
                      : CircularProgressIndicator.adaptive(strokeWidth: 1),
                ),
                if (model.initialised)
                  ImbdbRatingView(
                    model.itemId,
                    model.itemType.type,
                    imdbId: model.data?.movie?.imdbId,
                    key: ValueKey(model.data!.id),
                  )
              ],
            ),
          SocialView(model.itemType.type, model.itemId),
          // ItemLikeButton(
          //     id: model.itemId, type: model.data.type, iconSize: 42),
        ],
      ),
    );
  }

  IgnorePointer _buildBackgroundColor(ThemeData theme) {
    return IgnorePointer(
      ignoring: true,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.surface.withOpacity(0.5),
              theme.colorScheme.surface.withOpacity(0.5),
              theme.scaffoldBackgroundColor,
            ],
          ),
          border: Border.symmetric(
              vertical: BorderSide(color: theme.scaffoldBackgroundColor)),
        ),
      ),
    );
  }

  IgnorePointer _buildBackgroudImage(ItemDetailViewModel model) {
    return IgnorePointer(
      ignoring: true,
      child: ContentImageWidget(
        model.backDropImageUrl ?? model.posterImageUrl,
        fit: BoxFit.cover,
        isBackdrop: model.backDropImageUrl != null,
      ),
    );
  }

  String _age(String birthday, String? deathDay) {
    DateTime birth = DateTime.parse(birthday);
    DateTime death =
        deathDay != null ? DateTime.parse(deathDay) : DateTime.now();

    final age = death.difference(birth).inDays / 365.25;
    return age.floor().toStringAsFixed(0);
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
