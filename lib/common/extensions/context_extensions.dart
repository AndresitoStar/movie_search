import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search/common/ui/dialogs.dart';
import 'package:movie_search/features/search/ui/search_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colors => Theme.of(this).colorScheme;

  MediaQueryData get mq => MediaQuery.of(this);

  bool get isMobile => Device.screenType == ScreenType.mobile;

  void goHome() => go('/home');

  Future goSearch() {
    final isMobile = Device.screenType == ScreenType.mobile;
    if (!isMobile) {
      return SearchPage.showDialog(this);
    }
    return push('/search');
  }

  Future goDiscover() => push('/discover');

  Future goFavourites() => push('/profile');

  Future goSettings() => push('/settings');

  int calculateColumns({required int itemWidth, required int minValue, required int maxValue}) {
    final width = MediaQuery.of(this).size.width;
    return (width ~/ itemWidth).clamp(minValue, maxValue);
  }

  Future showErrorDialog({required String error, VoidCallback? onTapDismiss}) async {
    if (!mounted) return;
    return MyDialogs.showError(this, error: error, onTapDismiss: onTapDismiss);
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
