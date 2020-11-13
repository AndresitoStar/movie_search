import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomBarIndex: 3,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: ListTile(
              title: Text(
                'Configuración',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    title: Text('Tema', style: Theme.of(context).textTheme.headline6),
                    trailing: EasyDynamicThemeBtn(),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Mostrar recientes', style: Theme.of(context).textTheme.headline6),
                    trailing: StreamBuilder<bool>(
                        stream: SharedPreferencesHelper.getInstance().streamForRecent,
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          return snapshot.data != null
                              ? Switch(
                                  value: snapshot.data,
                                  inactiveTrackColor: Colors.grey.shade600,
                                  onChanged: (value) {
                                    SharedPreferencesHelper.setActiveRecent(value);
                                    return SharedPreferencesHelper.getInstance()
                                        .changeActiveRecent(value);
                                  },
                                )
                              : CircularProgressIndicator();
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
