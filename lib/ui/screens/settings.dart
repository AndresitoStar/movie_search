import 'dart:io';

import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';
import 'package:package_info/package_info.dart';

class SettingsScreen extends StatelessWidget {
  static String routeName = "/settings";
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomBarIndex: 3,
      body: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppBar(
                  title: Text('Acerca de'),
                  leading: IconButton(
                    icon: Icon(MyIcons.arrow_left),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  titleSpacing: 0,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                Expanded(
                    child: _getInfo(context, 'Buscador de Peliculas', '2.0.0')),
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
        SizedBox(height: 50),
        Text(appName,
            style:
                theme.textTheme.headline4.copyWith(color: theme.accentColor)),
        SizedBox(height: 30),
        Text('Desarrollador',
            style: theme.textTheme.subtitle2.copyWith(color: theme.hintColor)),
        Text('Ing. Andrés Forns Jusino', style: theme.textTheme.headline6),
        SizedBox(height: 30),
        Text('Version',
            style: theme.textTheme.subtitle2.copyWith(color: theme.hintColor)),
        Text(version, style: theme.textTheme.headline6),
      ],
    );
  }
}
