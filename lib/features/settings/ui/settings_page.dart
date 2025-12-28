import 'package:day_night_themed_switch/day_night_themed_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search/common/provider/theme_provider.dart';
import 'package:movie_search/common/ui/icons.dart';
import 'package:movie_search/common/ui/scaffold.dart';

class SettingsPage extends StatelessWidget {
  static String routeName = "/settings";

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomBarIndex: 3,
      appBar: CustomScaffoldAppbar(
        bottomBarIndex: 3,
      ),
      // appBar: AppBar(
      //   title: Text('Acerca de'),
      //   forceMaterialTransparency: true,
      //   leading: IconButton(
      //     icon: Icon(MyIcons.arrow_left),
      //     onPressed: () => context.pop(),
      //   ),
      //   titleSpacing: 0,
      //   elevation: 0,
      // ),
      body: Center(child: _getInfo(context, 'Movie Search', '1.0.0')),
      forceAppbar: true,
    );
  }

  _getInfo(BuildContext context, String appName, String version) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: .center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/ic_launcher.png', width: 150, height: 150),
        SizedBox(height: 30),
        Text(
          appName,
          style: theme.textTheme.headlineMedium!.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
        // IconButton(
        //   icon: Icon(Icons.color_lens_rounded),
        //   onPressed: () => ThemeSelectorDialog.show(context),
        // ),
        SizedBox(height: 10),
        MyThemeBtn(),
        SizedBox(height: 30),
        Text(
          'Made by',
          style: theme.textTheme.titleSmall!.copyWith(color: theme.hintColor),
        ),
        Text('Andrés Forns Jusino', style: theme.textTheme.titleLarge),
        SizedBox(height: 30),
        Text(
          'Version',
          style: theme.textTheme.titleSmall!.copyWith(color: theme.hintColor),
        ),
        Text(version, style: theme.textTheme.titleLarge),
      ],
    );
  }
}

class MyThemeBtn extends ConsumerWidget {
  const MyThemeBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProviderProvider);
    return Column(
      children: [
        SizedBox(
          width: 100,
          height: 75,
          child: DayNightSwitch(
            value: theme.value == ThemeMode.dark,
            onChanged: (_) {
              ref.read(themeProviderProvider.notifier).switchThemeMode();
            },
          ),
        ),
      ],
    );
  }
}
