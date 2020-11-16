import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/providers/audiovisuales_provider.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/screens/trending_page.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import 'audiovisual_grid_item.dart';

class HorizontalList extends StatelessWidget {
  final double height;

  HorizontalList({this.height});

  final _defaultLength = 5;

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<AudiovisualListProvider>(context, listen: false);
    provider.synchronize(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          title: Text(
            provider.content.title,
            style: Theme.of(context).textTheme.headline5,
          ),
          trailing: IconButton(
              icon: Icon(FrinoIcons.f_arrow_right),
              color: Theme.of(context).iconTheme.color,
              onPressed: () => goToTrending(context, provider)),
        ),
        Consumer<AudiovisualListProvider>(
          builder: (context, provider, child) => Container(
            constraints:
                BoxConstraints(minHeight: height - 100, maxHeight: height + 50),
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
                          child: Icon(FrinoIcons.f_more_horizontal),
                          heroTag: 'more${provider.content}',
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          foregroundColor: Theme.of(context).iconTheme.color,
                          onPressed: () => goToTrending(context, provider),
                        ),
                      ),
                    )
                  : ChangeNotifierProvider<AudiovisualProvider>.value(
                      value:
                          provider.items.length > i ? provider.items[i] : null,
                      child: AspectRatio(
                        child: provider.items.length > i
                            ? AudiovisualGridItem(trending: true)
                            : Container(
                                child: GridItemPlaceholder(),
                                padding: const EdgeInsets.all(6),
                              ),
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
            pageBuilder: (_, __, ___) =>
                ChangeNotifierProvider<AudiovisualListProvider>.value(
                    value: provider, child: TrendingPage())));
  }
}
