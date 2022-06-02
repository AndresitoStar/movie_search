import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/modules/trending/trending_viewmodel.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

import 'home_screen_viewmodel.dart';

class HomePopularWidget extends ViewModelWidget<HomeScreenViewModel> {
  const HomePopularWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeScreenViewModel model) {
    final tabController = DefaultTabController.of(context);
    return ReactiveForm(
      formGroup: model.form,
      child: Column(
        children: [
          Container(
            height: 250,
            child: TabBarView(
              controller: tabController,
              children: TrendingContent.values
                  .map((e) => model.popularMapFull == null || model.popularMapFull.isEmpty
                      ? Center(child: CircularProgressIndicator(strokeWidth: 1))
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: ClampingScrollPhysics(),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: model.popularMapFull[e.type]
                                .map(
                                  (e) => AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: ItemGridView(
                                      item: e,
                                      showData: false,
                                      useBackdrop: true,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
