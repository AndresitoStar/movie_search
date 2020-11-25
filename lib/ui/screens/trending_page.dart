import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/providers/audiovisuales_provider.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/widgets/audiovisual_grid_item.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class TrendingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<AudiovisualListProvider>(context, listen: false);
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: Text(provider.content.title),
        // backgroundColor: Theme.of(context).primaryColor,
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(FrinoIcons.f_arrow_left),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Consumer<AudiovisualListProvider>(
        builder: (context, provider, child) => GridView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: provider.items.length + 10,
          itemBuilder: (ctx, i) => i < provider.items.length
              ? ChangeNotifierProvider<AudiovisualProvider>.value(
                  value: provider.items[i],
                  child: AudiovisualGridItem(trending: true))
              : provider.hasMore
                  ? Builder(
                      builder: (context) {
                        if (i == provider.items.length)
                          provider.fetchMore(context);
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridItemPlaceholder());
                      },
                    )
                  : Container(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
              childAspectRatio: 5 / 9,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
        ),
      ),
    );
  }
}
