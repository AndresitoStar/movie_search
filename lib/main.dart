import 'dart:ffi';
import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/routes.dart';
import 'package:provider/provider.dart';
import 'package:sqlite3/open.dart';
import 'package:stacked/stacked.dart';

import 'data/moor_database.dart';
import 'modules/splash/splash_screen.dart';
import 'modules/themes/theme_viewmodel.dart';

final GlobalKey<ScaffoldState> drawerKey = new GlobalKey<ScaffoldState>();

void main() async {
  await initializeDateFormatting("es_ES", null);
  if (Platform.isWindows) {
    _configureSqliteOnWindows();
  } else if (Platform.isLinux) {
    _configureSqliteOnLinux();
  }
  final color = await _resolveColorSchema();
  SharedPreferencesHelper.wasHereBefore().then((value) => runApp(EasyDynamicThemeWidget(child: App(color: color))));

  if (Platform.isWindows || Platform.isLinux) {
    doWhenWindowReady(() {
      final initialSize = Size(400, 710);
      appWindow.minSize = initialSize;
      appWindow.size = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.show();
      // appWindow.maximize();
    });
  }
}

Future<FlexScheme> _resolveColorSchema() async {
  final color = await SharedPreferencesHelper.getFlexSchemaColor();
  if (color == null) return FlexScheme.ebonyClay;
  return FlexScheme.values.singleWhere((c) => c.toString() == color);
}

_configureSqliteOnWindows() {
  open.overrideFor(OperatingSystem.windows, _openOnWindows);
}

DynamicLibrary _openOnWindows() {
  final scriptDir = File(Platform.script.toFilePath()).parent;
  final libraryNextToScript = File('${scriptDir.path}/sqlite3.dll');
  return DynamicLibrary.open(libraryNextToScript.path);
}

_configureSqliteOnLinux() {
  // open.overrideFor(OperatingSystem.linux, _openOnLinux);
}

DynamicLibrary _openOnLinux() {
  final scriptDir = File(Platform.script.toFilePath()).parent;
  final libraryNextToScript = File('${scriptDir.path}/libsqlite3.so');
  return DynamicLibrary.open(libraryNextToScript.path);
}

class App extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();
  final FlexScheme color;

  App({Key key, @required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MyDatabase>(
          create: (context) => MyDatabase(),
          dispose: (context, db) => db.close(),
        ),
      ],
      child: ViewModelBuilder<ThemeViewModel>.reactive(
        viewModelBuilder: () => ThemeViewModel(
          color,
          themeMode: EasyDynamicTheme.of(context).themeMode,
        ),
        builder: (context, model, child) => MaterialApp(
          title: 'Buscador de Peliculas y Series',
          debugShowCheckedModeBanner: false,
          theme: model.theme,
          darkTheme: model.darkTheme,
          themeMode: EasyDynamicTheme.of(context).themeMode,
          onGenerateRoute: (settings) => Routes.generateRoute(context, settings),
          initialRoute: SplashScreen.route,
        ),
      ),
    );
  }
}
