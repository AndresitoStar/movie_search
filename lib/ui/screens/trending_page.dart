import 'package:flutter/material.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/providers/audiovisuales_provider.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/widgets/audiovisual_grid_item.dart';
import 'package:movie_search/ui/widgets/theme_switcher.dart';
import 'package:provider/provider.dart';

class TrendingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AudiovisualListProvider>(context, listen: false);
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          provider.content.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [MyEasyDynamicThemeBtn()],
      ),
      body: Consumer<AudiovisualListProvider>(
        builder: (context, provider, child) => GridView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: provider.items.length + 1,
          itemBuilder: (ctx, i) => i < provider.items.length
              ? ChangeNotifierProvider<AudiovisualProvider>.value(
                  value: provider.items[i], child: AudiovisualGridItem(trending: true))
              : provider.hasMore
                  ? Builder(
                      builder: (context) {
                        provider.fetchMore(context);
                        return Padding(
                            padding: const EdgeInsets.all(8.0), child: LinearProgressIndicator());
                      },
                    )
                  : Container(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
              childAspectRatio: 3 / 5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
        ),
      ),
    );
  }
}
