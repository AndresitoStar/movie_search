import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';

class AudiovisualHorizontalList extends StatelessWidget {
  final String tag;
  final Future<List<BaseSearchResult>> fetchFunction;
  final VoidCallback viewMoreFunction;
  AudiovisualHorizontalList(this.fetchFunction, {Key key, this.viewMoreFunction, @required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _defaultLength = Platform.isWindows || Platform.isLinux ? 15 : 5;
    return FutureBuilder<List<BaseSearchResult>>(
        future: fetchFunction,
        initialData: [],
        builder: (context, snapshot) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: ClampingScrollPhysics(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (snapshot.data.length >= _defaultLength)
                  ...snapshot.data
                      .sublist(0, _defaultLength)
                      .map(
                        (e) => AspectRatio(
                          aspectRatio: 9 / 16,
                          child: ItemGridView(
                            item: e,
                            showData: false,
                            heroTagPrefix: tag,
                          ),
                        ),
                      )
                      .toList(),
                if (snapshot.data.length == 0)
                  ...List.generate(_defaultLength, (index) => null)
                      .map((e) => AspectRatio(aspectRatio: 9 / 16, child: GridItemPlaceholder()))
                      .toList(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: FloatingActionButton(
                      child: Icon(MyIcons.more),
                      heroTag: 'more$tag',
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      foregroundColor: Theme.of(context).iconTheme.color,
                      onPressed: viewMoreFunction,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
