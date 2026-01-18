import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search/common/domain/search_result.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:movie_search/common/model/tmdb_type.dart';
import 'package:movie_search/common/ui/content_image.dart';
import 'package:movie_search/common/ui/placeholder_image.dart';
import 'package:movie_search/features/audiovisual/ui/widgets/item_bookmark_tag.dart';
import 'package:movie_search/features/audiovisual/ui/widgets/item_list_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
    if (item.isPerson()) {
      return ItemGridViewPerson(item: item, heroTagPrefix: heroTagPrefix);
    }
    final theme = Theme.of(context);
    final showTitlesWidget = Device.screenType == ScreenType.desktop ? true : showTitles && item.title != null;
    return Builder(
      builder: (context) {
        final child = Card(
          margin: margin,
          elevation: 5,
          clipBehavior: Clip.hardEdge,
          shape: item.isPerson()
              ? CircleBorder(
                  side: BorderSide(color: theme.scaffoldBackgroundColor, style: .solid, width: 2, strokeAlign: 1),
                )
              : RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: GestureDetector(
            onTap: () => context.push(
              '/${item.type.type.toLowerCase()}/${item.id}',
              extra: {'item': item, 'tag': heroTagPrefix},
            ),
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              children: [
                AspectRatio(
                  aspectRatio: item.isPerson() ? 0.669 : 0.667,
                  child: item.posterImage != null
                      ? ContentImageWidget(item.posterImage, fit: BoxFit.cover, ignorePointer: true, isBackdrop: false)
                      : PlaceholderImage(),
                ),
                if (showType)
                  Positioned(
                    top: -1,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
                        color: context.theme.primaryColor,
                      ),
                      child: Text(item.type.name.toLowerCase(), style: context.theme.primaryTextTheme.bodySmall),
                    ),
                  ),
                if (showTitlesWidget)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        if (!item.isPerson()) ItemBookmarkTag(item: item),
                        ClipRect(
                          child: Container(
                            color: theme.colorScheme.surface.withOpacity(0.95),
                            padding: .symmetric(horizontal: item.isPerson() ? 25 : 0),
                            child: ListTile(
                              title: Text(
                                item.title ??
                                    ''
                                        '\n',
                                textAlign: useBackdrop ? TextAlign.start : TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: theme.textTheme.titleLarge!.copyWith(fontSize: 16),
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
}

class ItemGridViewPerson extends StatelessWidget {
  final BaseSearchResult item;
  final String heroTagPrefix;

  ItemGridViewPerson({Key? key, required this.item, required this.heroTagPrefix}) : super(key: UniqueKey());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .start,
      spacing: 10,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Card(
            elevation: 5,
            margin: .symmetric(horizontal: 8),
            clipBehavior: Clip.hardEdge,
            shape: CircleBorder(
              side: BorderSide(color: context.theme.scaffoldBackgroundColor, style: .solid, width: 2, strokeAlign: 1),
            ),
            child: GestureDetector(
              onTap: () => context.push(
                '/${item.type.type.toLowerCase()}/${item.id}',
                extra: {'item': item, 'tag': heroTagPrefix},
              ),
              child: item.posterImage != null
                  ? ContentImageWidget(item.posterImage, fit: BoxFit.cover, ignorePointer: true, isBackdrop: false)
                  : PlaceholderImagePerson(),
            ),
          ),
        ),
        if (item.title != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              item.title!,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: context.theme.textTheme.titleLarge!.copyWith(fontSize: 16),
            ),
          ),
      ],
    );
  }
}
