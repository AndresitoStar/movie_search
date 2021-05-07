import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:movie_search/modules/search/search_category.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';

import 'search_viewmodel.dart';

class SearchBar extends StatelessWidget {
  onLoad(SearchViewModel model) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      model.queryControl.focus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.nonReactive(
      viewModelBuilder: () => context.read(),
      onModelReady: (model) => this.onLoad(model),
      builder: (context, model, child) => AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: kToolbarHeight + 10,
        titleSpacing: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: ReactiveForm(
          formGroup: model.form,
          child: Container(
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ReactiveTextField(
              formControl: model.queryControl,
              cursorColor: Colors.white,
              autocorrect: false,
              style: TextStyle(fontSize: 20, color: Colors.white70),
              decoration: InputDecoration(
                prefix: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    MyIcons.search,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                hintText: 'Buscar...',
                hintStyle: TextStyle(fontSize: 20, color: Colors.white38),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(MyIcons.clear),
                      color: Theme.of(context).iconTheme.color,
                      onPressed: () => model.queryControl.reset(value: ''),
                    ),
                    IconButton(
                      icon: Icon(Icons.filter_alt),
                      color: Theme.of(context).iconTheme.color,
                      onPressed: () => model.toggleFilter(),
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
