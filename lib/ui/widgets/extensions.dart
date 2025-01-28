import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/trending/trending_viewmodel.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/dialogs.dart';

extension HowShowErrorExtension on BuildContext {
  void showError({required String error, VoidCallback? onTapDismiss}) {
    MyDialogs.showError(this, error: error, onTapDismiss: () {
      onTapDismiss?.call();
      Navigator.pop(this);
    });
  }

  Future showLoginDialog() => MyDialogs.showLoginDialog(this);

  Future showLoginModalBottomSheet() => MyDialogs.showLoginModalBottomSheet(this);

  Future runSafety(AsyncCallback run) async {
    try {
      await run();
    } catch (e) {
      showError(error: e.toString());
    }
  }
}

extension NumExtension on num {
  String minutesToHHMM() {
    int hours = this ~/ 60;
    num remainingMinutes = this % 60;
    String formattedHours = hours.toString().padLeft(2, '0');
    String formattedMinutes = remainingMinutes.toInt().toString().padLeft(2, '0');
    return '$formattedHours:$formattedMinutes';
  }
}

extension ExtensionTitleTrending on TrendingType {
  String get title {
    switch (this) {
      case TrendingType.TRENDING:
        return 'Tendencia';
      case TrendingType.POPULAR:
        return 'Popular';
      default:
        return '';
    }
  }

  IconData get icon {
    switch (this) {
      case TrendingType.TRENDING:
        return MyIcons.trending;
      case TrendingType.POPULAR:
        return MyIcons.popular;
    }
  }
}

extension ExtensionTitle on TrendingContent {
  String get title {
    switch (this) {
      case TrendingContent.MOVIE:
        return 'Películas';
      case TrendingContent.TV:
        return 'Series';
      case TrendingContent.PERSON:
        return 'Personas';
      default:
        return '';
    }
  }

  String get titleTrending {
    switch (this) {
      case TrendingContent.MOVIE:
        return 'En Cines';
      case TrendingContent.TV:
        return 'En Televisión';
      default:
        return '';
    }
  }

  IconData get icon {
    switch (this) {
      case TrendingContent.MOVIE:
        return MyIcons.movie;
      case TrendingContent.TV:
        return MyIcons.tv;
      case TrendingContent.PERSON:
        return MyIcons.people;
    }
  }

  String get type {
    switch (this) {
      case TrendingContent.MOVIE:
        return 'movie';
      case TrendingContent.TV:
        return 'tv';
      case TrendingContent.PERSON:
        return 'person';
    }
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
