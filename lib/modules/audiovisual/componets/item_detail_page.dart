import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_appbar_extended.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_content.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_like_button.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_secondary_content.dart';
import 'package:movie_search/modules/audiovisual/componets/item_recomendation_horizontal_list.dart';
import 'package:movie_search/modules/audiovisual/componets/items_images_button.dart';
import 'package:movie_search/modules/audiovisual/componets/review_button.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_detail_viewmodel.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_recomendations_viewmodel.dart';
import 'package:movie_search/modules/person/components/person_horizontal_list.dart';
import 'package:movie_search/modules/video/video_button.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stacked/stacked.dart';

import 'item_detail_appbar.dart';

class ItemDetailPage extends StatelessWidget {
  final BaseSearchResult item;
  final String heroTagPrefix;

  static final String route = '/detail';

  const ItemDetailPage({Key? key, required this.item, this.heroTagPrefix = ''}) : super(key: key);

  bool get isTabletDesktop => Device.screenType == ScreenType.tablet || Device.screenType == ScreenType.desktop;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ItemDetailViewModel>.reactive(
      viewModelBuilder: () => ItemDetailViewModel(item),
      builder: (context, model, _) {
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
            floatingActionButton: isTabletDesktop
                ? FloatingActionButton.extended(
                    onPressed: () => Navigator.of(context).pop(),
                    label: Text('ATRAS'),
                    icon: Icon(MyIcons.arrow_left),
                  )
                : null,
            body: isTabletDesktop ? ItemDetailLandscape(heroTagPrefix) : ItemDetailPortrait(heroTagPrefix, item),
          ),
        );
      },
    );
  }
}

class ItemDetailPortrait extends ViewModelWidget<ItemDetailViewModel> {
  final String heroTagPrefix;
  final BaseSearchResult item;

  const ItemDetailPortrait(this.heroTagPrefix, this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ItemDetailViewModel model) {
    return CustomScrollView(
      controller: model.scrollController,
      cacheExtent: 1000,
      slivers: <Widget>[
        ItemDetailSliverAppBar(
          // ItemDetailAppbarContentExtended(heroTagPrefix: heroTagPrefix),
            ItemDetailAppbarContentSimple(),
          // actions: [
          //   ItemLikeButton(item: item),
          //   if (model.dataReady) ...[
          //     if (model.itemType != TMDB_API_TYPE.PERSON) ReviewButton(param: model.data!),
          //     ItemImagesButtonView(param: model.data!),
          //     if (model.itemType != TMDB_API_TYPE.PERSON) VideoButton(param: model.data!),
          //   ],
          // ],
        ),
        if (model.hasError)
          SliverToBoxAdapter(child: ElevatedButton(onPressed: model.initialise, child: Text('Recargar')))
        else if (model.initialised) ...[
          ItemDetailMainContent(),
          if (model.itemType != TMDB_API_TYPE.PERSON) ...[
            CreditHorizontalList(model.itemType.type, model.itemId),
            ItemDetailSecondaryContent(),
            ItemDetailRecommendationHorizontalList(
              model.itemType.type,
              model.itemId,
              ERecommendationType.Recommendation,
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
          ] else ...[
            ItemDetailSecondaryContent(),
            ItemDetailRecommendationHorizontalList(model.itemType.type, model.itemId, ERecommendationType.Credit),
          ],
        ] else
          SliverToBoxAdapter(child: SizedBox(child: LinearProgressIndicator())),
      ],
    );
  }
}

class ItemDetailLandscape extends ViewModelWidget<ItemDetailViewModel> {
  final String heroTagPrefix;

  const ItemDetailLandscape(this.heroTagPrefix, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ItemDetailViewModel model) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // AspectRatio(
              //   aspectRatio: 0.667,
              //   child: DetailMainImage(landscape: true),
              // ),
              ItemDetailAppbarContentExtended(heroTagPrefix: heroTagPrefix, isLandscape: true),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            // physics: PageScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 8, 0, 20),
            controller: model.scrollController,
            child: Column(
              children: [
                if (model.initialised) ...[
                  // ItemDetailAppbarContentExtended(heroTagPrefix),
                  ItemDetailMainContent(isSliver: false),
                  if (model.itemType != TMDB_API_TYPE.PERSON)
                    CreditHorizontalList(
                      model.itemType.type,
                      model.itemId,
                      isSliver: false,
                    ),
                  ItemDetailSecondaryContent(isSliver: false),
                  if (model.itemType == TMDB_API_TYPE.PERSON)
                    ItemDetailRecommendationHorizontalList(
                      model.itemType.type,
                      model.itemId,
                      sliver: false,
                      ERecommendationType.Credit,
                    ),
                ],
              ],
            ),
          ),
        )
      ],
    );
  }
}
