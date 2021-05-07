import 'dart:ffi';
import 'dart:io';

import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/routes.dart';
import 'package:movie_search/ui/dark.dart';
import 'package:movie_search/ui/widgets/windows_bar.dart';
import 'package:provider/provider.dart';
import 'package:sqlite3/open.dart';
import 'package:stacked/stacked.dart';

import 'data/moor_database.dart';
import 'modules/splash/splash_screen.dart';
import 'modules/themes/theme_viewmodel.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';

final GlobalKey<ScaffoldState> drawerKey = new GlobalKey<ScaffoldState>();

void main() async {
  if (Platform.isWindows) {
    _configureSqliteOnWindows();
  }
  final color = await _resolveColorSchema();
  SharedPreferencesHelper.wasHereBefore()
      .then((value) => runApp(EasyDynamicThemeWidget(
              child: App(
            color: color,
          ))));
}

Future<FlexScheme> _resolveColorSchema() async {
  final color = await SharedPreferencesHelper.getFlexSchemaColor();
  if (color == null) return FlexScheme.ebonyClay;
  return FlexScheme.values.singleWhere((c) => c.toString() == color);
  SharedPreferencesHelper.wasHereBefore().then((value) => runApp(App()));

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
  final navigatorKey = GlobalKey<NavigatorState>();
  final FlexScheme color;

  const App({Key key, @required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<MyDatabase>(
            create: (context) => MyDatabase(),
            dispose: (context, db) => db.close(),
          )
        ],
        child: ViewModelBuilder<ThemeViewModel>.reactive(
        viewModelBuilder: () => ThemeViewModel(
          color,
          themeMode: EasyDynamicTheme.of(context).themeMode,
        ),
        builder: (context, model, child) =>MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Buscador de Peliculas y Series',
          debugShowCheckedModeBanner: false,
          theme: model.theme,
          darkTheme: model.darkTheme,
          themeMode: ThemeMode.dark,
          onGenerateRoute: Routes.generateRoute,
          initialRoute: SplashScreen.route,
        ),),
    );
  }
}
