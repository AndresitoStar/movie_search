import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/ui/app_theme.dart';
import 'package:movie_search/ui/pages/dashboard.dart';
import 'package:provider/provider.dart';

import 'data/moor_database.dart';
import 'ui/screens/onboard.dart';

void main() => runApp(EasyDynamicThemeWidget(child: App(showOnboard: false)));

class App extends StatelessWidget {
  final bool showOnboard;
  const App({Key key, @required this.showOnboard}) : super(key: key);

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
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: EasyDynamicTheme.of(context).themeMode,
        home: showOnboard ? OnboardScreen() : Dashboard(),
      ),
    );
  }
}
