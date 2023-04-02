import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/modules/trending/trending_page.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/routes.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
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
    final itemHeight = (MediaQuery.of(context).size.width * MediaQuery.of(context).size.aspectRatio);
    return ViewModelBuilder<TrendingViewModel>.reactive(
      viewModelBuilder: () => genre != null
          ? TrendingViewModel.homeHorizontal(this.content, genre!)
          : TrendingViewModel(this.content, trendingType: trendingType),
      onModelReady: (model) => model.synchronize(),
      builder: (context, model, child) {
        final doIt = model.items.length > _defaultLength;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 0).copyWith(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < _defaultLength; ++i)
                AnimatedCrossFade(
                  firstChild: Container(key: UniqueKey(), height: itemHeight, child: GridItemPlaceholder()),
                  crossFadeState: doIt ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  duration: Duration(milliseconds: 400),
                  secondChild: Container(
                    key: UniqueKey(),
                    height: itemHeight,
                    child: doIt
                        ? ItemGridView(
                            item: model.items[i],
                            showData: false,
                            heroTagPrefix: genre != null ? genre!.id : '${content.type}${trendingType.index}',
                            useBackdrop: true,
                          )
                        : null,
                  ),
                ),
              ElevatedButton(
                child: Text('Ver Más...'),
                onPressed: () => _onPressed(context, model),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.theme.colorScheme.background,
                  foregroundColor: context.theme.colorScheme.onBackground,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _onPressed(BuildContext context, model) =>
      Navigator.of(context).push(Routes.defaultRoute(null, TrendingPage(param: model)));
}
