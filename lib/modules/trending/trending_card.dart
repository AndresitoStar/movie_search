import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/modules/trending/trending_page.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/routes.dart';
import 'package:movie_search/ui/widgets/default_image.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:stacked/stacked.dart';

import 'trending_viewmodel.dart';

class TrendingCard extends StatelessWidget {
  final TrendingContent content;
  final TrendingType trendingType;
  final GenreTableData? genre;

  TrendingCard({Key? key, required this.content, this.genre, this.trendingType = TrendingType.TRENDING})
      : super(key: key);

  final _defaultLength = Platform.isWindows || Platform.isLinux ? 15 : 4;

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
        ;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 0).copyWith(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GridView.builder(
                itemCount: _defaultLength,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, i) => AnimatedCrossFade(
                  firstChild: AspectRatio(
                    aspectRatio: 5 / 9,
                    key: UniqueKey(),
                    child: GridItemPlaceholder(),
                  ),
                  crossFadeState: doIt ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  duration: Duration(milliseconds: 400),
                  secondChild: Container(
                    key: UniqueKey(),
                    child: doIt
                        ? ItemGridView(
                            item: model.items[i],
                            showData: false,
                            showTitles: true,
                            heroTagPrefix: genre != null ? genre!.id : '${content.type}${trendingType.index}',
                          )
                        : null,
                  ),
                ),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: getColumns(context),
                  childAspectRatio: 5 / 9,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
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

  int getColumns(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return (width ~/ 150).clamp(1, 8);
  }
}
