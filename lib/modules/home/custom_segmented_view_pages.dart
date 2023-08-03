import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/providers/util.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomSegmentedPageView extends StatelessWidget {
  final List<Widget> pages;
  final List<String> tabs;
  final FormControl<int> _indexSelectedFormControl = fb.control(0);
  final String? title;

  CustomSegmentedPageView({Key? key, required this.pages, required this.tabs, this.title})
      : assert(pages.length == tabs.length),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveValueListenableBuilder<int>(
      formControl: _indexSelectedFormControl,
      builder: (context, control, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: title != null ? Text(title!) : null,
            titleTextStyle: context.theme.textTheme.headlineMedium,
            trailing: tabs.length > 1 && Device.screenType != ScreenType.mobile
                ? _buildSegmentedControl(control, context)
                : null,
            subtitle: tabs.length > 1 && Device.screenType == ScreenType.mobile
                ? _buildSegmentedControl(control, context)
                : null,
          ),
          Container(
            child: pages[control.value ?? 0],
            padding: EdgeInsets.symmetric(horizontal: 16.0),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentedControl(AbstractControl<int> control, BuildContext context) {
    return CupertinoSegmentedControl<int>(
      children: Map<int, Widget>.fromIterable(
        tabs,
        key: (k) => tabs.indexOf(k),
        value: (k) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(tabs[tabs.indexOf(k)].toUpperCase()),
        ),
      ),
      onValueChanged: (v) => control.updateValue(v),
      groupValue: control.value,
      unselectedColor: context.theme.colorScheme.background,
    );
  }
}
