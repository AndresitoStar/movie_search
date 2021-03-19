import 'dart:io';

import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';
import 'package:package_info/package_info.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
        leading: IconButton(
          icon: Icon(MyIcons.arrow_left),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      bottomBarIndex: 3,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // ListTile(
                  //   title: Text('Tema',
                  //       style: Theme.of(context)
                  //           .textTheme
                  //           .headline6
                  //           .copyWith(fontWeight: FontWeight.normal)),
                  //   trailing: EasyDynamicThemeBtn(),
                  // ),
                  // Divider(),
                  // ListTile(
                  //   title: Text('Mostrar recientes',
                  //       style: Theme.of(context)
                  //           .textTheme
                  //           .headline6
                  //           .copyWith(fontWeight: FontWeight.normal)),
                  //   trailing: StreamBuilder<bool>(
                  //       stream: SharedPreferencesHelper.getInstance().streamForRecent,
                  //       builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //         return snapshot.data != null
                  //             ? Switch(
                  //                 value: snapshot.data,
                  //                 inactiveTrackColor: Colors.grey.shade600,
                  //                 onChanged: (value) {
                  //                   SharedPreferencesHelper.setActiveRecent(value);
                  //                   return SharedPreferencesHelper.getInstance()
                  //                       .changeActiveRecent(value);
                  //                 },
                  //               )
                  //             : CircularProgressIndicator();
                  //       }),
                  // ),
                  // Divider(),
                  // ListTile(
                  //   onTap: () => db.cleanAudiovisualData(),
                  //   title: Text('Borrar datos de cache',
                  //       style: Theme.of(context)
                  //           .textTheme
                  //           .headline6
                  //           .copyWith(fontWeight: FontWeight.normal)),
                  //   trailing: IconButton(
                  //       icon: Icon(FrinoIcons.f_eraser),
                  //       onPressed: () => db.cleanAudiovisualData()),
                  // ),
                  // Divider(),
                  ListTile(
                    onTap: () => showAbout(context),
                    title: Text('Acerca de...',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontWeight: FontWeight.normal)),
                    trailing: IconButton(
                        icon: Icon(FrinoIcons.f_information),
                        onPressed: () => showAbout(context)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  showAbout(BuildContext context) {
    if (Platform.isWindows)
      _showInfoDialog(context, 'Buscador de Peliculas', '2.0.0');
    else
      PackageInfo.fromPlatform()
          .then((info) => _showInfoDialog(context, info.appName, info.version));
  }

  _showInfoDialog(BuildContext context, String appName, String version) {
    showDialog(
      context: context,
      barrierColor: EasyDynamicTheme.of(context).themeMode == ThemeMode.light
          ? Colors.black54
          : Colors.white54,
      builder: (context) => SimpleDialog(
          title: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/ic_launcher.png'),
            ),
            title: Text(appName),
          ),
          children: [
            ListTile(
              title: Text('Desarrollador'),
              subtitle: Text('Ing. Andrés Forns Jusino'),
            ),
            ListTile(
              title: Text('Version'),
              subtitle: Text(version),
            )
          ]),
    );
  }
}
