import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/modules/trending/trending_page.dart';
import 'package:movie_search/routes.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:stacked/stacked.dart';

import 'trending_viewmodel.dart';

class TrendingHorizontalList extends StatelessWidget {
  final TrendingContent content;
  final _defaultLength = 15;

  const TrendingHorizontalList({Key key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TrendingViewModel>.reactive(
      viewModelBuilder: () => TrendingViewModel(this.content),
      onModelReady: (model) => model.synchronize(),
      builder: (context, model, child) => OpenContainer(
        closedColor: Colors.transparent,
        openColor: Colors.transparent,
        middleColor: Colors.transparent,
        openElevation: 0.0,
        closedElevation: 0.0,
        closedBuilder: (context, action) => Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
                left: 10,
                right: 10,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(content.title,
                          style: Theme.of(context).textTheme.headline5),
                    ),
                    IconButton(
                        icon: Icon(MyIcons.arrow_right), onPressed: action)
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
                    if (model.items.length > 0)
                      ...model.items
                          .sublist(0, _defaultLength)
                          .map((e) => AspectRatio(
                              aspectRatio: 9 / 16,
                              child: ItemGridView(item: e, showData: false)))
                          .toList(),
                    if (model.items.length == 0)
                      ...[1, 1, 1, 1, 1]
                          .map((e) => AspectRatio(
                              aspectRatio: 9 / 16,
                              child: GridItemPlaceholder()))
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
                          onPressed: action,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        openBuilder: (context, action) => TrendingPage(param: model),
      ),
    );
  }

  Future _goToTrendingScreen(
          BuildContext context, TrendingViewModel viewModel) =>
      Navigator.push(context,
          Routes.defaultPageRouteBuilder(TrendingPage(param: viewModel)));
}
