import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';

class MyEasyDynamicThemeBtn extends StatelessWidget {
  IconData _getIcon(BuildContext context) {
    var themeMode = EasyDynamicTheme.of(context).themeMode;
    return themeMode == ThemeMode.system
        ? Icons.brightness_auto
        : themeMode == ThemeMode.light
        ? Icons.brightness_high
        : Icons.brightness_4;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => EasyDynamicTheme.of(context).changeTheme(),
      icon: Icon(_getIcon(context)),
    );
  }
}
