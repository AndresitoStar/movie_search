import 'package:day_night_switch/day_night_switch.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';

class MyThemeBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.5,
      child: DayNightSwitch(
        key: Key('EasyDynamicThemeAutoSwitch'),
        value: EasyDynamicTheme.of(context).themeMode == ThemeMode.dark,
        onChanged: (value) => EasyDynamicTheme.of(context).changeTheme(dark: value),
      ),
    );
  }
}
