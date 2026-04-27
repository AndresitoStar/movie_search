import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search/common/domain/search_result.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:movie_search/common/model/tmdb_type.dart';
import 'package:movie_search/common/provider/infinite_scroll_content_provider.dart';
import 'package:movie_search/features/audiovisual/ui/widgets/item_grid_view.dart';

class AudiovisualListPage extends ConsumerStatefulWidget {
  const AudiovisualListPage({super.key, required this.params});

  final Map<String, dynamic> params;

  @override
  ConsumerState<AudiovisualListPage> createState() => _AudiovisualListPageState();
}

class _AudiovisualListPageState extends ConsumerState<AudiovisualListPage> {
  String get title => widget.params['title'] ?? '';

  String get itemGridHeroTag => widget.params['itemGridHeroTag'] ?? '';

  List<BaseSearchResult>? get initialItems => widget.params['items'] as List<BaseSearchResult>?;

  ContentConfig get apiPath => widget.params['config'] as ContentConfig;

  TMDB_API_TYPE? get requiredType => widget.params['requiredType'] as TMDB_API_TYPE?;

  TMDB_API_TYPE? get forcedType => widget.params['forcedType'] as TMDB_API_TYPE?;

  Map<ApiParams, String> get apiParams => widget.params['apiParams'] as Map<ApiParams, String>;

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final notifier = ref.read(contentPreviewListItemsProvider(apiPath, requiredType, apiParams).notifier);
      final state = ref.read(contentPreviewListItemsProvider(apiPath, requiredType, apiParams));

      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 300 && !state.isLoading) {
        notifier.loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), forceMaterialTransparency: true),
      body: initialItems != null
          ? _buildListView(context, initialItems!)
          : Builder(
              builder: (context) {
                final itemsProvider = ref.watch(contentPreviewListItemsProvider(apiPath, requiredType, apiParams));
                if (itemsProvider.isEmpty) {
                  return Container();
                }

                return RefreshIndicator(
                  onRefresh: () =>
                      ref.read(contentPreviewListItemsProvider(apiPath, requiredType, apiParams).notifier).refresh(),
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10.0),
                    controller: _scrollController,
                    itemCount: itemsProvider.itemCount + 1,
                    itemBuilder: (ctx, i) {
                      if (i == itemsProvider.itemCount) {
                        return const Center(
                          child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator()),
                        );
                      }
                      return ItemGridView(
                        item: itemsProvider.items[i],
                        showType: false,
                        showTitles: true,
                        heroTagPrefix: '$i-$itemGridHeroTag-',
                      );
                    },
                    gridDelegate: gridDelegate(context),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildListView(BuildContext context, List<BaseSearchResult> items) {
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: items.length,
      itemBuilder: (ctx, i) =>
          ItemGridView(item: items[i], showType: false, showTitles: true, heroTagPrefix: '$i-$itemGridHeroTag-'),
      gridDelegate: gridDelegate(context),
    );
  }
}

SliverGridDelegate gridDelegate(BuildContext context, {TMDB_API_TYPE? forcedType}) {
  return SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: context.calculateColumns(itemWidth: 180, minValue: 1, maxValue: 8),
    childAspectRatio: forcedType == TMDB_API_TYPE.PERSON ? 1 : 0.667,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
  );
}