import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/themes/theme_viewmodel.dart';
import 'package:provider/provider.dart';

class ThemeSelectorDialog extends StatelessWidget {
  static Future show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.9,
        child: ThemeSelectorDialog(),
      ),
      isDismissible: true,
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeViewModel viewModel = Provider.of(context);
    bool isDarkModeOn = Theme.of(context).brightness == Brightness.dark;
    final colors = FlexScheme.values.where((e) => FlexColor.schemes.containsKey(e)).toList();
    // final ItemScrollController itemScrollController = ItemScrollController();
    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    //   final int index = colors.indexWhere((element) => viewModel.flexColor == element);
    //   if (index > -1) Future.delayed(Duration(milliseconds: 500), () => itemScrollController.jumpTo(index: index));
    // });

    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20),
          Text.rich(
            TextSpan(
              text: 'Seleccione el color principal\n'.toUpperCase(),
              children: [
                TextSpan(
                  text: 'Color Actual: ',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                TextSpan(
                  text: FlexColor.schemes[viewModel.flexColor]!.name,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDarkModeOn
                            ? FlexColor.schemes[viewModel.flexColor]!.dark.primary
                            : FlexColor.schemes[viewModel.flexColor]!.light.primary,
                      ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: GridView.builder(
                itemCount: colors.length,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _getColumns(context),
                  childAspectRatio: 1,
                  // crossAxisSpacing: 10,
                  // mainAxisSpacing: 10,
                ),
                itemBuilder: (context, i) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(32),
                    onTap: () {
                      viewModel.setColor(colors[i]);
                      // Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      radius: 32,
                      child: colors[i] == viewModel.flexColor
                          ? Icon(Icons.check, color: Theme.of(context).colorScheme.onPrimary)
                          : null,
                      backgroundColor: isDarkModeOn
                          ? FlexColor.schemes[colors[i]]!.dark.primary
                          : FlexColor.schemes[colors[i]]!.light.primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _getColumns(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return (width ~/ 64).clamp(3, 6);
  }
}
