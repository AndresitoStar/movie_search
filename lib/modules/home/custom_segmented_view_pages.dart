import 'package:flutter/cupertino.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:movie_search/providers/util.dart';

class CustomSegmentedPageView extends StatelessWidget {
  final List<Widget> pages;
  final List<String> tabs;
  final FormControl<int> _indexSelectedFormControl = fb.control(0);

  CustomSegmentedPageView({Key? key, required this.pages, required this.tabs})
      : assert(pages.length == tabs.length),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveValueListenableBuilder<int>(
      formControl: _indexSelectedFormControl,
      builder: (context, control, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: CupertinoSegmentedControl<int>(
              children: Map<int, Widget>.fromIterable(
                tabs,
                key: (k) => tabs.indexOf(k),
                value: (k) => Text(
                  tabs[tabs.indexOf(k)].toUpperCase(),
                ),
              ),
              onValueChanged: (v) => control.updateValue(v),
              groupValue: control.value,
              unselectedColor: context.theme.backgroundColor,
            ),
          ),
          Container(
            child: pages[control.value ?? 0],
            padding: EdgeInsets.symmetric(horizontal: 16.0),
          ),
        ],
      ),
    );
  }
}
