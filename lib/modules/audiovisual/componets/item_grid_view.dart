import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_like_button.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_main_image.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/search/search_result_list_item.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/routes.dart';
import 'package:movie_search/ui/widgets/default_image.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'item_detail_page.dart';

class ItemGridView extends StatelessWidget {
  final bool showType;
  final bool showTitles;
  final bool useBackdrop;
  final BaseSearchResult item;
  final EdgeInsets margin;
  final String heroTagPrefix;

  ItemGridView({
    Key? key,
    required this.item,
    required this.heroTagPrefix,
    this.showType = true,
    this.showTitles = false,
    this.useBackdrop = false,
    this.margin = const EdgeInsets.all(10),
  }) : super(key: UniqueKey());

  @override
  Widget build(BuildContext context) {
    if (useBackdrop) return SearchResultListItem(searchResult: item);
    final theme = Theme.of(context);
    final showTitlesWidget = Device.screenType == ScreenType.desktop
        ? false
        : showTitles && item.title != null;
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
              clipBehavior: Clip.antiAliasWithSaveLayer,
              children: [
                AspectRatio(
                  aspectRatio:
                      item.type == TMDB_API_TYPE.PERSON ? 0.669 : 0.667,
                  child: item.posterImage != null
                      ? ContentImageWidget(
                          item.posterImage,
                          fit: BoxFit.cover,
                          ignorePointer: true,
                          isBackdrop: false,
                        )
                      : PlaceholderImage(),
                ),
                if (showType)
                  Positioned(
                    top: -1,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 5),
                      child: Text(item.type.name.toLowerCase(),
                          style: context.theme.primaryTextTheme.bodySmall),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(10)),
                        color: context.theme.primaryColor,
                      ),
                    ),
                  ),
                if (showTitlesWidget)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        ItemBookmarkTag(item: item),
                        ClipRect(
                          child: Container(
                            color: theme.colorScheme.surface
                                .withOpacity(0.95),
                            child: ListTile(
                              title: Text(
                                item.title ?? '' + '\n',
                                textAlign: useBackdrop
                                    ? TextAlign.start
                                    : TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: theme.textTheme.titleLarge!
                                    .copyWith(fontSize: 16),
                              ),
                              subtitle: item.subtitle == null
                                  ? null
                                  : Text(
                                      item.subtitle!,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: theme.textTheme.bodySmall,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
        return child;
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
