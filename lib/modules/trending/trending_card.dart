import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/modules/trending/trending_page.dart';
import 'package:movie_search/routes.dart';
import 'package:stacked/stacked.dart';

import 'trending_viewmodel.dart';

class TrendingCard extends StatelessWidget {
  final TrendingContent content;
  final TrendingType trendingType;
  final GenreTableData? genre;

  TrendingCard({Key? key, required this.content, this.genre, this.trendingType = TrendingType.TRENDING})
      : super(key: key);

  final _defaultLength = Platform.isWindows || Platform.isLinux ? 15 : 3;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ViewModelBuilder<TrendingViewModel>.reactive(
      viewModelBuilder: () => genre != null
          ? TrendingViewModel.homeHorizontal(this.content, genre!)
          : TrendingViewModel(this.content, trendingType: trendingType),
      onModelReady: (model) => model.synchronize(),
      builder: (context, model, child) => Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: Text(
                '${genre != null ? genre!.name : content.title} en ${trendingType.title}',
                style: theme.textTheme.headline6!.copyWith(color: theme.primaryColor),
              ),
            ),
            if (model.items.length > _defaultLength)
              for (var i = 0; i < _defaultLength; ++i)
                Container(
                  height: 150,
                  child: ItemGridView(
                    item: model.items[i],
                    showData: false,
                    heroTagPrefix: genre != null ? genre!.id : '${content.type}${trendingType.index}',
                    useBackdrop: true,
                  ),
                ),
            Center(
              child: TextButton(
                child: Text('Ver Más...'),
                onPressed: () => _onPressed(context, model),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onPressed(BuildContext context, model) =>
      Navigator.of(context).push(Routes.defaultRoute(null, TrendingPage(param: model)));
}
