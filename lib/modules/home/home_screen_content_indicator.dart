import 'package:flutter/material.dart';
import 'package:movie_search/modules/trending/trending_viewmodel.dart';
import 'package:stacked/stacked.dart';

import 'home_screen_viewmodel.dart';

class HomeScreenContentIndicator extends ViewModelWidget<HomeScreenViewModel> {
  @override
  Widget build(BuildContext context, HomeScreenViewModel viewModel) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: TrendingContent.values
          .map((e) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ElevatedButton(
                  child: Text(e.title,
                      style: theme.textTheme.headline6.copyWith(
                          color: viewModel.typeSelected == e
                              ? Colors.white
                              : Colors.black26)),
                  onPressed: () => viewModel.selectType(e),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(5),
                    backgroundColor: viewModel.typeSelected == e
                        ? MaterialStateProperty.all<Color>(theme.cardColor.withOpacity(0.5))
                        : MaterialStateProperty.all<Color>(
                            theme.cardColor.withOpacity(0.5)),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
