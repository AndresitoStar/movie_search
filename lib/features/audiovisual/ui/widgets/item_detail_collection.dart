import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search/common/domain/search_result.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:movie_search/common/model/movie.dart';
import 'package:movie_search/common/ui/icons.dart';
import 'package:movie_search/common/utils.dart';
import 'package:movie_search/features/audiovisual/provider/audiovisual_provider.dart';
import 'package:movie_search/features/audiovisual/ui/widgets/item_grid_view.dart';

class ItemCollectionView extends ConsumerWidget {
  final bool sliver;
  final Collection collection;

  const ItemCollectionView({super.key, required this.sliver, required this.collection});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectionProvider = ref.watch(fetchCollectionDetailsProvider(collection.id.toString()));

    return Builder(
      builder: (context) {
        if (collectionProvider.isLoading) {
          final child = Center(child: CircularProgressIndicator());
          return sliver ? SliverToBoxAdapter(child: child) : child;
        }
        if (collectionProvider.hasError) {
          final child = Center(child: Text('Error al cargar la colección'));
          return sliver ? SliverToBoxAdapter(child: child) : child;
        }
        final collection = collectionProvider.value!;
        if (collection.parts == null || collection.parts!.isEmpty) {
          final child = Container();
          return sliver ? SliverToBoxAdapter(child: child) : child;
        }

        final child = Stack(
          fit: StackFit.loose,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withOpacity(0.6),
                image: collection.backdropPath == null
                    ? null
                    : DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.surface.withOpacity(0.6),
                          BlendMode.luminosity,
                        ),
                        image: NetworkImage('$URL_IMAGE_MEDIUM${collection.backdropPath}'),
                      ),
              ),
              child: ListTile(
                title: Text(
                  '${collection.name}',
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      '${collection.overview}',
                      style: Theme.of(context).primaryTextTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: null,
                          // onPressed: model.isBusy
                          //     ? null
                          //     : () => Navigator.of(
                          //         context,
                          //       ).pushNamed(ItemCollectionScreen.route, arguments: model.collection),
                          child: Text('Ver colección'),
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        );
        return sliver ? SliverToBoxAdapter(child: child) : child;
      },
    );
  }
}

class ItemCollectionScreen extends StatelessWidget {
  const ItemCollectionScreen({super.key});
  static String route = '/itemCollectionScreen';

  @override
  Widget build(BuildContext context) {
    final Collection collection = ModalRoute.of(context)!.settings.arguments as Collection;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(MyIcons.arrow_left), onPressed: () => Navigator.pop(context)),
        forceMaterialTransparency: true,
        titleSpacing: 0,
        title: Text(collection.name ?? '-'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: collection.parts?.length ?? 0,
        itemBuilder: (ctx, i) => ItemGridView(
          item: BaseSearchResult.fromMovie(collection.parts![i]),
          showType: false,
          heroTagPrefix: 'collection',
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: context.calculateColumns(itemWidth: 200, minValue: 1, maxValue: 8),
          childAspectRatio: 0.667,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
