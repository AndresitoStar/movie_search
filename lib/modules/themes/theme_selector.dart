import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/themes/theme_viewmodel.dart';
import 'package:provider/provider.dart';

class ThemeSelectorDialog extends StatelessWidget {
  static Future show(BuildContext context) {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => ThemeSelectorDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeViewModel viewModel = Provider.of(context);
    bool isDarkModeOn = Theme.of(context).brightness == Brightness.dark;
    return AlertDialog(
      title: Text('Color'),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 10),
      content: SingleChildScrollView(
        child: Column(
          children: [
            if (FlexScheme.values.isNotEmpty)
              Wrap(
                spacing: 5,
                runSpacing: 10,
                children: FlexScheme.values
                    .map((e) => FlexColor.schemes.containsKey(e)
                    ? ElevatedButton(
                  child: Text(''),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    primary: isDarkModeOn
                        ? FlexColor.schemes[e].dark.primary
                        : FlexColor.schemes[e].light.primary,
                  ),
                  onPressed: () {
                    viewModel.setColor(e);
                    Navigator.of(context).pop();
                  },
                )
                    : Container())
                    .toList(),
              )
          ],
        ),
      ),
    );
  }
}
