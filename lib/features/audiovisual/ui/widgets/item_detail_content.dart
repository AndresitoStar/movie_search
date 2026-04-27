import 'package:flutter/material.dart';
import 'package:movie_search/common/domain/search_result.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:movie_search/common/model/tmdb_type.dart';
import 'package:movie_search/common/ui/utils.dart';
import 'package:movie_search/features/audiovisual/ui/widgets/imdb_widget.dart';
import 'package:movie_search/features/audiovisual/ui/widgets/item_image_button.dart';
import 'package:movie_search/features/audiovisual/ui/widgets/item_video_button.dart';

class ItemDetailMainContent extends StatelessWidget {
  final bool isSliver;
  final bool showActions;
  final bool showOverview;
  final BaseSearchResult item;

  const ItemDetailMainContent({
    super.key,
    this.isSliver = true,
    this.showActions = false,
    this.showOverview = true,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      if (item.title != null) ItemDetailListTileTitle(item: item),
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
                      item.voteAverage != null ? item.voteAverage!.toStringAsFixed(1) : 'N/A',
                      style: context.theme.textTheme.titleMedium!.copyWith(
                        color: context.theme.textTheme.titleMedium!.color!.withOpacity(0.8),
                      ),
                    ),
                  ),
                  ImdbRatingView(item.id, item.type.type, imdbId: item.movie?.imdbId, key: ValueKey(item.id)),
                  if (item.type == TMDB_API_TYPE.TV_SHOW) ContentRatingView(item.id, item.type),
                ],
              ),
            ),
          Spacer(),
          if (showActions) ...[
            // ItemLikeButton(item: model.data!),
            ItemImagesButtonView(id: item.id, type: item.type, title: item.title ?? ''),
            if (item.type != TMDB_API_TYPE.PERSON) VideoButton(param: item),
            const SizedBox(width: 20),
          ],
        ],
      ),
      if (showOverview) ItemDetailOverview(item: item) else const SizedBox(height: 10),
      // Divider(indent: 8, endIndent: 8),
    ];

    return isSliver
        ? SliverList(delegate: SliverChildListDelegate(children))
        : Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: children);
  }
}

class ItemDetailListTileTitle extends StatelessWidget {
  const ItemDetailListTileTitle({super.key, required this.item});

  final BaseSearchResult item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.title!, style: context.theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
      subtitle: item.originalTitle != item.title && item.tagline != null && item.tagline!.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item.originalTitle != item.title)
                  Text(
                    item.originalTitle ?? '',
                    style: context.theme.textTheme.titleMedium!.copyWith(
                      color: context.theme.textTheme.titleMedium!.color!.withOpacity(0.8),
                    ),
                  ),
                if (item.tagline!.isNotEmpty)
                  Text(
                    item.tagline!,
                    style: context.theme.textTheme.titleMedium!.copyWith(
                      fontStyle: FontStyle.italic,
                      color: context.theme.textTheme.titleMedium!.color!.withOpacity(0.8),
                    ),
                  ),
              ],
            )
          : null,
    );
  }
}

class ItemDetailOverview extends StatelessWidget {
  final bool isSliver;
  final bool centered;
  final BaseSearchResult item;

  const ItemDetailOverview({super.key, this.isSliver = false, required this.item, this.centered = false});

  @override
  Widget build(BuildContext context) {
    String overview = item.overview;
    final child = ContentHorizontal(
      content: overview,
      label: item.type == TMDB_API_TYPE.PERSON ? 'Biografía' : 'Sinopsis',
      centered: centered,
    );
    return isSliver ? SliverToBoxAdapter(child: child) : child;
  }
}
