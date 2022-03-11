import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/themes/theme_viewmodel.dart';
import 'package:provider/provider.dart';

class ThemeSelectorDialog extends StatelessWidget {
  static Future show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => ThemeSelectorDialog(),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeViewModel viewModel = Provider.of(context);
    bool isDarkModeOn = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ListTile(
        title: Text.rich(
          TextSpan(
            text: 'Seleccione el color principal\n'.toUpperCase(),
            children: [
              TextSpan(
                text: 'Color Actual: ',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              TextSpan(
                text: FlexColor.schemes[viewModel.flexColor]!.name,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: isDarkModeOn
                          ? FlexColor.schemes[viewModel.flexColor]!.dark.primary
                          : FlexColor.schemes[viewModel.flexColor]!.light.primary,
                    ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Wrap(
            spacing: 14,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: FlexScheme.values
                .map((e) => FlexColor.schemes.containsKey(e)
                    ? InkWell(
                        onTap: () {
                          viewModel.setColor(e);
                          Navigator.of(context).pop();
                        },
                        child: Chip(
                          elevation: 2,
                          avatar: e == viewModel.flexColor
                              ? Icon(
                                  Icons.check_circle_rounded,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                )
                              : null,
                          label: Text(
                            FlexColor.schemes[e]!.name,
                            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                          ),
                          backgroundColor:
                              isDarkModeOn ? FlexColor.schemes[e]!.dark.primary : FlexColor.schemes[e]!.light.primary,
                        ),
                      )
                    : Container())
                .toList(),
          ),
        ),
      ),
    );
    return Column(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [],
          ),
        ),
      ],
    );
  }
}
