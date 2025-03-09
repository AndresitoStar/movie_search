import 'package:flutter/cupertino.dart';
import 'package:movie_search/providers/util.dart';
import 'package:reactive_forms/reactive_forms.dart';

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
          // if (tabs.length > 1)
          //   if (Device.screenType != ScreenType.mobile) Text('asd') else Text('sda'),
          OverflowBar(
            alignment: MainAxisAlignment.spaceEvenly,
            overflowAlignment: OverflowBarAlignment.end,
            overflowSpacing: 10,
            children: [
              if (title != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(title!, style: context.theme.textTheme.headlineMedium),
                ),
              if (tabs.length > 1) _buildSegmentedControl(control, context),
            ],
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
