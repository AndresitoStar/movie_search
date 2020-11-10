import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/providers/audiovisuales_provider.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/repository/repository_movie.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../widgets/audiovisual_grid_item.dart';

class AudiovisualGrid extends StatelessWidget {
  final bool isShowingFavs;
  final bool trending;
  final GRID_CONTENT gridContent;

  const AudiovisualGrid({Key key, this.isShowingFavs, this.trending = false, this.gridContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AudiovisualListProvider>(context, listen: false);
    if (isShowingFavs ?? false) {
      return provider.favs.length > 0
          ? getGrid(provider.favs)
          : Container(
              child: Center(
                child: Text('No has seleccionado ningun favorito'),
              ),
            );
    }
    if (gridContent == GRID_CONTENT.TRENDING_MOVIE) {
      provider.synchronizeTrending(context, gridContent);
      return Consumer<AudiovisualListProvider>(
          builder: (_, provider, child) =>
              provider.trendings != null && provider.trendings.length > 0
                  ? getGrid(provider.trendings)
                  : Container(
                      child: Center(
                        child: provider.trendings == null
                            ? CircularProgressIndicator()
                            : Icon(FontAwesomeIcons.solidStar),
                      ),
                    ));
    } else if (gridContent == GRID_CONTENT.TRENDING_TV) {
      provider.synchronizeTrending(context, gridContent);
      return Consumer<AudiovisualListProvider>(
          builder: (_, provider, child) =>
              provider.trendingSeries != null && provider.trendingSeries.length > 0
                  ? getGrid(provider.trendingSeries)
                  : Container(
                      child: Center(
                        child: provider.trendingSeries == null
                            ? CircularProgressIndicator()
                            : Icon(FontAwesomeIcons.solidStar),
                      ),
                    ));
    }
    return Container();
  }

  GridView getGrid(List<AudiovisualProvider> list) {
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: list.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider<AudiovisualProvider>.value(
          value: list[i],
          child: AudiovisualGridItem(
            trending: trending,
          )),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 3 / 5, crossAxisSpacing: 10, mainAxisSpacing: 10),
    );
  }
}
