import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/pages/trending_page.dart';
import 'package:provider/provider.dart';

import 'audiovisual_horizontal_item.dart';

class HorizontalList extends StatelessWidget {
  final String headline;
  final Widget subtitle;
  final List<AudiovisualProvider> list;
  final GRID_CONTENT gridContent;
  final double height;
  final double width;
  final _defaultLength = 5;

  HorizontalList(
      {@required this.headline,
      @required this.list,
      @required this.gridContent,
      this.height,
      this.width, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          title: Text(headline, style: Theme.of(context).textTheme.headline6),
          subtitle: subtitle,
          trailing: IconButton(
              icon: Icon(Icons.navigate_next),
              color: Theme.of(context).iconTheme.color,
              onPressed: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 400),
                      pageBuilder: (_, __, ___) => TrendingPage(gridContent: gridContent)))),
        ),
        list == null
            ? Center(
                child:
                    Padding(padding: const EdgeInsets.all(8.0), child: LinearProgressIndicator()))
            : SizedBox(
                height: height,
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
                              heroTag: 'more$gridContent',
                              backgroundColor: Colors.orangeAccent,
                              foregroundColor: Colors.white,
                              onPressed: () => Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      transitionDuration: Duration(milliseconds: 400),
                                      pageBuilder: (_, __, ___) =>
                                          TrendingPage(gridContent: gridContent))),
                            ),
                          ),
                        )
                      : ChangeNotifierProvider<AudiovisualProvider>.value(
                          value: list[i],
                          child: AudiovisualHorizontalItem(trending: true, width: width)),
                ),
              )
      ],
    );
  }
}
