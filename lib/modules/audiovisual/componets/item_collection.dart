import 'package:flutter/material.dart';
import 'package:movie_search/model/api/models/movie.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_collection_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:stacked/stacked.dart';

class ItemCollectionView extends StatelessWidget {
  final bool sliver;
  final Collection collection;

  const ItemCollectionView({Key? key, required this.sliver, required this.collection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ItemCollectionViewModel>.reactive(
      viewModelBuilder: () => ItemCollectionViewModel(collection),
      builder: (context, model, _) {
        final child = Stack(
          fit: StackFit.loose,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background.withOpacity(0.6),
                image: collection.backdropPath == null
                    ? null
                    : DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.background.withOpacity(0.6),
                          BlendMode.luminosity,
                        ),
                        image: NetworkImage('$URL_IMAGE_MEDIUM${collection.backdropPath}'),
                      ),
              ),
              child: ListTile(
                title: Text(
                  '${collection.name}',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      '${model.collection.overview}',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .titleMedium!
                          .copyWith(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8)),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: model.isBusy
                              ? null
                              : () => Navigator.of(context)
                                  .pushNamed(ItemCollectionScreen.route, arguments: model.collection),
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
  const ItemCollectionScreen({Key? key}) : super(key: key);
  static String route = '/itemCollectionScreen';

  @override
  Widget build(BuildContext context) {
    final Collection collection = ModalRoute.of(context)!.settings.arguments as Collection;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(MyIcons.arrow_left),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Text(collection.name ?? '-'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: collection.parts?.length ?? 0,
        itemBuilder: (ctx, i) => ItemGridView(
          item: BaseSearchResult.fromMovie(collection.parts![i]),
          showData: false,
          heroTagPrefix: 'collection',
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: getColumns(context), childAspectRatio: 0.667, crossAxisSpacing: 10, mainAxisSpacing: 10),
      ),
    );
  }

  int getColumns(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return (width ~/ 150).clamp(1, 6);
  }
}
