import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/trending/trending_viewmodel.dart';
import 'package:stacked/stacked.dart';

import 'home_screen_viewmodel.dart';

class HomeScreenContentIndicator extends ViewModelWidget<HomeScreenViewModel> {
  @override
  Widget build(BuildContext context, HomeScreenViewModel viewModel) {
    final theme = Theme.of(context);
    final tabController = DefaultTabController.of(context);
    tabController.addListener(() {
      final selected = TrendingContent.values
          .firstWhere((element) => element.type == TrendingContent.values[tabController.index].type);
      viewModel.selectType(selected);
    });
    return Container(
      height: theme.textTheme.headline5.fontSize + 20 + 10,
      padding: const EdgeInsets.only(bottom: 10),
      child: Center(
        child: TabBar(
          controller: tabController,
          isScrollable: true,
          labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
          labelStyle: theme.primaryTextTheme.headline5.copyWith(color: theme.colorScheme.onPrimary),
          unselectedLabelStyle: theme.textTheme.headline5,
          indicatorWeight: 0.0,
          indicator: BoxDecoration(
            color: theme.colorScheme.primary,
          ),
          tabs: TrendingContent.values
              .map(
                (e) => Tab(
                  child: Text(
                    e.title,
                    style: theme.primaryTextTheme.headline5.copyWith(
                      color: e == viewModel.typeSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onBackground,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
