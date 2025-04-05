import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stacked/stacked.dart';

import 'search_viewmodel.dart';

class SearchBar extends StatelessWidget {
  onLoad(SearchViewModel model) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(
          Duration(milliseconds: 500), () => model.queryControl.focus());
    });
  }

  final String? hint;

  const SearchBar({super.key, this.hint});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.nonReactive(
      viewModelBuilder: () => context.read(),
      onViewModelReady: (model) => this.onLoad(model),
      fireOnViewModelReadyOnce: true,
      builder: (context, model, child) => Hero(
        tag: 'searchBar',
        child: Column(
          children: [
            Card(
              clipBehavior: Clip.hardEdge,
              margin: EdgeInsets.symmetric(
                  horizontal: Device.screenType == ScreenType.mobile ? 15 : 10.w),
              elevation: 0,
              color: Theme.of(context).inputDecorationTheme.fillColor,
              child: ReactiveForm(
                formGroup: model.form,
                child: ReactiveTextField(
                  formControl: model.queryControl,
                  cursorColor: Theme.of(context).colorScheme.onSurface,
                  autocorrect: false,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onSurface),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    prefixIcon: Icon(MyIcons.search, size: 16),
                    hintText: this.hint ?? 'Buscar una película, serie, persona...',
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(MyIcons.clear),
                          color: Theme.of(context).iconTheme.color,
                          onPressed: () => model.queryControl
                            ..reset(value: '')
                            ..focus(),
                        ),
                        IconButton(
                          icon: Icon(Icons.send),
                          color: Theme.of(context).iconTheme.color,
                          onPressed: () => model.search(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
