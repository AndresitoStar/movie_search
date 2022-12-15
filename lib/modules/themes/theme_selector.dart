import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/themes/theme_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:provider/provider.dart';

class ThemeSelectorDialog extends StatelessWidget {
  static Future show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          color: Color.fromRGBO(0, 0, 0, 0.001),
          child: GestureDetector(
            onTap: () {},
            child: DraggableScrollableSheet(
              initialChildSize: 0.4,
              minChildSize: 0.2,
              maxChildSize: 0.75,
              builder: (_, controller) => Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(25.0),
                    topRight: const Radius.circular(25.0),
                  ),
                ),
                child: ThemeSelectorDialog(),
              ),
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeViewModel viewModel = Provider.of(context);
    bool isDarkModeOn = Theme.of(context).brightness == Brightness.dark;
    return ListView(
      padding: EdgeInsets.only(top: 20),
      children: [
        Text.rich(
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
        SizedBox(height: 20),
        SingleChildScrollView(
          padding: EdgeInsets.only(bottom: context.mq.size.height * 0.07, left: 10, right: 10),
          child: Wrap(
            spacing: 10,
            runSpacing: 14,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            children: FlexScheme.values
                .map((e) => FlexColor.schemes.containsKey(e)
                    ? InkWell(
                        onTap: () {
                          viewModel.setColor(e);
                          Navigator.of(context).pop();
                        },
                        child: CircleAvatar(
                          radius: 32,
                          child: e == viewModel.flexColor
                              ? Icon(Icons.check, color: Theme.of(context).colorScheme.onPrimary)
                              : null,
                          backgroundColor:
                              isDarkModeOn ? FlexColor.schemes[e]!.dark.primary : FlexColor.schemes[e]!.light.primary,
                        ),
                      )
                    : Container())
                .toList(),
          ),
        ),
      ],
    );
  }
}
