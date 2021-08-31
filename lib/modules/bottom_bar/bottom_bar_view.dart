import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'bottom_bar_viewmodel.dart';

class BottomBarView extends ViewModelWidget<BottomBarViewModel> {
  const BottomBarView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, BottomBarViewModel viewModel) {
    final theme = Theme.of(context);
    return Material(
      child: Container(
        height: kBottomNavigationBarHeight,
        color: theme.primaryColor,
        child: Center(
          child: Text(
            viewModel.data,
            textDirection: TextDirection.ltr,
            style: theme.primaryTextTheme.headline6,
          ),
        ),
      ),
    );
  }
}
