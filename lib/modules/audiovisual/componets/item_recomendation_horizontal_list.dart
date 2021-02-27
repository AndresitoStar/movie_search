import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_recomendations_viewmodel.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:stacked/stacked.dart';

class ItemDetailRecomendationHorizontalList extends StatelessWidget {
  final String type;
  final String typeId;

  const ItemDetailRecomendationHorizontalList(this.type, this.typeId, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ItemRecomendationViewModel>.reactive(
      viewModelBuilder: () =>
          ItemRecomendationViewModel(this.type, this.typeId),
      builder: (context, model, _) {
        final height = MediaQuery.of(context).size.width * 0.75;
        return SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                  title: Text('Recomendaciones',
                      style: Theme.of(context).textTheme.headline5)),
              Container(
                padding: const EdgeInsets.only(bottom: 20),
                constraints: BoxConstraints(
                    minHeight: height - 100, maxHeight: height + 50),
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
                          child: ItemGridView(audiovisual: model.items[i]),
                          aspectRatio: 8 / 16,
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
