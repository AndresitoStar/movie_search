import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_like_button.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_grid_viewmodel.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/default_image.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:stacked/stacked.dart';

import 'item_detail_page.dart';

class ItemGridView extends StatelessWidget {
  final bool trending;
  final bool showData;
  final bool withThemeColor;
  final BaseSearchResult item;

  const ItemGridView(
      {Key key,
      @required this.item,
      this.trending = true,
      this.showData = true,
      this.withThemeColor = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ItemGridViewModel>.reactive(
      viewModelBuilder: () => ItemGridViewModel(this.item),
      disposeViewModel: true,
      builder: (context, model, child) {
        if (!model.initialised) return GridItemPlaceholder();
        return OpenContainer(
          closedColor: Colors.transparent,
          openColor: Colors.transparent,
          transitionDuration: Duration(milliseconds: 400),
          closedElevation: 0.0,
          openElevation: 0.0,
          closedBuilder: (context, open) => Card(
            margin: const EdgeInsets.all(10),
            elevation: 5,
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
                // topLeft: Radius.circular(8),
              ),
            ),
            child: GestureDetector(
              onTap: open,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: Material(
                    color: withThemeColor
                        ? Theme.of(context).cardColor
                        : Colors.white,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        AspectRatio(
                          aspectRatio: 9 / 16,
                          child: item.image != null
                              ? CachedNetworkImage(
                                  imageUrl:
                                      '${model.baseImageUrl}${item.image}',
                                  placeholder: (_, __) => Container(
                                      color: Colors.transparent,
                                      child: Center(
                                          child: CircularProgressIndicator())),
                                  errorWidget: (ctx, _, __) => Container(
                                      color: Colors.transparent,
                                      child: Center(
                                          child: Icon(MyIcons.default_image))),
                                  fit: BoxFit.cover,
                                )
                              : PlaceholderImage(),
                        ),
                        if (showData && item.year != null)
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                '${item.year}',
                                style: TextStyle(color: Colors.black87),
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.8),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10)),
                              ),
                            ),
                          ),
                        if (showData)
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Icon(MyIcons.iconFromType(item.type),
                                  color: Colors.black87),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.8),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10)),
                              ),
                            ),
                          ),
                        Positioned(
                          bottom: -10,
                          right: -5,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                              ),
                            ),
                            child: ItemLikeButton(
                              id: item.id,
                              type: item.type,
                              iconSize: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
                  ListTile(
                    title: Text(
                      item.title ?? '' + '\n',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ),
          onClosed: (data) => model.initialise(),
          openBuilder: (context, close) => ItemDetailPage(item: this.item),
        );
      },
    );
  }
}
