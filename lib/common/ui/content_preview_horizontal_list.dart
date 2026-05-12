import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search/common/domain/search_result.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:movie_search/common/model/tmdb_type.dart';
import 'package:movie_search/common/provider/infinite_scroll_content_provider.dart';
import 'package:movie_search/features/audiovisual/ui/widgets/item_grid_view.dart';
import 'package:movie_search/features/home/provider/home_provider.dart';

abstract class ContentPreviewViewMoreWidget extends ConsumerWidget {
  ContentPreviewViewMoreWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLandsCape =
        forcedType != TMDB_API_TYPE.PERSON && MediaQuery.of(context).orientation == Orientation.landscape;
    //final height = MediaQuery.of(context).size.longestSide / 3.5;
    double height = forcedType == TMDB_API_TYPE.PERSON
        ? (context.mq.size.shortestSide / 2.5).clamp(100, 200)
        : isLandsCape
        ? (context.mq.size.shortestSide / 3).clamp(150, 250)
        : context.mq.size.shortestSide / 1.5;
    final aspectRatio = isLandsCape ? 16 / 9 : 0.669;

    // if isLandscape, height is 3x
      if (isLandsCape && mode == ContentPreviewMode.grid) {
        height *= 6;
      }

    List<BaseSearchResult> list = [];
    if (items != null) {
      list = items!;
    } else {
      final contentListProvider = ref.watch(fetchBaseContentProvider(config, requiredType, apiParams));
      if (contentListProvider.hasError ||
          contentListProvider.isLoading ||
          contentListProvider.value == null ||
          contentListProvider.value!.isEmpty) {
        return Container();
      }
      list = contentListProvider.value ?? [];
    }

    final contentType = ref.watch(homeContentTypeProvider);
    final title = this.title.replaceAll('{{type}}', contentType.value?.name ?? 'Movie');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          title: Text(title, style: context.textTheme.titleLarge),
          trailing: !canNavigate
              ? null
              : TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('Ver mas', style: Theme.of(context).textTheme.bodyMedium),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward_ios, size: 8),
                    ],
                  ),
                  onPressed: () => onPressed(context, title: title),
                ),
        ),
        Container(
          constraints: BoxConstraints(minHeight: height, maxHeight: height),
          child: mode == ContentPreviewMode.list
              ? ListView.builder(
                  physics: ClampingScrollPhysics(),
                  // shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: list.isEmpty ? 5 : list.length,
                  itemBuilder: (ctx, i) => AnimatedCrossFade(
                    crossFadeState: list.isEmpty ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                    duration: Duration(milliseconds: 400),
                    firstChild: AspectRatio(
                      aspectRatio: aspectRatio,
                      key: UniqueKey(),
                      child: Card(color: context.theme.dividerColor, margin: .symmetric(horizontal: 10)),
                    ),
                    secondChild: AspectRatio(
                      aspectRatio: aspectRatio,
                      key: UniqueKey(),
                      child: Builder(
                        builder: (context) {
                          if (list.isEmpty || i >= list.length) {
                            return Container();
                          }
                          final item = list[i];
                          return i < list.length
                              ? ItemGridView(
                                  item: item,
                                  showType: itemShowData,
                                  showTitles: itemShowTitle,
                                  useBackdrop: isLandsCape,
                                  heroTagPrefix: itemGridHeroTag,
                                )
                              : Container();
                        },
                      ),
                    ),
                  ),
                )
              : GridView.builder(
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 9/21,
                  ),
                  itemCount: list.length,
                  itemBuilder: (ctx, i) {
                    if (gridItemBuilder != null) {
                      return gridItemBuilder!(ctx, list[i]);
                    }
                    final item = list[i];
                    return ItemGridView(
                      item: item,
                      showType: itemShowData,
                      showTitles: itemShowTitle,
                      useBackdrop: isLandsCape,
                      heroTagPrefix: itemGridHeroTag,
                    );
                  },
                ),
        ),
      ],
    );
  }

  void onPressed(BuildContext context, {String? title}) {
    context.push(
      '/items-preview/',
      extra: {
        'title': title ?? this.title,
        'config': config,
        'apiParams': apiParams,
        'items': items,
        'requiredType': requiredType,
        'itemGridHeroTag': itemGridHeroTag,
        'forcedType': forcedType,
      },
    );
  }

  String get viewMoreButtonHeroTag;

  String get itemGridHeroTag;

  String get title;

  bool get itemShowData => false;

  bool get itemShowTitle => true;

  String get pageRouteName;

  TMDB_API_TYPE? get forcedType => null;

  TMDB_API_TYPE? requiredType;

  Map<ApiParams, String> apiParams = {};

  ContentConfig config = ContentConfig.none;

  bool get canNavigate => true;

  List<BaseSearchResult>? get items => null;

  ContentPreviewMode get mode => ContentPreviewMode.list;

  // builder para grid mode, para evitar repetir codigo en los hijos, puede ser null
  Widget Function(BuildContext context, BaseSearchResult item)? get gridItemBuilder => null;
}

enum ContentPreviewMode { list, grid }
