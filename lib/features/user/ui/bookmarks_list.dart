import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search/common/domain/search_result.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:movie_search/common/ui/icons.dart';
import 'package:movie_search/common/utils.dart';
import 'package:movie_search/features/user/provider/favourite_provider.dart';

class BookmarksListView extends ConsumerWidget {
  const BookmarksListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouritesMapProvider = ref.watch(favouriteListProvider);

    return favouritesMapProvider.when(
      data: (data) => _BookmarksListContent(favouriteMap: data),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}

class _BookmarksListContent extends StatelessWidget {
  const _BookmarksListContent({super.key, required this.favouriteMap});

  final Map<String, List<BaseSearchResult>> favouriteMap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: favouriteMap.isEmpty
          ? _buildEmptyList()
          : GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: context.calculateColumns(itemWidth: 180, minValue: 1, maxValue: 8),
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: favouriteMap.length,
              itemBuilder: (ctx, i) {
                final entry = favouriteMap.entries.elementAt(i);
                return _buildItemList(context, entry);
              },
            ),
    );
  }

  Widget _buildItemList(BuildContext context, MapEntry<String, List<BaseSearchResult?>> entry) {
    return GestureDetector(
      // onTap: () => Navigator.of(
      //   context,
      // ).push(Routes.defaultRoute(null, ItemListPage(items: entry.value as List<BaseSearchResult>, title: entry.key))),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: context.theme.colorScheme.onSurface.withValues(alpha: 0.1),
          border: Border.all(
            color: context.theme.colorScheme.onSurface.withValues(alpha: 0.1),
            width: 1,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            entry.value.first?.posterImage != null
                ? Image.network('$URL_IMAGE_MEDIUM${entry.value.first?.posterImage}', fit: BoxFit.cover)
                : Container(color: Theme.of(context).canvasColor),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Theme.of(context).colorScheme.surface.withOpacity(0.99),
                child: ListTile(
                  title: Text(entry.key.capitalize, style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
                  subtitle: Text(
                    '${entry.value.length} elementos',
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyList() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(MyIcons.favourite_off, size: 64),
          SizedBox(height: 25.0),
          Text('No tienes Favoritas todavía.'),
        ],
      ),
    );
  }
}
