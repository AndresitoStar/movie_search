import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/modules/trending/trending_page.dart';
import 'package:movie_search/routes.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:stacked/stacked.dart';

import 'trending_viewmodel.dart';

class TrendingHorizontalList extends StatefulWidget {
  final TrendingContent content;
  final TrendingType trendingType;
  final GenreTableData genre;

  TrendingHorizontalList({Key key, this.content, this.genre, this.trendingType = TrendingType.TRENDING})
      : super(key: key);

  @override
  _TrendingHorizontalListState createState() => _TrendingHorizontalListState();
}

class _TrendingHorizontalListState extends State<TrendingHorizontalList> with AutomaticKeepAliveClientMixin {
  final _defaultLength = Platform.isWindows || Platform.isLinux ? 15 : 10;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ViewModelBuilder<TrendingViewModel>.reactive(
      viewModelBuilder: () => widget.genre != null
          ? TrendingViewModel.homeHorizontal(this.widget.content, widget.genre)
          : TrendingViewModel(this.widget.content, trendingType: widget.trendingType),
      onModelReady: (model) => model.synchronize(),
      builder: (context, model, child) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Chip(
                    label: Text(widget.trendingType.title),
                    avatar: Icon(widget.trendingType.icon, size: 16, color: theme.primaryColor),
                    labelPadding: EdgeInsets.symmetric(horizontal: 3),
                  ),
                  SizedBox(width: 5),
                  Chip(
                    label: Text(widget.genre != null ? widget.genre.name : widget.content.title),
                    avatar: Icon(widget.content.icon, size: 16, color: theme.primaryColor),
                    labelPadding: EdgeInsets.symmetric(horizontal: 3),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: ClampingScrollPhysics(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (model.items.length >= _defaultLength)
                      ...model.items
                          .sublist(0, _defaultLength)
                          .map(
                            (e) => AspectRatio(
                              aspectRatio: 9 / 16,
                              child: ItemGridView(
                                item: e,
                                showData: false,
                                heroTagPrefix: widget.genre != null
                                    ? widget.genre.id
                                    : '${widget.content.type}${widget.trendingType.index}',
                              ),
                            ),
                          )
                          .toList(),
                    if (model.items.length == 0)
                      ...[1, 1, 1, 1, 1]
                          .map((e) => AspectRatio(aspectRatio: 9 / 16, child: GridItemPlaceholder()))
                          .toList(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: ElevatedButton(
                          child: Text('Ver Más'),
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
  bool get wantKeepAlive => true;
}
