import 'package:flutter/material.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/modules/audiovisual/model/movie.dart';
import 'package:movie_search/modules/favourite/viewmodel/favourite_viewmodel.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return ViewModelBuilder<FavouritesViewModel>.reactive(
      onModelReady: (model) => model.initialize(),
      builder: (context, model, _) => CustomScaffold(
        appBar: AppBar(
          title: Text('Favoritos'),
          leading: IconButton(
            icon: Icon(MyIcons.arrow_left),
            onPressed: () => Navigator.of(context).pop(),
          ),
          titleSpacing: 0,
        ),
        bottomBarIndex: 2,
        body: model.isBusy
            ? Center(child: CircularProgressIndicator())
            : Builder(builder: (context) {
                return StreamBuilder<List<AudiovisualTableData>>(
                    stream: model.stream,
                    initialData: [],
                    builder: (context, snapshot) {
                      if (snapshot.data.isEmpty)
                        return Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  MyIcons.favourite_on,
                                  size: 50,
                                  color: Theme.of(context).hintColor,
                                ),
                                Text(
                                  'Aqui veras los favoritos...',
                                  style: Theme.of(context).textTheme.headline5.copyWith(
                                    color: Theme.of(context).hintColor,
                                  ),
                                )
                              ],
                            ));
                      return GridView.builder(
                        padding: const EdgeInsets.all(10.0),
                        itemCount: snapshot.data.length,
                        itemBuilder: (ctx, i) {
                          return ItemGridView(
                            audiovisual: Movie()..fromData(snapshot.data[i]),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                orientation == Orientation.portrait ? 2 : 3,
                            childAspectRatio: 5 / 9,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                      );
                    });
              }),
      ),
      viewModelBuilder: () => FavouritesViewModel(context.read()),
    );
  }
}
