import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_like_button.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_main_image.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/search/search_result_list_item.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/routes.dart';
import 'package:movie_search/ui/widgets/default_image.dart';

import 'item_detail_page.dart';

class ItemGridView extends StatelessWidget {
  final bool showData;
  final bool useBackdrop;
  final BaseSearchResult item;
  final EdgeInsets margin;
  final String heroTagPrefix;

  const ItemGridView({
    Key? key,
    required this.item,
    required this.heroTagPrefix,
    this.showData = true,
    this.useBackdrop = false,
    this.margin = const EdgeInsets.all(10),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (useBackdrop) return SearchResultListItem(searchResult: item);
    final theme = Theme.of(context);
    return Builder(
      builder: (context) {
        final child = Card(
          margin: margin,
          elevation: 5,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: GestureDetector(
            onTap: () => _onPressed(context),
            child: Stack(
              fit: StackFit.expand,
              children: [
                AspectRatio(
                  aspectRatio: 9 / 16,
                  child: (useBackdrop && item.backDropImage != null) || item.posterImage != null
                      ? ContentImageWidget(
                          '${useBackdrop ? item.backDropImage ?? item.posterImage : item.posterImage}',
                          fit: BoxFit.cover,
                          ignorePointer: true,
                          isBackdrop: useBackdrop && item.backDropImage != null,
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
                      ),
                      decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor.withOpacity(0.8),
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
                      ),
                    ),
                  ),
                if (showData)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Icon(item.type.icon),
                      decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor.withOpacity(0.8),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: useBackdrop
                          ? ImageFilter.blur(sigmaX: 7, sigmaY: 7)
                          : ImageFilter.blur(sigmaX: 14.0, sigmaY: 14.0),
                      child: Container(
                        color: theme.scaffoldBackgroundColor.withOpacity(useBackdrop ? 0.5 : 0.7),
                        child: ListTile(
                          title: Text(
                            item.title ?? '' + '\n',
                            textAlign: useBackdrop ? TextAlign.start : TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: theme.textTheme.headline6!.copyWith(fontSize: 16),
                          ),
                          subtitle: item.subtitle == null
                              ? null
                              : Text(
                                  item.subtitle!,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: theme.textTheme.caption,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        return Stack(
          children: [
            useBackdrop
                ? child
                : Hero(
                    tag: '$heroTagPrefix${item.id}',
                    child: child,
                  ),
            if (!useBackdrop)
              Positioned(
                bottom: 50,
                right: 0,
                child: Container(
                  child: ItemLikeButton(
                    id: item.id,
                    type: item.type,
                    iconSize: 28,
                    showDisabled: false,
                  ),
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              )
          ],
        );
      },
    );
  }

  _onPressed(BuildContext context) {
    print('$heroTagPrefix${item.id}');
    return Navigator.of(context).push(Routes.defaultRoute(
        null,
        ItemDetailPage(
          item: this.item,
          heroTagPrefix: heroTagPrefix,
        )));
  }
}
