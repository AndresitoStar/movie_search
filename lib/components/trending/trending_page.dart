import 'package:flutter/material.dart';
import 'package:movie_search/components/trending/trending_viewmodel.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/audiovisual_grid_item.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class TrendingPage extends StatelessWidget {
  static String routeName = "/trending";

  @override
  Widget build(BuildContext context) {
    final TrendingViewModel param = ModalRoute.of(context).settings.arguments;

    final orientation = MediaQuery.of(context).orientation;
    return ViewModelBuilder<TrendingViewModel>.reactive(
        viewModelBuilder: () =>
            TrendingViewModel.forPage(param.content, param.items),
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
                itemCount: viewModel.items.length + 10,
                itemBuilder: (ctx, i) => i < viewModel.items.length
                    ? ChangeNotifierProvider<AudiovisualProvider>.value(
                        value: viewModel.items[i],
                        child: AudiovisualGridItem(trending: true))
                    : viewModel.hasMore
                        ? Builder(
                            builder: (context) {
                              if (i == viewModel.items.length)
                                viewModel.fetchMore();
                              return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GridItemPlaceholder());
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
