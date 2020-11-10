import 'package:flutter/material.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/providers/util.dart';
import 'package:provider/provider.dart';

import 'audiovisual_horizontal_item.dart';

class HorizontalList extends StatelessWidget {
  final String headline;
  final List<AudiovisualProvider> list;
  final GRID_CONTENT gridContent;
  final double height;
  final double width;

  HorizontalList(
      {@required this.headline,
      @required this.list,
      @required this.gridContent,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(title: Text(headline, style: Theme.of(context).textTheme.headline6)),
        list == null
            ? Center(
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: LinearProgressIndicator()
              ))
            : SizedBox(
                height: height,
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (ctx, i) => ChangeNotifierProvider<AudiovisualProvider>.value(
                      value: list[i],
                      child: AudiovisualHorizontalItem(trending: true, width: width)),
                ),
              )
      ],
    );
  }
}
