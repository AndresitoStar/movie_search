import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_search/core/content_preview_page.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/modules/home/home_screen.dart';
import 'package:movie_search/routes.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:stacked/stacked.dart';

import 'infinite_scroll_viewmodel.dart';

abstract class ContentPreviewViewMoreWidget
    extends StackedView<InfiniteScrollViewModel> {
  ContentPreviewViewMoreWidget({Key? key}) : super(key: key);

  @override
  void onViewModelReady(InfiniteScrollViewModel viewModel) {
    viewModel.fetch();
    GetIt.instance<HomeController>().loadingStream.listen((event) {
      viewModel.fetch(force: true);
    });
  }

  @override
  Widget builder(
      BuildContext context, InfiniteScrollViewModel viewModel, Widget? child) {
    final isLandsCape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final totalItems = 5;
    final doIt = viewModel.items.length > totalItems;
    //final height = MediaQuery.of(context).size.longestSide / 3.5;
    final height = isLandsCape
        ? MediaQuery.of(context).size.shortestSide / 3
        : MediaQuery.of(context).size.shortestSide / 1.5;
    final aspectRatio = isLandsCape ? 16/9 : 0.669;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: TextButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Ver mas', style: Theme.of(context).textTheme.bodyMedium),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward_ios, size: 8),
              ],
            ),
            onPressed: () => onPressed(context, viewModel),
          ),
        ),
        Container(
          constraints: BoxConstraints(
            minHeight: height,
            maxHeight: height,
          ),
          child: ListView.builder(
            physics: ClampingScrollPhysics(),
            // shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: viewModel.items.length,
            itemBuilder: (ctx, i) => AnimatedCrossFade(
              crossFadeState: !viewModel.isBusy || !viewModel.initialised
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: Duration(milliseconds: 400),
              firstChild: AspectRatio(
                aspectRatio: aspectRatio,
                key: UniqueKey(),
                child: GridItemPlaceholder(),
              ),
              secondChild: AspectRatio(
                aspectRatio: aspectRatio,
                key: UniqueKey(),
                child: doIt
                    ? ItemGridView(
                        item: viewModel.items[i],
                        showType: itemShowData,
                        showTitles: true,
                        useBackdrop: isLandsCape,
                        heroTagPrefix: itemGridHeroTag,
                      )
                    : Container(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  int _getColumns(BuildContext context) => UiUtils.calculateColumns(
      context: context, itemWidth: 150, minValue: 2, maxValue: 6);

  onPressed(BuildContext context, InfiniteScrollViewModel viewModel) {
    Navigator.of(context).push(Routes.defaultRoute(
        null, ContentPreviewPage(param: viewModel, showData: itemShowData)));
  }

  String get viewMoreButtonHeroTag;

  String get itemGridHeroTag;

  String get title;

  bool get itemShowData => false;
}

class UiUtils {
  static int calculateColumns({
    required BuildContext context,
    required int itemWidth,
    required int minValue,
    required int maxValue,
  }) {
    final width = MediaQuery.of(context).size.width;
    return (width ~/ itemWidth).clamp(minValue, maxValue);
  }

  static String generateRandomString({int length = 10}) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random.secure();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
  }
}
