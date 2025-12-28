import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search/common/provider/theme_provider.dart';
import 'package:movie_search/core/theme/themes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'core/router.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(approuterProvider);
    final theme = ref.watch(themeProviderProvider);

    return ResponsiveSizer(
      maxTabletWidth: 720,
      builder: (_, __, ___) => MaterialApp.router(
        title: 'Media Guide',
        scaffoldMessengerKey: AppNotificationsService.scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: Themes().theme,
        darkTheme: Themes().darkTheme,
        themeMode: theme.when(
          data: (data) {
            switch (data) {
              case ThemeMode.light:
                return ThemeMode.light;
              case ThemeMode.dark:
                return ThemeMode.dark;
              default:
                return ThemeMode.system;
            }
          },
          loading: () => ThemeMode.system,
          error: (_, __) => ThemeMode.system,
        ),
      ),
    );
  }
}
