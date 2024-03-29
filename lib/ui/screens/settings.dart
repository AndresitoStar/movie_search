import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/themes/theme_selector.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = "/settings";

  @override
  Widget build(BuildContext context) {
    final landscape = MediaQuery.of(context).size.aspectRatio > 0.7;

    return CustomScaffold(
      bottomBarIndex: 3,
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
        Text(appName, style: theme.textTheme.headline4!.copyWith(color: theme.colorScheme.secondary)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.color_lens_rounded),
              onPressed: () => ThemeSelectorDialog.show(context),
            ),
            EasyDynamicThemeBtn(),
            // IconButton(
            //   icon: Icon(Icons.high_quality),
            //   onPressed: () => _showImageQualityDialog(context),
            // ),
          ],
        ),
        SizedBox(height: 30),
        Text('Desarrollador', style: theme.textTheme.subtitle2!.copyWith(color: theme.hintColor)),
        Text('Ing. Andrés Forns Jusino', style: theme.textTheme.headline6),
        SizedBox(height: 30),
        Text('Version', style: theme.textTheme.subtitle2!.copyWith(color: theme.hintColor)),
        Text(version, style: theme.textTheme.headline6),
      ],
    );
  }
}
