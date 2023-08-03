import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_search/core/infinite_scroll_viewmodel.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:stacked/stacked.dart';

class ContentPreviewPage extends StatelessWidget {
  final InfiniteScrollViewModel param;
  final String? title;
  final bool showData;

  const ContentPreviewPage({Key? key, required this.param, this.title, this.showData = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InfiniteScrollViewModel>.reactive(
        viewModelBuilder: () => param,
        builder: (context, viewModel, child) => Scaffold(
              appBar: AppBar(
                title: Text(title ?? ''),
                primary: true,
                titleSpacing: 0,
                elevation: 0,
                leading: IconButton(icon: Icon(MyIcons.arrow_left), onPressed: () => Navigator.of(context).pop()),
              ),
              body: viewModel.isBusy
                  ? Center(child: CircularProgressIndicator())
                  : MasonryGridView.count(
                      padding: const EdgeInsets.all(10.0),
                      itemCount: viewModel.items.length + 2,
                      crossAxisCount: getColumns(context),
                      itemBuilder: (ctx, i) => AspectRatio(
                        aspectRatio: 0.667,
                        child: i < viewModel.items.length
                            ? ItemGridView(
                                item: viewModel.items[i],
                                showData: showData,
                                showTitles: true,
                                heroTagPrefix: '',
                              )
                            : viewModel.hasMore
                                ? Builder(
                                    builder: (context) {
                                      if (i == viewModel.items.length) viewModel.fetchMore();
                                      return GridItemPlaceholder();
                                    },
                                  )
                                : Container(),
                      ),
                    ),
            ));
  }

  int getColumns(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return (width ~/ 150).clamp(1, 6);
  }
}
