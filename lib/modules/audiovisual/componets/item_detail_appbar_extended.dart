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
  final bool isLandscape;

  ItemDetailAppbarContentExtended({required this.heroTagPrefix, this.isLandscape = false});

  @override
  Widget build(BuildContext context, ItemDetailViewModel model) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);

    return isLandscape
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: '$heroTagPrefix${model.itemId}',
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  child: ContentImageWidget(model.posterImageUrl, fit: BoxFit.cover),
                ),
              ),
              _buildTitle(theme, model, context, true),
              _buildButtons(model)
            ],
          )
        : Stack(
            fit: StackFit.expand,
            children: [
              _buildBackgroudImage(model),
              _buildBackgroundColor(theme),
              Positioned(
                left: 10,
                bottom: 10,
                right: mq.size.width * 10 / 16,
                child: Hero(
                  tag: '$heroTagPrefix${model.itemId}',
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    color: Colors.transparent,
                    // child: Container(),
                    child: ContentImageWidget(model.posterImageUrl, fit: BoxFit.cover),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                top: kToolbarHeight,
                left: mq.size.width - (mq.size.width * 10 / 16) + 10,
                child: _buildTitle(theme, model, context, false),
              ),
              // Positioned(
              //   top: 10,
              //   right: 10,
              //   child: _buildButtons(model),
              // )
            ],
          );
  }

  Widget _buildButtons(ItemDetailViewModel model) {
    if (!model.dataReady) return Container();
    return ButtonBar(
      overflowButtonSpacing: 0,
      alignment: MainAxisAlignment.center,
      children: [
        ItemLikeButton(item: model.data!),
        ItemImagesButtonView(param: model.data!),
        if (model.itemType != TMDB_API_TYPE.PERSON) VideoButton(param: model.data!),
      ],
    );
  }

  Column _buildTitle(ThemeData theme, ItemDetailViewModel model, BuildContext context, bool isLandscape) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!isLandscape) Spacer() else (SizedBox(height: 10)),
        BorderedText(
          strokeWidth: 1,
          strokeColor: theme.colorScheme.primary,
          child: Text(
            '${model.title}',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall!.copyWith(
              color: theme.colorScheme.onBackground,
            ),
          ),
        ),
        if (model.initialised)
          if (model.itemType == TMDB_API_TYPE.PERSON && model.data?.person?.birthday != null) ...[
            Text(
              '${model.data!.person!.birthday ?? ''} - ${model.data!.person!.deathday ?? 'actualidad'}',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '${_age(model.data!.person!.birthday!, model.data!.person!.deathday)} años',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ] else if (model.data!.genres != null && model.data!.genres!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: model.data!.genres!
                    .map(
                      (e) => Container(
                        child: Text(e),
                        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.transparent,
                          border: Border.all(color: context.theme.textTheme.titleMedium!.color!),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (model.year != null)
                Chip(
                  padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                  elevation: 5,
                  label: Text(
                    '${model.year}',
                    style: TextStyle(color: context.theme.colorScheme.onPrimary, fontWeight: FontWeight.bold),
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
                        style: theme.textTheme.titleMedium,
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
              theme.colorScheme.background.withOpacity(0.5),
              theme.colorScheme.background.withOpacity(0.5),
              theme.scaffoldBackgroundColor,
            ],
          ),
          border: Border.symmetric(vertical: BorderSide(color: theme.scaffoldBackgroundColor)),
        ),
      ),
    );
  }

  IgnorePointer _buildBackgroudImage(ItemDetailViewModel model) {
    return IgnorePointer(
      ignoring: true,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: ContentImageWidget(
          model.backDropImageUrl ?? model.posterImageUrl,
          fit: BoxFit.cover,
          isBackdrop: model.backDropImageUrl != null,
        ),
      ),
    );
  }

  String _age(String birthday, String? deathDay) {
    DateTime birth = DateTime.parse(birthday);
    DateTime death = deathDay != null ? DateTime.parse(deathDay) : DateTime.now();

    final age = death.difference(birth).inDays / 365.25;
    return age.floor().toStringAsFixed(0);
  }
}
