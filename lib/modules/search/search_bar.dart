import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      builder: (context, model, child) => Card(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        clipBehavior: Clip.hardEdge,
        elevation: 0,
        color: Theme.of(context).cardColor.withOpacity(0.28),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ReactiveForm(
          formGroup: model.form,
          child: Row(
            children: [
              IconButton(
                onPressed: () => null,
                icon: Icon(MyIcons.search),
                iconSize: 20,
              ),
              Expanded(
                child: ReactiveTextField(
                  formControl: model.queryControl,
                  decoration: InputDecoration(
                    hintText: 'Buscar...',
                    hintStyle: TextStyle(fontSize: 20),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(MyIcons.clear),
                          onPressed: () => model.queryControl.reset(),
                        ),
                        ReactiveFormField<SearchCategory>(
                          formControl: model.categoryControl,
                          builder: (field) => PopupMenuButton<SearchCategory>(
                              icon: Icon(Icons.filter_alt,
                                  color: field.value.value != null
                                      ? Theme.of(context).accentColor
                                      : Theme.of(context).iconTheme.color),
                              initialValue: model.actualCategory,
                              onSelected: (category) => field.control
                                  .updateValue(category, emitEvent: true),
                              offset: Offset(0, 100),
                              itemBuilder: (context) => SearchCategory.getAll()
                                  .map((e) => PopupMenuItem<SearchCategory>(
                                      child: Text(e.label ?? e.value ?? '-'),
                                      value: e))
                                  .toList()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
