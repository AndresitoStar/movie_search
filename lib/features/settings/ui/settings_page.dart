import 'package:day_night_themed_switch/day_night_themed_switch.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:movie_search/common/model/country.dart';
import 'package:movie_search/common/provider/theme_provider.dart';
import 'package:movie_search/common/ui/scaffold.dart';
import 'package:movie_search/common/ui/square_avatar.dart';
import 'package:movie_search/common/ui/utils.dart';
import 'package:movie_search/features/settings/provider/south_american_countries_provider.dart';
import 'package:movie_search/features/settings/provider/version.dart';
import 'package:movie_search/features/user/provider/config_color.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SettingsPage extends ConsumerWidget {
  static String routeName = "/settings";

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      bottomBarIndex: 3,
      appBar: CustomScaffoldAppbar(bottomBarIndex: 3),
      body: context.isMobile
          ? Column(
              crossAxisAlignment: .center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_getAppInfoOne(context), SizedBox(height: 10), _getAppInfoTwo(context, ref)],
            )
          : Center(
              child: Row(
                children: [
                  Flexible(flex: 2, child: AspectRatio(aspectRatio: 1, child: _getAppInfoOne(context))),
                  SizedBox(width: 10),
                  Expanded(flex: 1, child: _getAppInfoTwo(context, ref)),
                ],
              ),
            ),
      forceAppbar: true,
    );
  }

  Widget _getAppInfoOne(BuildContext context) {
    if (context.isMobile) {
      return Image.asset('assets/images/ic_launcher.png', width: 50.w);
    }
    return Column(
      crossAxisAlignment: .center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: .min,
      children: [
        SizedBox(height: 20),
        Expanded(child: Image.asset('assets/images/ic_launcher.png', fit: BoxFit.cover)),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _getAppInfoTwo(BuildContext context, WidgetRef ref) {
    final versionInfo = ref.watch(appVersionProvider);
    return Column(
      crossAxisAlignment: .center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Movie Search', style: context.textTheme.headlineMedium!.copyWith(color: context.colors.primary)),
        Divider(),
        // ---------------- Settings ---------------
        MyThemeBtn(),
        _ColorSelectWidget(),
        _CountrySelectorWidget(),
        Divider(),
        // ---------------- App Info ---------------
        Text('Made by', style: context.textTheme.titleSmall!.copyWith(color: context.theme.hintColor)),
        Text('Andrés Forns Jusino', style: context.textTheme.titleLarge),
        Text('Version', style: context.textTheme.titleSmall!.copyWith(color: context.theme.hintColor)),
        versionInfo.when(data: (info) => Text(info.fullVersion), loading: () => Text('-'), error: (_, __) => Text('-')),
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
        Text('Theme', style: context.textTheme.titleSmall!.copyWith(color: context.theme.hintColor)),
        Text(theme.value == ThemeMode.dark ? 'Dark' : 'Light', style: context.textTheme.titleLarge),
        SizedBox(height: 10),
        SizedBox(
          height: 50,
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

class _ColorSelectWidget extends ConsumerWidget {
  const _ColorSelectWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorConfig = ref.watch(colorConfigProvider);
    Widget builder(BuildContext context, {ScrollController? controller}) {
      final availableColors = ref.read(colorConfigProvider.notifier).availableSchemes;
      // Ejemplo: Mostrar lista de colores
      return Material(
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(2.0),
              margin: .symmetric(horizontal: 10.w, vertical: 10),
              foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.colors.onPrimaryContainer,
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: .symmetric(horizontal: 16),
              child: Text('Select a Color Scheme', style: context.textTheme.headlineSmall),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: availableColors.length,
                separatorBuilder: (context, index) => Divider(),
                controller: controller,
                itemBuilder: (context, index) {
                  final scheme = availableColors[index];
                  return _ColorListTile(
                    scheme: scheme,
                    onTap: () async {
                      await ref.read(colorConfigProvider.notifier).setColorScheme(scheme);
                      context.pop();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    return colorConfig.maybeWhen(
      orElse: () => Container(),
      data: (data) => SizedBox(
        width: _colorListTileWidth,
        child: _ColorListTile(
          scheme: data,
          compact: true,
          onTap: () {
            if (context.isMobile) {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                useSafeArea: true,
                builder: (context) => DraggableScrollableSheet(
                  initialChildSize: 0.8,
                  minChildSize: 0.4,
                  maxChildSize: 1.0,
                  expand: false,
                  builder: (context, scrollController) {
                    return Container(
                      decoration: BoxDecoration(
                        color: context.theme.cardColor,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      child: builder(context, controller: scrollController),
                    );
                  },
                ),
              );
              return;
            }
            showBlurDialog(
              context: context,
              child: Dialog(
                constraints: BoxConstraints(maxHeight: 75.h, maxWidth: _colorListTileWidth),
                child: Builder(builder: builder),
              ),
            );
          },
        ),
      ),
    );
  }
}

final double _colorListTileWidth = 620.0;

class _ColorListTile extends StatelessWidget {
  final FlexScheme scheme;
  final VoidCallback onTap;
  final bool compact;

  const _ColorListTile({super.key, required this.scheme, required this.onTap, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final row = Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 3,
      children: [
        SquareAvatar(backgroundColor: scheme.colors(context.theme.brightness).primary),
        SquareAvatar(backgroundColor: scheme.colors(context.theme.brightness).secondary),
        SquareAvatar(backgroundColor: scheme.colors(context.theme.brightness).tertiary),
      ],
    );
    if (compact) {
      return Row(
        children: [
          Spacer(),
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Color', style: context.textTheme.titleSmall!.copyWith(color: context.theme.hintColor)),
                  Text(scheme.data.name.capitalize, style: context.textTheme.titleLarge),
                  SizedBox(height: 8),
                  row,
                ],
              ),
            ),
          ),
          Spacer(),
        ],
      );
    }
    return ListTile(
      title: Text(scheme.data.name.capitalize),
      subtitle: Text(scheme.data.description.capitalize),
      trailing: row,
      onTap: onTap,
    );
  }
}

class _CountrySelectorWidget extends ConsumerWidget {
  const _CountrySelectorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCountry = ref.watch(selectedCountryProvider);
    return InkWell(
      onTap: () async {
        final country = await ref.read(selectedCountryProvider.future);
        if (context.mounted) {
          _showCountrySelector(context, ref, country);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Pais',
            style: context.textTheme.titleSmall!.copyWith(color: context.theme.hintColor),
            textAlign: TextAlign.center,
          ),
          Text(
            selectedCountry.maybeWhen(orElse: () => 'Select a country', data: (c) => c.name),
            style: context.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  _showCountrySelector(BuildContext context, WidgetRef ref, Country selectedCountry) {
    final countries = ref.watch(southAmericanCountriesProvider);
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return countries.maybeWhen(
          orElse: () => Container(),
          data: (countries) {
            final initialIndex = countries.indexWhere((c) => c.iso31661 == selectedCountry.iso31661);
            final scrollController = ScrollController(
              initialScrollOffset: initialIndex * 72.0,
            ); // Asumiendo que cada ListTile tiene una altura de 72
            return ListView.builder(
              controller: scrollController,
              itemCount: countries.length,
              itemBuilder: (context, index) {
                final country = countries[index];
                return ListTile(
                  title: Text(country.name),
                  selected: country.iso31661 == selectedCountry.iso31661,
                  selectedTileColor: context.colors.primary.withOpacity(0.2),
                  onTap: () {
                    ref.read(selectedCountryProvider.notifier).setSelectedCountry(country);
                    context.pop();
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
