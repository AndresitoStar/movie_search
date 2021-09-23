import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/trending/trending_viewmodel.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';

import 'home_screen_viewmodel.dart';

class HomeScreenContentIndicator extends ViewModelWidget<HomeScreenViewModel> {
  @override
  Widget build(BuildContext context, HomeScreenViewModel viewModel) {
    final theme = Theme.of(context);
    final controller = AdvancedSegmentController(viewModel.typeSelected.type);
    controller.addListener(() {
      final selected = TrendingContent.values.firstWhere((element) => element.type == controller.value);
      viewModel.selectType(selected);
    });

    return Container(
      height: 32,
      child: ReactiveForm(
        formGroup: viewModel.form,
        child: ReactiveFormField<TrendingContent, TrendingContent>(
          formControl: viewModel.typeControl,
          builder: (field) => AdvancedSegment(
            segments: Map.fromIterable(
              TrendingContent.values,
              key: (element) => (element as TrendingContent).type,
              value: (element) => (element as TrendingContent).title,
            ),
            backgroundColor: theme.colorScheme.background,
            sliderColor: theme.colorScheme.primaryVariant,
            activeStyle: TextStyle(color: theme.colorScheme.onPrimary),
            inactiveStyle: TextStyle(color: theme.colorScheme.onBackground),
            controller: controller,
          ),
        ),
      ),
    );
  }
}
