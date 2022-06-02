import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/modules/audiovisual/componets/item_list_page.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_recomendations_viewmodel.dart';
import 'package:movie_search/routes.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:stacked/stacked.dart';

class ItemDetailRecommendationHorizontalList extends StatelessWidget {
  final String type;
  final num typeId;
  final ERecommendationType recommendationType;
  final bool sliver;

  const ItemDetailRecommendationHorizontalList(this.type, this.typeId, this.recommendationType,
      {Key? key, this.sliver = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ItemRecommendationViewModel>.reactive(
      viewModelBuilder: () => ItemRecommendationViewModel(this.type, this.typeId, this.recommendationType),
      builder: (context, model, _) {
        final height = 300.0;
        final child = !model.initialised
            ? Container(height: 10, child: LinearProgressIndicator())
            : model.isBusy
                ? LinearProgressIndicator()
                : model.items.length > 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Divider(indent: 8, endIndent: 8),
                          ListTile(
                            title: Text(
                              recommendationType.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: Theme.of(context).primaryColor),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.grid_view_rounded),
                              onPressed: () => Navigator.of(context).push(
                                Routes.defaultRoute(
                                  null,
                                  ItemListPage(
                                    items: model.items,
                                    title: recommendationType.name,
                                    heroTagPrefix: recommendationType.type,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 20),
                            constraints: BoxConstraints(minHeight: height, maxHeight: height + 50),
                            child: model.isBusy
                                ? ListView.builder(
                                    physics: ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder: (ctx, i) => AspectRatio(
                                      child: GridItemPlaceholder(),
                                      aspectRatio: 8 / 16,
                                    ),
                                  )
                                : ListView.builder(
                                    physics: ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: model.items.length,
                                    itemBuilder: (ctx, i) => AspectRatio(
                                      child: ItemGridView(
                                        item: model.items[i],
                                        heroTagPrefix: '$i-${recommendationType.type}-',
                                      ),
                                      aspectRatio: 8 / 15,
                                    ),
                                  ),
                          ),
                        ],
                      )
                    : Container();
        return sliver ? SliverToBoxAdapter(child: child) : child;
      },
    );
  }
}
