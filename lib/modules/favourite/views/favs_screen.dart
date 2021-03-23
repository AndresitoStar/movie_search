import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/favourite/viewmodel/favourite_viewmodel.dart';
import 'package:movie_search/modules/person/components/person_item_grid.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class FavouriteScreen extends StatelessWidget {
  static String routeName = "/favourite";
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavouritesViewModel>.nonReactive(
      onModelReady: (model) => model.initialize(),
      builder: (context, model, _) => DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: CustomScaffold(
          bottomBarIndex: 2,
          body: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                  floating: false,
                  snap: false,
                  pinned: true,
                  elevation: 3,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  title: Text('Favoritos'),
                  leading: IconButton(
                    icon: Icon(MyIcons.arrow_left),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  titleSpacing: 0,
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Peliculas"),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Series"),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Personas"),
                        ),
                      ),
                    ],
                    // indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelColor: Colors.white70,
                    labelColor: Theme.of(context).accentColor,
                    labelStyle: Theme.of(context).textTheme.headline6,
                    // indicator: BubbleTabIndicator(
                    //   indicatorHeight: 25.0,
                    //   indicatorColor: Theme.of(context).accentColor,
                    //   tabBarIndicatorSize: TabBarIndicatorSize.label,
                    // ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                _favouriteMoviePage(context, model),
                _favouriteTvPage(context, model),
                _favouritePersonPage(context, model),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => FavouritesViewModel(context.read()),
    );
  }

  Widget _favouriteMoviePage(
      BuildContext context, FavouritesViewModel viewModel) {
    return StreamBuilder<List<Movie>>(
        stream: viewModel.streamMovies,
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.data.length == 0) return _buildEmptyList('Peliculas');
          return GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: snapshot.data.length,
            itemBuilder: (ctx, i) => ItemGridView(
                item: BaseSearchResult.fromMovie(snapshot.data[i])),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: getColumns(context),
                childAspectRatio: 5 / 9,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
          );
        });
  }

  Widget _favouriteTvPage(BuildContext context, FavouritesViewModel viewModel) {
    return StreamBuilder<List<TvShow>>(
        stream: viewModel.streamTvShow,
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.data.length == 0) return _buildEmptyList('Series');
          return GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: snapshot.data.length,
            itemBuilder: (ctx, i) =>
                ItemGridView(item: BaseSearchResult.fromTv(snapshot.data[i])),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: getColumns(context),
                childAspectRatio: 5 / 9,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
          );
        });
  }

  Widget _favouritePersonPage(
      BuildContext context, FavouritesViewModel viewModel) {
    return StreamBuilder<List<Person>>(
        stream: viewModel.streamPerson,
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.data.length == 0) return _buildEmptyList('Personas');
          return GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: snapshot.data.length,
            itemBuilder: (ctx, i) =>
                PersonItemGridView(person: snapshot.data[i]),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: getColumns(context),
                childAspectRatio: 5 / 9,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
          );
        });
  }

  Widget _buildEmptyList(String type) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(MyIcons.favourite_off, size: 64),
          SizedBox(height: 25.0),
          Text('No tienes $type Favoritas todavía.'),
        ],
      ),
    );
  }

  int getColumns(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return (width ~/ 160).clamp(1, 8);
  }
}
