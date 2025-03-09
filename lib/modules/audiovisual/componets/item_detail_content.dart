import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_detail_viewmodel.dart';
import 'package:movie_search/modules/imdb_rating/components/imdb_rating.dart';
import 'package:movie_search/providers/util.dart';
import 'package:stacked/stacked.dart';

import 'item_detail_ui_util.dart';

class ItemDetailMainContent extends ViewModelWidget<ItemDetailViewModel> {
  final bool isSliver;

  ItemDetailMainContent({this.isSliver = true});

  @override
  Widget build(BuildContext context, model) {
    final BaseSearchResult item = model.data!;

    String? originalTitle;
    String? overview;
    String? tagline;
    if (item.type == TMDB_API_TYPE.MOVIE) {
      originalTitle = item.movie!.originalTitle ?? '';
      overview = item.movie!.overview ?? '';
      tagline = item.movie!.tagline;
    } else if (item.type == TMDB_API_TYPE.TV_SHOW) {
      originalTitle = item.tvShow!.originalName ?? '';
      overview = item.tvShow!.overview ?? '';
      tagline = item.tvShow!.tagline;
    } else if (item.type == TMDB_API_TYPE.PERSON) {
      overview = item.person!.biography ?? '';
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
                  item.movie?.displayRuntime ?? item.tvShow?.displayRuntime ?? 'N/A',
                  style: context.theme.textTheme.titleMedium!.copyWith(
                    color: context.theme.textTheme.titleMedium!.color!
                        .withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ContentHorizontal(
        content: overview,
        label: item.type == TMDB_API_TYPE.PERSON ? 'Biografía' : 'Sinopsis',
      ),
      // Divider(indent: 8, endIndent: 8),
    ];

    return isSliver
        ? SliverList(delegate: SliverChildListDelegate(children))
        : Column(
            children: children,
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
          );
  }
}
