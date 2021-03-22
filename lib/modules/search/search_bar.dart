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
      builder: (context, model, child) => Card(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        clipBehavior: Clip.hardEdge,
        elevation: 0,
        color: Theme.of(context).cardColor.withOpacity(0.28),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ReactiveForm(
          formGroup: model.form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => null,
                    icon: Icon(MyIcons.search),
                    iconSize: 20,
                  ),
                  Expanded(
                    child: ReactiveTextField(
                      formControl: model.queryControl,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintText: 'Buscar...',
                        hintStyle: TextStyle(fontSize: 20),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(MyIcons.clear),
                              onPressed: () =>
                                  model.queryControl.reset(value: ''),
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
                ],
              ),
              AnimatedContainer(
                height: model.showFilter ? kToolbarHeight - 10 : 0,
                duration: Duration(milliseconds: 400),
                curve: Curves.fastOutSlowIn,
                child: ReactiveForm(
                  formGroup: model.form,
                  child: ReactiveFormField<SearchCategory>(
                    formControl: model.categoryControl,
                    builder: (field) => Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: SearchCategory.getAll()
                              .map(
                                (e) => Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(15),
                                    mouseCursor: SystemMouseCursors.click,
                                    onTap: () => field.control
                                        .updateValue(e, emitEvent: true),
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: e == model.actualCategory
                                              ? Theme.of(context).accentColor
                                              : Colors.white24,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Text(
                                          e.label ?? e.value ?? '-',
                                          style: TextStyle(
                                            fontWeight: e == model.actualCategory
                                              ? FontWeight.w700
                                              : FontWeight.normal,
                                            color: e == model.actualCategory
                                              ? Colors.black87
                                              : Colors.white,
                                          ),
                                        )),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
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
