import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_appbar_extended.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_content.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_secondary_content.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_detail_viewmodel.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_recomendations_viewmodel.dart';
import 'package:movie_search/modules/person/components/person_horizontal_list.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:stacked/stacked.dart';

import 'item_detail_appbar.dart';
import 'item_detail_main_image.dart';
import 'item_recomendation_horizontal_list.dart';

class ItemDetailPage extends StatelessWidget {
  final BaseSearchResult item;
  final String heroTagPrefix;

  const ItemDetailPage({Key key, @required this.item, this.heroTagPrefix = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final landscape = MediaQuery.of(context).size.aspectRatio > 0.7;
    return ViewModelBuilder<ItemDetailViewModel>.reactive(
      viewModelBuilder: () => ItemDetailViewModel(item),
      builder: (context, model, _) => Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          top: true,
          child: Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
            floatingActionButton: landscape
                ? FloatingActionButton.extended(
                    onPressed: () => Navigator.of(context).pop(),
                    label: Text('ATRAS'),
                    icon: Icon(MyIcons.arrow_left),
                  )
                : null,
            body: model.hasError
                ? Center(
                    child: Text('${model.modelError?.toString()}'),
                  )
                : landscape
                    ? ItemDetailLandscape()
                    : ItemDetailPortrait(heroTagPrefix),
          ),
        ),
      ),
    );
  }
}

class ItemDetailPortrait extends ViewModelWidget<ItemDetailViewModel> {
  final String heroTagPrefix;
  const ItemDetailPortrait(this.heroTagPrefix, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ItemDetailViewModel model) {
    return CustomScrollView(
      controller: model.scrollController,
      cacheExtent: 1000,
      slivers: <Widget>[
        ItemDetailSliverAppBar(ItemDetailAppbarContentExtended(heroTagPrefix)),
        if (model.initialised) ...[
          ItemDetailMainContent(),
          if (model.itemType != TMDB_API_TYPE.PERSON) ...[
            CreditHorizontalList(model.itemType.type, model.itemId),
            ItemDetailSecondaryContent(),
            ItemDetailRecommendationHorizontalList(
                model.itemType.type, model.itemId, ERecommendationType.Recommendation),
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
  const ItemDetailLandscape({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ItemDetailViewModel model) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width / 2.5),
          child: Container(
            alignment: Alignment.center,
            child: AspectRatio(
              aspectRatio: 9 / 16,
              child: DetailMainImage(landscape: true),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            // physics: PageScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
            controller: model.scrollController,
            child: Column(
              children: [
                if (model.initialised) ...[
                  ItemDetailMainContent(isSliver: false),
                  if (model.itemType != TMDB_API_TYPE.PERSON)
                    CreditHorizontalList(
                      model.itemType.type,
                      model.itemId,
                      isSliver: false,
                    ),
                  ItemDetailSecondaryContent(isSliver: false),
                  if (model.itemType != TMDB_API_TYPE.PERSON)
                    ItemDetailRecommendationHorizontalList(
                      model.itemType.type,
                      model.itemId,
                      ERecommendationType.Recommendation,
                      sliver: false,
                    ),
                  if (model.itemType == TMDB_API_TYPE.PERSON)
                    ItemDetailRecommendationHorizontalList(
                        model.itemType.type, model.itemId, ERecommendationType.Credit),
                ],
              ],
            ),
          ),
        )
      ],
    );
  }
}
