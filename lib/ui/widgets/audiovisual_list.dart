import 'package:movie_search/providers/audiovisuales_provider.dart';
import 'package:movie_search/ui/widgets/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'audiovisual_list_item.dart';

class AudiovisualList extends StatelessWidget {
  final bool isShowingFavs;
  final bool sliverList;

  const AudiovisualList({Key key, this.isShowingFavs, this.sliverList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AudiovisualListProvider>(context, listen: false);
    if (isShowingFavs ?? false) {
      return provider.favs.length > 0
          ? ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: provider.favs.length,
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                  value: provider.favs[i], child: AudiovisualListItem()),
            )
          : Container(
              child: Center(
                child: Text('No haz seleccionado ningun favorito'),
              ),
            );
    }
    return provider.items != null && provider.items.length > 0
        ? sliverList ?? false
            ? SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, i) => i < provider.items.length
                      ? ChangeNotifierProvider.value(
                          value: provider.items[i], child: AudiovisualListItem())
                      : provider.hasMore
                          ? Builder(
                              builder: (ctx) {
                                provider.fetchMore(context);
                                return Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            )
                          : Container(
                              height: 10,
                            ),
//                    padding: const EdgeInsets.all(10.0),
                  childCount: provider.items.length + 1,
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: provider.items.length + 1,
                itemBuilder: (ctx, i) => i < provider.items.length
                    ? ChangeNotifierProvider.value(
                        value: provider.items[i], child: AudiovisualListItem())
                    : provider.hasMore
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: FlatButton(
                                onPressed: () => provider.fetchMore(context),
                                child: Text('MOSTRAR MÁS')),
                          )
                        : Container(
                            height: 10,
                          ),
              )
        : Container(
            color: Colors.white,
            child: Center(
              child: Icon(
                FontAwesomeIcons.imdb,
                size: 100,
                color: Colors.grey.withOpacity(0.09),
              ),
            ),
          );
  }
}
