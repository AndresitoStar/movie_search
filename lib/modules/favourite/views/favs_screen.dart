import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/favourite/viewmodel/favourite_viewmodel.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class FavouriteScreen extends StatelessWidget {
  static String routeName = "/favourite";

  @override
  Widget build(BuildContext context) {
    final landscape = MediaQuery.of(context).size.aspectRatio > 0.7;

    return ViewModelBuilder<FavouritesViewModel>.nonReactive(
      onModelReady: (model) => model.initialize(),
      builder: (context, model, _) => CustomScaffold(
        bottomBarIndex: 3,
        body: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                floating: false,
                snap: false,
                pinned: true,
                // elevation: 0,
                primary: true,
                title: Text('Favoritos'),
                leading: IconButton(
                  icon: Icon(MyIcons.arrow_left),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                titleSpacing: 0,
                toolbarHeight: landscape ? 0 : kToolbarHeight,
              ),
            ];
          },
          body: StreamBuilder<List<BaseSearchResult?>>(
              stream: model.stream,
              initialData: [],
              builder: (context, snapshot) {
                if (snapshot.data != null && snapshot.data!.length == 0) return _buildEmptyList();
                return GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (ctx, i) => ItemGridView(item: snapshot.data![i]!, heroTagPrefix: ''),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: getColumns(context),
                      childAspectRatio: 5 / 9,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                );
              }),
        ),
      ),
      viewModelBuilder: () => FavouritesViewModel(context.read()),
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

  int getColumns(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return (width ~/ 160).clamp(1, 8);
  }
}
