import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:movie_search/app.dart';
import 'package:movie_search/core/di/injection.dart';
import 'package:movie_search/firebase_options.dart';

void main() async {
  await initialize();
  runApp(const ProviderScope(child: MyApp()));
}

Future<void> initialize() async {
  //! Binding
  WidgetsFlutterBinding.ensureInitialized();

  //! Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //! Localization
  await initializeDateFormatting('es_ES', null); // Cambia 'es' por el locale que necesites

  //! Dependence injection
  await configureDependencies();
}
