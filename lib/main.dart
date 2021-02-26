import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/routes.dart';
import 'package:movie_search/ui/dark.dart';
import 'package:movie_search/ui/light.dart';
import 'package:provider/provider.dart';

import 'data/moor_database.dart';
import 'firebase_service.dart';
import 'modules/splash/splash_screen.dart';
import 'ui/screens/onboard.dart';

void main() async {
  SharedPreferencesHelper.wasHereBefore().then((value) =>
      runApp(EasyDynamicThemeWidget(child: App(wasHereBefore: value))));
  await FirebaseService().initializeApp();
}

class App extends StatelessWidget {
  final bool wasHereBefore;

  const App({Key key, @required this.wasHereBefore}) : super(key: key);

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
        title: 'Melon App',
        debugShowCheckedModeBanner: false,
        theme: LightTheme.theme,
        darkTheme: DarkTheme.theme,
        themeMode: EasyDynamicTheme.of(context).themeMode,
        // routes: Routes.routes,
        onGenerateRoute: Routes.generateRoute,
        initialRoute:
            wasHereBefore ? SplashScreen.route : OnboardScreen.routeName,
      ),
    );
  }
}
