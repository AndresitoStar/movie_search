import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/trending/trending_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomeScreenViewModel extends BaseViewModel {
  TrendingContent typeSelected;
  final PageController pageController;

  HomeScreenViewModel()
      : typeSelected = TrendingContent.MOVIE,
        pageController = PageController();

  void selectType(TrendingContent type) {
    this.typeSelected = type;
    this.pageController.jumpToPage(TrendingContent.values.indexOf(type));
    notifyListeners();
  }
}
