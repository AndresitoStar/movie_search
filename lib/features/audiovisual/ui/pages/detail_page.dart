import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search/common/domain/search_result.dart';
import 'package:movie_search/common/model/tmdb_type.dart';
import 'package:movie_search/features/audiovisual/provider/audiovisual_provider.dart';
import 'package:movie_search/features/audiovisual/ui/widgets/credits_horizontal.dart';
import 'package:movie_search/features/audiovisual/ui/widgets/item_detail_appbar.dart';
import 'package:movie_search/features/audiovisual/ui/widgets/item_detail_appbar_extended.dart';
import 'package:movie_search/features/audiovisual/ui/widgets/item_detail_content.dart';
import 'package:movie_search/features/audiovisual/ui/widgets/item_detail_secondary_content.dart';
import 'package:movie_search/features/audiovisual/ui/widgets/item_image_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DetailPage extends StatelessWidget {
  final BaseSearchResult item;
  final String heroTagPrefix;

  const DetailPage({super.key, required this.item, required this.heroTagPrefix});

  bool get isTabletDesktop => Device.screenType == ScreenType.tablet || Device.screenType == ScreenType.desktop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isTabletDesktop ? AppBar(backgroundColor: Colors.transparent) : null,
      body: isTabletDesktop
          ? ItemDetailLandscape(heroTagPrefix: heroTagPrefix, item: item)
          : ItemDetailPortrait(heroTagPrefix, item),
    );
  }
}

class ItemDetailPortrait extends ConsumerWidget {
  final String heroTagPrefix;
  final BaseSearchResult item;

  const ItemDetailPortrait(this.heroTagPrefix, this.item, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsProvider = ref.watch(fetchDetailsProvider(this.item.id, this.item.type.type));

    BaseSearchResult item = detailsProvider.value ?? this.item;

    return CustomScrollView(
      cacheExtent: 1000,
      slivers: <Widget>[
        ItemDetailSliverAppBar(
          // ItemDetailAppbarContentExtended(heroTagPrefix: heroTagPrefix),
          ItemDetailPortraitAppbarContentSimple(item: item),
          expandedHeight: 100.w / 0.667,
          actions: [
            // if (detailsProvider.isLoading) ItemLikeButton(item: model.data!),
            ItemImagesButtonView(id: item.id, type: item.type, title: item.title ?? ''),
            //     if (model.itemType != TMDB_API_TYPE.PERSON) VideoButton(param: model.data!),
          ],
          // ],
        ),
        if (detailsProvider.hasError)
          SliverToBoxAdapter(
            child: ElevatedButton(
              onPressed: () {
                ref.invalidate(fetchDetailsProvider(item.id, item.type.type));
              },
              child: Text('Recargar'),
            ),
          )
        else if (detailsProvider.hasValue) ...[
          ItemDetailOverview(isSliver: true, item: item),
          if (item.type != TMDB_API_TYPE.PERSON) ...[
            SliverToBoxAdapter(
              child: CreditsHorizontal(type: item.type.type, id: item.id),
            ),
            ItemDetailSecondaryContent(item: item),
            SliverToBoxAdapter(
              child: RecommendationsHorizontal(type: item.type.type, id: item.id),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
          ] else ...[
            ItemDetailSecondaryContent(item: item),
            // ItemDetailRecommendationHorizontalList(model.itemType.type, model.itemId, ERecommendationType.Credit.type),
          ],
        ] else
          SliverToBoxAdapter(child: SizedBox(child: LinearProgressIndicator())),
      ],
    );
  }
}

class ItemDetailLandscape extends ConsumerWidget {
  final String heroTagPrefix;
  final BaseSearchResult item;

  const ItemDetailLandscape({super.key, required this.heroTagPrefix, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsProvider = ref.watch(fetchDetailsProvider(this.item.id, this.item.type.type));

    BaseSearchResult item = detailsProvider.value ?? this.item;

    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: Adaptive.px(1280)),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          // physics: PageScrollPhysics(),
          child: Column(
            children: [
              ...[
                ItemDetailListTileTitle(item: item),
                ItemDetailLandscapeAppBar(heroTagPrefix: heroTagPrefix, isLandscape: true, item: item),
                if (item.hasBackdrop()) ItemDetailOverview(item: item),
                // ItemDetailAppbarContentExtended(heroTagPrefix),
                if (!item.isPerson()) CreditsHorizontal(id: item.id, type: item.type.type),
                ItemDetailSecondaryContent(isSliver: false, item: item),
                RecommendationsHorizontal(type: item.type.type, id: item.id),
                SizedBox(height: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
