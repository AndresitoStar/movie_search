import 'package:flutter/material.dart';
import 'package:movie_search/modules/themes/theme_selector.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';
import 'package:movie_search/ui/widgets/theme_switcher.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = "/settings";

  @override
  Widget build(BuildContext context) {
    final landscape = MediaQuery.of(context).size.aspectRatio > 0.7;

    return CustomScaffold(
      bottomBarIndex: 4,
      body: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!landscape)
                  AppBar(
                    title: Text('Acerca de'),
                    leading: IconButton(
                      icon: Icon(MyIcons.arrow_left),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    titleSpacing: 0,
                    elevation: 0,
                  ),
                Expanded(child: _getInfo(context, 'Movie Search', '2.1.0')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getInfo(BuildContext context, String appName, String version) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/ic_launcher.png', width: 150, height: 150),
        SizedBox(height: 30),
        Text(appName, style: theme.textTheme.headline4!.copyWith(color: theme.colorScheme.primary)),
        IconButton(
          icon: Icon(Icons.color_lens_rounded),
          onPressed: () => ThemeSelectorDialog.show(context),
        ),
        MyThemeBtn(),
        SizedBox(height: 30),
        Text('Made by', style: theme.textTheme.subtitle2!.copyWith(color: theme.hintColor)),
        Text('Andrés Forns Jusino', style: theme.textTheme.headline6),
        SizedBox(height: 30),
        Text('Version', style: theme.textTheme.subtitle2!.copyWith(color: theme.hintColor)),
        Text(version, style: theme.textTheme.headline6),
      ],
    );
  }
}
