import 'dart:ffi';
import 'dart:io';

import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/routes.dart';
import 'package:movie_search/ui/dark.dart';
import 'package:provider/provider.dart';
import 'package:sqlite3/open.dart';

import 'data/moor_database.dart';
import 'modules/splash/splash_screen.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';

final GlobalKey<ScaffoldState> drawerKey = new GlobalKey<ScaffoldState>();

void main() {
  if (Platform.isWindows) {
    _configureSqliteOnWindows();
  }
  SharedPreferencesHelper.wasHereBefore()
      .then((value) => runApp(EasyDynamicThemeWidget(child: App())));

  doWhenWindowReady(() {
    final initialSize = Size(400, 710);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
    appWindow.maximize();
  });
}

_configureSqliteOnWindows() {
  open.overrideFor(OperatingSystem.windows, _openOnWindows);
}

DynamicLibrary _openOnWindows() {
  final scriptDir = File(Platform.script.toFilePath()).parent;
  final libraryNextToScript = File('${scriptDir.path}/sqlite3.dll');
  return DynamicLibrary.open(libraryNextToScript.path);
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MyDatabase>(
          create: (context) => MyDatabase(),
          dispose: (context, db) => db.close(),
        )
      ],
      child: MaterialApp(
        title: 'Buscador de Peliculas y Series',
        debugShowCheckedModeBanner: false,
        theme: DarkTheme.theme,
        darkTheme: DarkTheme.theme,
        themeMode: EasyDynamicTheme.of(context).themeMode,
        onGenerateRoute: Routes.generateRoute,
        initialRoute: SplashScreen.route,
      ),
    );
  }
}
