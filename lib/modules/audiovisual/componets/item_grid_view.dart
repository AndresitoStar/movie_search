import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/service/service.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_grid_viewmodel.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'item_detail_page.dart';

class ItemGridView<T extends ModelBase> extends StatelessWidget {
  final bool trending;
  final bool showData;
  final bool withThemeColor;
  final ModelBase audiovisual;

  const ItemGridView(
      {Key key,
      @required this.audiovisual,
      this.trending = true,
      this.showData = true,
      this.withThemeColor = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ItemGridViewModel>.reactive(
      viewModelBuilder: () => ItemGridViewModel<T>(
          AudiovisualService.getInstance(), this.audiovisual, context.read()),
      builder: (context, model, child) {
        if (!model.initialised) return GridItemPlaceholder();
        return OpenContainer(
          closedColor: Colors.transparent,
          openColor: Colors.transparent,
          transitionDuration: Duration(milliseconds: 400),
          closedElevation: 0.0,
          openElevation: 0.0,
          closedBuilder: (context, open) => _viewHolder(context, model, open),
          onClosed: (data) => model.initialise(),
          openBuilder: (context, close) =>
              ItemDetailPage<T>(item: this.audiovisual),
        );
      },
    );
  }

  Widget _viewHolder(
      BuildContext context, ItemGridViewModel model, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 5,
      clipBehavior: Clip.hardEdge,
      color: withThemeColor ? Theme.of(context).cardTheme.color : Colors.white,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 5,
                child: Hero(
                  tag: '$trending${audiovisual.id}',
                  child: Material(
                    color: withThemeColor
                        ? Theme.of(context).cardColor
                        : Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(trending ? 5 : 3),
                      child: ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        borderRadius: BorderRadius.circular(3),
                        child: CachedNetworkImage(
                          imageUrl: '${model.baseImageUrl}${audiovisual.image}',
                          placeholder: (_, __) => Container(
                              color: Colors.transparent,
                              child:
                                  Center(child: CircularProgressIndicator())),
                          errorWidget: (ctx, _, __) => Container(
                              color: Colors.transparent,
                              child:
                                  Center(child: Icon(MyIcons.default_image))),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                )),
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Positioned(
                      bottom: 12,
                      left: 12,
                      child: Text(
                        '${trending ? audiovisual.voteAverage : audiovisual.data.score ?? ''}',
                        style: Theme.of(context).textTheme.subtitle1,
                      )),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Builder(
                      builder: (context) => model.initialised && model.isBusy
                          ? Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.all(5),
                              child: Center(
                                  child: SizedBox(
                                height: 20,
                                width: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 1),
                              )),
                            )
                          : IconButton(
                              onPressed: () => model.toggleFavourite(),
                              alignment: Alignment.centerRight,
                              icon: model.isFavourite
                                  ? Icon(MyIcons.favourite_on,
                                      color: Colors.redAccent)
                                  : Icon(MyIcons.favourite_off)),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      audiovisual.title ?? '' + '\n',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 16),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
