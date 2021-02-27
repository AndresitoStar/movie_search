import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';
import 'package:provider/provider.dart';
import 'package:package_info/package_info.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<MyDatabase>(context, listen: false);
    return CustomScaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
        leading: IconButton(
          icon: Icon(MyIcons.arrow_left),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
      ),
      bottomBarIndex: 3,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    title: Text('Tema',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontWeight: FontWeight.normal)),
                    trailing: EasyDynamicThemeBtn(),
                  ),
                  Divider(),
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
                  ListTile(
                    onTap: () => db.cleanAudiovisualData(),
                    title: Text('Borrar datos de cache',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontWeight: FontWeight.normal)),
                    trailing: IconButton(
                        icon: Icon(FrinoIcons.f_eraser),
                        onPressed: () => db.cleanAudiovisualData()),
                  ),
                  Divider(),
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

  Future showAbout(BuildContext context) {
    return PackageInfo.fromPlatform().then((info) => showDialog(
          context: context,
          barrierColor:
              EasyDynamicTheme.of(context).themeMode == ThemeMode.light
                  ? Colors.black54
                  : Colors.white54,
          builder: (context) => SimpleDialog(
              title: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/ic_launcher.png'),
                ),
                title: Text(info.appName),
              ),
              children: [
                ListTile(
                  title: Text('Desarrollador'),
                  subtitle: Text('Ing. Andrés Forns Jusino'),
                ),
                ListTile(
                  title: Text('Version'),
                  subtitle: Text('${info.version}'),
                )
              ]),
        ));
  }
}
