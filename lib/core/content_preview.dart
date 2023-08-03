import 'package:flutter/material.dart';
import 'package:movie_search/core/content_preview_page.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/routes.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:stacked/stacked.dart';

import 'infinite_scroll_viewmodel.dart';

abstract class ContentPreviewViewMoreWidget extends StackedView<InfiniteScrollViewModel> {
  ContentPreviewViewMoreWidget({Key? key}) : super(key: key);

  @override
  void onViewModelReady(InfiniteScrollViewModel viewModel) => viewModel.fetch();

  @override
  Widget builder(BuildContext context, InfiniteScrollViewModel viewModel, Widget? child) {
    final columns = _getColumns(context);
    final totalItems = (columns * 3);
    final doIt = viewModel.items.length > totalItems;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0).copyWith(bottom: 20),
      child: GridView.builder(
        itemCount: totalItems,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (ctx, i) => i == totalItems - 1
            ? Container(
                child: Center(
                  child: FloatingActionButton(
                    child: Icon(Icons.keyboard_arrow_right),
                    onPressed: () => onPressed(context, viewModel),
                    heroTag: viewMoreButtonHeroTag,
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
                          item: viewModel.items[i],
                          showData: itemShowData,
                          showTitles: true,
                          heroTagPrefix: itemGridHeroTag,
                        )
                      : null,
                ),
              ),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          childAspectRatio: 0.667,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }

  int _getColumns(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return (width ~/ 150).clamp(2, 6);
  }

  onPressed(BuildContext context, InfiniteScrollViewModel viewModel) {
    Navigator.of(context).push(Routes.defaultRoute(null, ContentPreviewPage(param: viewModel, showData: itemShowData)));
  }

  String get viewMoreButtonHeroTag;
  String get itemGridHeroTag;
  bool get itemShowData => true;
}
