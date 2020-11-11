import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/providers/audiovisuales_provider.dart';
import 'package:movie_search/providers/util.dart';
import 'package:provider/provider.dart';

import 'file:///C:/Workspace/Flutter/movie_search/lib/ui/screens/trending_page.dart';

import 'audiovisual_grid_item.dart';

class HorizontalList extends StatelessWidget {
  final double height;

  HorizontalList({this.height});

  final _defaultLength = 5;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AudiovisualListProvider>(context, listen: false);
    provider.synchronize(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          title: Text(provider.content.title, style: Theme.of(context).textTheme.headline6),
          trailing: IconButton(
              icon: Icon(Icons.navigate_next),
              color: Theme.of(context).iconTheme.color,
              onPressed: () => goToTrending(context, provider)),
        ),
        Consumer<AudiovisualListProvider>(
          builder: (context, provider, child) => provider.items == null || provider.items.isEmpty
              ? Center(
                  child:
                      Padding(padding: const EdgeInsets.all(8.0), child: LinearProgressIndicator()))
              : Container(
                  constraints: BoxConstraints(minHeight: height - 100, maxHeight: height + 50),
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: /*list.length*/ _defaultLength + 1,
                    itemBuilder: (ctx, i) => i == _defaultLength
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: FloatingActionButton(
                                child: Icon(FontAwesomeIcons.plus),
                                heroTag: 'more${provider.content}',
                                backgroundColor: Colors.orangeAccent,
                                foregroundColor: Colors.white,
                                onPressed: () => goToTrending(context, provider),
                              ),
                            ),
                          )
                        : ChangeNotifierProvider<AudiovisualProvider>.value(
                            value: provider.items[i],
                            child: AspectRatio(
                              child: AudiovisualGridItem(trending: true),
                              aspectRatio: 8 / 16,
                            )),
                  ),
                ),
        ),
      ],
    );
  }

  Future goToTrending(BuildContext context, AudiovisualListProvider provider) {
    return Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 400),
            pageBuilder: (_, __, ___) => ChangeNotifierProvider<AudiovisualListProvider>.value(
                value: provider, child: TrendingPage())));
  }
}
