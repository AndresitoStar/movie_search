import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyThemeBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      key: Key('EasyDynamicThemeAutoSwitch'),
      value: EasyDynamicTheme.of(context).themeMode == ThemeMode.system,
      onChanged: (bool value) =>
          EasyDynamicTheme.of(context).changeTheme(dynamic: value),
      activeColor: Theme.of(context).hintColor,
    );
  }
}
