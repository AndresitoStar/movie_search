import 'dart:ui';

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_like_button.dart';
import 'package:movie_search/modules/audiovisual/componets/items_images_button.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_detail_viewmodel.dart';
import 'package:movie_search/modules/imdb_rating/components/imdb_rating.dart';
import 'package:movie_search/modules/person/components/social_view.dart';
import 'package:movie_search/modules/video/video_button.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:stacked/stacked.dart';

import 'item_detail_main_image.dart';

class ItemDetailAppbarContentExtended extends ViewModelWidget<ItemDetailViewModel> {
  final String heroTagPrefix;

  ItemDetailAppbarContentExtended(this.heroTagPrefix);

  @override
  Widget build(BuildContext context, ItemDetailViewModel model) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);

    return Stack(
      fit: StackFit.expand,
      children: [
        IgnorePointer(
          ignoring: true,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: ContentImageWidget(
              model.backDropImageUrl ?? model.posterImageUrl,
              fit: BoxFit.cover,
              isBackdrop: model.backDropImageUrl != null,
            ),
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
                  theme.colorScheme.background.withOpacity(0.5),
                  theme.colorScheme.background.withOpacity(0.5),
                  theme.scaffoldBackgroundColor,
                ],
              ),
              border: Border.symmetric(vertical: BorderSide(color: theme.scaffoldBackgroundColor)),
            ),
          ),
        ),
        Positioned(
          left: 10,
          bottom: 10,
          top: kToolbarHeight,
          child: Hero(
            tag: '$heroTagPrefix${model.itemId}',
            child: Material(
              color: Colors.transparent,
              child: AspectRatio(
                aspectRatio: 9 / 16,
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    elevation: 0,
                    child: ContentImageWidget(model.posterImageUrl, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          top: kToolbarHeight,
          left: mq.size.width - (mq.size.width * 10 / 16) + 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacer(),
              BorderedText(
                strokeWidth: 1,
                strokeColor: theme.colorScheme.primary,
                child: Text(
                  '${model.title}',
                  style: theme.textTheme.headline5!.copyWith(
                    color: theme.colorScheme.onBackground,
                  ),
                ),
              ),
              if (model.initialised)
                if (model.itemType == TMDB_API_TYPE.PERSON && model.data?.person?.birthday != null) ...[
                  Text(
                    '${model.data!.person!.birthday ?? ''} - ${model.data!.person!.deathday ?? 'actualidad'}',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    '${_age(model.data!.person!.birthday!, model.data!.person!.deathday)} años',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ] else if (model.data!.genres != null && model.data!.genres!.isNotEmpty)
                  Text(
                    "${model.year ?? '?'} - ${model.data!.genres!.join(' / ')}",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Theme.of(context).hintColor),
                  ),
              if (model.itemType != TMDB_API_TYPE.PERSON)
                Row(
                  children: [
                    Icon(MyIcons.star, size: 18),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: model.initialised
                          ? Text(
                              '${model.data!.voteAverage!.toStringAsFixed(1)}',
                              style: theme.textTheme.headline6,
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
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Row(
            children: [
              ItemLikeButton(id: model.itemId, type: model.itemType),
              if (model.dataReady) ItemImagesButtonView(param: model.data!),
              if (model.itemType != TMDB_API_TYPE.PERSON && model.dataReady) VideoButton(param: model.data!),
            ],
          ),
        )
      ],
    );
  }

  String _age(String birthday, String? deathDay) {
    DateTime birth = DateTime.parse(birthday);
    DateTime death = deathDay != null ? DateTime.parse(deathDay) : DateTime.now();

    final age = death.difference(birth).inDays / 365.25;
    return age.floor().toStringAsFixed(0);
  }
}
