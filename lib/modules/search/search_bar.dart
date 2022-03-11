import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

import 'search_viewmodel.dart';

class SearchBar extends StatelessWidget {
  onLoad(SearchViewModel model) {
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(milliseconds: 500), () => model.queryControl.focus());
    });
  }

  @override
  Widget build(BuildContext context) {
    final landscape = MediaQuery.of(context).size.aspectRatio > 0.7;

    return ViewModelBuilder<SearchViewModel>.nonReactive(
      viewModelBuilder: () => context.read(),
      onModelReady: (model) => this.onLoad(model),
      fireOnModelReadyOnce: true,
      builder: (context, model, child) => Hero(
        tag: 'searchBar',
        child: Card(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          elevation: 1,
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
          child: ReactiveForm(
            formGroup: model.form,
            child: ReactiveTextField(
              formControl: model.queryControl,
              cursorColor: Theme.of(context).colorScheme.onBackground,
              autocorrect: false,
              style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                prefixIcon: Icon(MyIcons.search, size: 16),
                hintText: 'Buscar una película, serie, persona...',
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
