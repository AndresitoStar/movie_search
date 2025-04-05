import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_detail_viewmodel.dart';
import 'package:movie_search/modules/imdb_rating/components/imdb_rating.dart';
import 'package:movie_search/modules/video/video_button.dart';
import 'package:movie_search/providers/util.dart';
import 'package:stacked/stacked.dart';

import 'item_detail_like_button.dart';
import 'item_detail_ui_util.dart';
import 'items_images_button.dart';

class ItemDetailMainContent extends ViewModelWidget<ItemDetailViewModel> {
  final bool isSliver;
  final bool showActions;
  final bool showOverview;

  ItemDetailMainContent({
    this.isSliver = true,
    this.showActions = false,
    this.showOverview = true,
  });

  @override
  Widget build(BuildContext context, model) {
    final BaseSearchResult item = model.data!;

    String? originalTitle;
    String? tagline;
    if (item.type == TMDB_API_TYPE.MOVIE) {
      originalTitle = item.movie!.originalTitle ?? '';
      tagline = item.movie!.tagline;
    } else if (item.type == TMDB_API_TYPE.TV_SHOW) {
      originalTitle = item.tvShow!.originalName ?? '';
      tagline = item.tvShow!.tagline;
    }

    final children = <Widget>[
      if (item.title != null)
        ListTile(
          title: Text(
            item.title!,
            style: context.theme.textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          subtitle: originalTitle != item.title &&
                  tagline != null &&
                  tagline.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (originalTitle != item.title)
                      Text(originalTitle ?? '',
                          style: context.theme.textTheme.titleMedium!.copyWith(
                            color: context.theme.textTheme.titleMedium!.color!
                                .withOpacity(0.8),
                          )),
                    if (tagline.isNotEmpty)
                      Text(
                        tagline,
                        style: context.theme.textTheme.titleMedium!.copyWith(
                          fontStyle: FontStyle.italic,
                          color: context.theme.textTheme.titleMedium!.color!
                              .withOpacity(0.8),
                        ),
                      ),
                  ],
                )
              : null,
        ),
      Row(
        children: [
          if (item.type != TMDB_API_TYPE.PERSON)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: OverflowBar(
                spacing: 10,
                children: [
                  Chip(
                    backgroundColor: Colors.transparent,
                    avatar: Icon(Icons.star, color: Colors.yellow),
                    label: Text(
                      item.voteAverage != null
                          ? item.voteAverage!.toStringAsFixed(1)
                          : 'N/A',
                      style: context.theme.textTheme.titleMedium!.copyWith(
                        color: context.theme.textTheme.titleMedium!.color!
                            .withOpacity(0.8),
                      ),
                    ),
                  ),
                  ImbdbRatingView(
                    model.itemId,
                    model.itemType.type,
                    imdbId: model.data?.movie?.imdbId,
                    key: ValueKey(model.data!.id),
                  ),
                  ContentRatingView(model.itemId, model.itemType),
                  Chip(
                    backgroundColor: Colors.transparent,
                    avatar: Icon(
                      Icons.access_time,
                      color: context.theme.colorScheme.tertiary,
                    ),
                    label: Text(
                      item.movie?.displayRuntime ??
                          item.tvShow?.displayRuntime ??
                          'N/A',
                      style: context.theme.textTheme.titleMedium!.copyWith(
                        color: context.theme.textTheme.titleMedium!.color!
                            .withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Spacer(),
          if (showActions) ...[
            ItemLikeButton(item: model.data!),
            ItemImagesButtonView(
                id: model.itemId,
                type: model.itemType,
                title: model.title ?? ''),
            if (model.itemType != TMDB_API_TYPE.PERSON)
              VideoButton(param: model.data!),
            const SizedBox(width: 20),
          ],
        ],
      ),
      if (showOverview) ItemDetailOverview() else const SizedBox(height: 10),
      // Divider(indent: 8, endIndent: 8),
    ];

    return isSliver
        ? SliverList(delegate: SliverChildListDelegate(children))
        : Column(
            children: children,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
          );
  }
}

class ItemDetailOverview extends ViewModelWidget<ItemDetailViewModel> {
  final bool isSliver;

  const ItemDetailOverview({Key? key, this.isSliver = false}) : super(key: key);

  @override
  Widget build(BuildContext context, ItemDetailViewModel model) {
    final BaseSearchResult item = model.data!;
    String? overview;
    if (item.type == TMDB_API_TYPE.MOVIE) {
      overview = item.movie!.overview ?? '';
    } else if (item.type == TMDB_API_TYPE.TV_SHOW) {
      overview = item.tvShow!.overview ?? '';
    } else if (item.type == TMDB_API_TYPE.PERSON) {
      overview = item.person!.biography ?? '';
    }
    final child = ContentHorizontal(
      content: overview,
      label: item.type == TMDB_API_TYPE.PERSON ? 'Biografía' : 'Sinopsis',
    );
    return isSliver ? SliverToBoxAdapter(child: child) : child;
  }
}
