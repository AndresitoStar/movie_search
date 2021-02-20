import 'package:flutter/material.dart';
import 'package:movie_search/components/trending/trending_page.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/audiovisual_grid_item.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'trending_viewmodel.dart';

class TrendingHorizontalList extends StatelessWidget {
  final TrendingContent content;
  final _defaultLength = 5;

  const TrendingHorizontalList({Key key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.width * 0.75;
    return ViewModelBuilder<TrendingViewModel>.reactive(
      viewModelBuilder: () => TrendingViewModel(this.content),
      onModelReady: (model) => model.synchronize(),
      builder: (context, model, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: Text(
              model.content.title,
              style: Theme.of(context).textTheme.headline5,
            ),
            trailing: IconButton(
                icon: Icon(MyIcons.arrow_right),
                color: Theme.of(context).iconTheme.color,
                onPressed: () => _goToTrendingScreen(context, model)),
          ),
          Container(
            constraints:
                BoxConstraints(minHeight: height - 100, maxHeight: height + 50),
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
                          child: Icon(MyIcons.more),
                          heroTag: 'more${model.content}',
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          foregroundColor: Theme.of(context).iconTheme.color,
                          onPressed: () => _goToTrendingScreen(context, model),
                        ),
                      ),
                    )
                  : ChangeNotifierProvider<AudiovisualProvider>.value(
                      value: model.items.length > i ? model.items[i] : null,
                      child: AspectRatio(
                        child: model.items.length > i
                            ? AudiovisualGridItem(trending: true)
                            : Container(
                                child: GridItemPlaceholder(),
                                padding: const EdgeInsets.all(6),
                              ),
                        aspectRatio: 8 / 16,
                      )),
            ),
          ),
        ],
      ),
    );
  }

  Future _goToTrendingScreen(
          BuildContext context, TrendingViewModel viewModel) =>
      Navigator.pushNamed(context, TrendingPage.routeName, arguments: viewModel);
}
