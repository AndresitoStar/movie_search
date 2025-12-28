import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search/features/search/ui/search_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colors => Theme.of(this).colorScheme;

  MediaQueryData get mq => MediaQuery.of(this);

  goHome() => go('/home');

  goSearch() {
    final isMobile = Device.screenType == ScreenType.mobile;
    if (!isMobile) {
      return SearchPage.showDialog(this);
    }
    return push('/search');
  }

  goDiscover() => push('/discover');

  goFavourites() => push('/profile');

  goSettings() => push('/settings');

  int calculateColumns({required int itemWidth, required int minValue, required int maxValue}) {
    final width = MediaQuery.of(this).size.width;
    return (width ~/ itemWidth).clamp(minValue, maxValue);
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
