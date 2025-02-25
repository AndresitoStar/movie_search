import 'dart:ffi';
import 'dart:io';

import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:movie_search/core/content_type_controller.dart';
import 'package:movie_search/firebase_options.dart';
import 'package:movie_search/modules/account/viewModel/account_viewmodel.dart';
import 'package:movie_search/modules/favourite/viewmodel/favourite_viewmodel.dart';
import 'package:movie_search/modules/home/home_screen.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/routes.dart';
import 'package:movie_search/ui/widgets/extensions.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sqlite3/open.dart';
import 'package:stacked/stacked.dart';

import 'data/moor_database.dart';
import 'modules/splash/splash_screen.dart';
import 'modules/themes/theme_viewmodel.dart';

final GlobalKey<ScaffoldState> drawerKey = new GlobalKey<ScaffoldState>();
final GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await initializeDateFormatting("es_ES", null);
  if (Platform.isWindows) {
    _configureSqliteOnWindows();
  } else if (Platform.isLinux) {
    _configureSqliteOnLinux();
  }
  final color = await _resolveColorSchema();
  SharedPreferencesHelper.wasHereBefore().then((value) => runApp(EasyDynamicThemeWidget(child: App(color: color))));
  await ContentTypeController.getInstance().loadCurrentType();
  _configureSingleton();
}

_configureSingleton() {
  final getIt = GetIt.instance;
  getIt.registerSingleton<HomeController>(HomeController());
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

class App extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();
  final FlexScheme color;

  App({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      maxTabletWidth: 720,
      builder: (context, orientation, screenType) => MultiProvider(
        providers: [
          Provider<MyDatabase>(
            create: (context) => MyDatabase(),
            dispose: (context, db) => db.close(),
          ),
          ChangeNotifierProvider<AccountViewModel>(create: (context) => AccountViewModel()..checkUserLogged()),
          ChangeNotifierProvider<FavouritesViewModel>(create: (context) => FavouritesViewModel()),
        ],
        child: ViewModelBuilder<ThemeViewModel>.reactive(
          viewModelBuilder: () => ThemeViewModel(
            color,
            themeMode: EasyDynamicTheme.of(context).themeMode ?? ThemeMode.system,
          ),
          builder: (context, model, child) => MaterialApp(
            title: 'Movie Search',
            debugShowCheckedModeBanner: false,
            theme: model.theme,
            darkTheme: model.darkTheme,
            themeMode: EasyDynamicTheme.of(context).themeMode,
            navigatorKey: globalNavigatorKey,
            onGenerateRoute: (settings) => Routes.generateRoute(context, settings),
            initialRoute: SplashScreen.route,
            scrollBehavior: MyCustomScrollBehavior(),
          ),
        ),
      ),
    );
  }
}
