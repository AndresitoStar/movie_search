import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/ui/widgets/audiovisual_grid_item.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<MyDatabase>(context, listen: false);
    final orientation = MediaQuery.of(context).orientation;
    return CustomScaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
        leading: IconButton(
          icon: Icon(FrinoIcons.f_arrow_left),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
      ),
      bottomBarIndex: 2,
      body: StreamBuilder<List<AudiovisualTableData>>(
          stream: db.watchFavourites(),
          initialData: [],
          builder: (context, snapshot) {
            if (snapshot.data.isEmpty)
              return Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FrinoIcons.f_heart,
                      size: 50, color: Theme.of(context).hintColor),
                  Text(
                    'Aqui veras los favoritos...',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: Theme.of(context).hintColor),
                  )
                ],
              ));
            return GridView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: snapshot.data.length,
              itemBuilder: (ctx, i) =>
                  ChangeNotifierProvider<AudiovisualProvider>.value(
                      value: AudiovisualProvider.fromData(snapshot.data[i]),
                      child: AudiovisualGridItem(trending: false)),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                  childAspectRatio: 5 / 9,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
            );
          }),
    );
  }
}
