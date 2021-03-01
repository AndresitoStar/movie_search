import 'package:flutter/material.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
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
            : Builder(builder: (context) => Container()),
      ),
      viewModelBuilder: () => FavouritesViewModel(context.read()),
    );
  }
}
