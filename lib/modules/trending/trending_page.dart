import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/trending/trending_viewmodel.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:stacked/stacked.dart';

class TrendingPage extends StatelessWidget {
  final TrendingViewModel param;

  const TrendingPage({Key key, @required this.param}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return ViewModelBuilder<TrendingViewModel>.reactive(
        viewModelBuilder: () =>
            TrendingViewModel.forPage(param.content, param.items, param.total),
        builder: (context, viewModel, child) => Scaffold(
              appBar: AppBar(
                title: Text(viewModel.content.title),
                // backgroundColor: Theme.of(context).primaryColor,
                titleSpacing: 0,
                leading: IconButton(
                  icon: Icon(MyIcons.arrow_left),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              body: GridView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: viewModel.items.length + 2,
                itemBuilder: (ctx, i) => i < viewModel.items.length
                    ? ItemGridView(item: viewModel.items[i])
                    : viewModel.hasMore
                        ? Builder(
                            builder: (context) {
                              if (i == viewModel.items.length)
                                viewModel.fetchMore();
                              return GridItemPlaceholder();
                            },
                          )
                        : Container(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                    childAspectRatio: 5 / 9,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
              ),
            ));
  }
}
