import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_appbar_extended.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_content.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_like_button.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_secondary_content.dart';
import 'package:movie_search/modules/audiovisual/componets/item_recomendation_horizontal_list.dart';
import 'package:movie_search/modules/audiovisual/componets/items_images_button.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_detail_viewmodel.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_recomendations_viewmodel.dart';
import 'package:movie_search/modules/person/components/person_horizontal_list.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stacked/stacked.dart';

import 'item_detail_appbar.dart';

class ItemDetailPage extends StatelessWidget {
  final BaseSearchResult item;
  final String heroTagPrefix;

  static final String route = '/detail';

  const ItemDetailPage({Key? key, required this.item, this.heroTagPrefix = ''})
      : super(key: key);

  bool get isTabletDesktop =>
      Device.screenType == ScreenType.tablet ||
      Device.screenType == ScreenType.desktop;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ItemDetailViewModel>.reactive(
      viewModelBuilder: () => ItemDetailViewModel(item),
      builder: (context, model, _) {
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Scaffold(
            appBar: isTabletDesktop
                ? AppBar(backgroundColor: Colors.transparent)
                : null,
            body: isTabletDesktop
                ? ItemDetailLandscape(heroTagPrefix)
                : ItemDetailPortrait(heroTagPrefix, item),
          ),
        );
      },
    );
  }
}

class ItemDetailPortrait extends ViewModelWidget<ItemDetailViewModel> {
  final String heroTagPrefix;
  final BaseSearchResult item;

  const ItemDetailPortrait(this.heroTagPrefix, this.item, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, ItemDetailViewModel model) {
    return CustomScrollView(
      controller: model.scrollController,
      cacheExtent: 1000,
      slivers: <Widget>[
        ItemDetailSliverAppBar(
          // ItemDetailAppbarContentExtended(heroTagPrefix: heroTagPrefix),
          ItemDetailAppbarContentSimple(),
          expandedHeight: 100.w / 0.667,
          actions: [
            if (model.dataReady) ItemLikeButton(item: model.data!),
            ItemImagesButtonView(
                id: model.itemId,
                type: model.itemType,
                title: model.title ?? ''),
            //     if (model.itemType != TMDB_API_TYPE.PERSON) VideoButton(param: model.data!),
          ],
          // ],
        ),
        if (model.hasError)
          SliverToBoxAdapter(
            child: ElevatedButton(
              onPressed: model.initialise,
              child: Text('Recargar'),
            ),
          )
        else if (model.initialised) ...[
          if (model.itemType != TMDB_API_TYPE.PERSON) ...[
            ItemDetailOverview(isSliver: true),
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
            ItemDetailRecommendationHorizontalList(
              model.itemType.type,
              model.itemId,
              ERecommendationType.Credit,
            ),
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
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: Adaptive.px(1280),
        ),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          // physics: PageScrollPhysics(),
          controller: model.scrollController,
          child: Column(
            children: [
              if (model.initialised) ...[
                ItemDetailAppbarContentExtended(
                  heroTagPrefix: heroTagPrefix,
                  isLandscape: true,
                ),
                // ItemDetailAppbarContentExtended(heroTagPrefix),
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
      ),
    );
  }
}
