import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/modules/trending/trending_page.dart';
import 'package:movie_search/routes.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:stacked/stacked.dart';

import 'trending_viewmodel.dart';

class TrendingHorizontalList extends StatefulWidget {
  final TrendingContent content;
  final GenreTableData genre;

  TrendingHorizontalList({Key key, this.content, this.genre}) : super(key: key);

  @override
  _TrendingHorizontalListState createState() => _TrendingHorizontalListState();
}

class _TrendingHorizontalListState extends State<TrendingHorizontalList> with AutomaticKeepAliveClientMixin {
  final _defaultLength = Platform.isWindows || Platform.isLinux ? 15 : 5;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TrendingViewModel>.reactive(
      viewModelBuilder: () => TrendingViewModel.homeHorizontal(this.widget.content, widget.genre),
      onModelReady: (model) => model.synchronize(),
      builder: (context, model, child) => Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
                left: 10,
                right: 10,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.genre != null ? widget.genre.name : widget.content.title,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    IconButton(
                      icon: Icon(MyIcons.arrow_right),
                      onPressed: () => _onPressed(context, model),
                    )
                  ],
                )),
            Positioned(
              top: 45,
              bottom: 0,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: ClampingScrollPhysics(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (model.items.length >= _defaultLength)
                      ...model.items
                          .sublist(0, _defaultLength)
                          .map((e) => AspectRatio(aspectRatio: 9 / 16, child: ItemGridView(item: e, showData: false)))
                          .toList(),
                    if (model.items.length == 0)
                      ...[1, 1, 1, 1, 1]
                          .map((e) => AspectRatio(aspectRatio: 9 / 16, child: GridItemPlaceholder()))
                          .toList(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: FloatingActionButton(
                          child: Icon(MyIcons.more),
                          heroTag: 'more${model.content}',
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          foregroundColor: Theme.of(context).iconTheme.color,
                          onPressed: () => _onPressed(context, model),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onPressed(BuildContext context, model) =>
      Navigator.of(context).push(Routes.defaultRoute(null, TrendingPage(param: model)));

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
