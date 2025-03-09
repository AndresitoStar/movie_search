import 'package:flutter/material.dart';
import 'package:movie_search/model/api/models/genre.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/modules/trending/trending_page.dart';
import 'package:movie_search/routes.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:stacked/stacked.dart';
import 'package:movie_search/ui/widgets/extensions.dart';

import 'trending_viewmodel.dart';

class TrendingCard extends StatelessWidget {
  final TrendingContent content;
  final TrendingType trendingType;
  final Genre? genre;

  TrendingCard({Key? key, required this.content, this.genre, this.trendingType = TrendingType.TRENDING})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TrendingViewModel>.reactive(
      viewModelBuilder: () => genre != null
          ? TrendingViewModel.homeHorizontal(this.content, genre!)
          : TrendingViewModel(this.content, trendingType: trendingType),
      onViewModelReady: (model) => model.synchronize(),
      builder: (context, model, child) {
        final columns = getColumns(context);
        final totalItems = (columns * 3);
        final doIt = model.items.length > totalItems;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 0).copyWith(bottom: 20),
          color: Theme.of(context).inputDecorationTheme.fillColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GridView.builder(
                itemCount: totalItems,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (ctx, i) => i == totalItems - 1
                    ? Container(
                        child: Center(
                          child: FloatingActionButton(
                            child: Icon(Icons.keyboard_arrow_right),
                            onPressed: () => _onPressed(context, model),
                            heroTag: 'trendingCard${content.name}',
                          ),
                        ),
                      )
                    : AnimatedCrossFade(
                        firstChild: AspectRatio(
                          aspectRatio: 0.667,
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
                                  showType: false,
                                  showTitles: true,
                                  heroTagPrefix: genre != null ? genre!.id : '${content.type}${trendingType.index}',
                                )
                              : null,
                        ),
                      ),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: getColumns(context),
                  childAspectRatio: 0.667,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
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
    return (width ~/ 150).clamp(2, 6);
  }
}
