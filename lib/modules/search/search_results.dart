import 'package:flutter/material.dart';
import 'package:movie_search/modules/search/search_category.dart';
import 'package:movie_search/modules/search/search_history.dart';
import 'package:movie_search/modules/search/search_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

import 'search_result_list_item.dart';

class SearchResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.nonReactive(
      viewModelBuilder: () => context.read(),
      builder: (context, model, child) => Container(
        child: Column(
          children: [
            ReactiveForm(
              formGroup: model.form,
              child: AnimatedContainer(
                height: model.showFilter ? kToolbarHeight - 10 : 0,
                duration: Duration(milliseconds: 400),
                curve: Curves.fastOutSlowIn,
                color: Theme.of(context).colorScheme.secondary,
                child: ReactiveForm(
                  formGroup: model.form,
                  child: ReactiveFormField<SearchCategory, SearchCategory>(
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
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(15),
                                    mouseCursor: SystemMouseCursors.click,
                                    onTap: () => field.control.updateValue(e, emitEvent: true),
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: e == model.actualCategory ? Colors.white54 : Colors.white12,
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Text(
                                          e.label ?? e.value ?? '-',
                                          style: TextStyle(
                                            fontWeight: e == model.actualCategory ? FontWeight.w700 : FontWeight.normal,
                                            color: e == model.actualCategory ? Colors.black87 : Colors.white,
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
            ),
            Expanded(
              child: model.isBusy
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : model.searchResults.isEmpty && model.queryControl.value != null && model.queryControl.isNullOrEmpty
                      ? SearchHistoryView(onTap: (value) => model.queryControl.value = value)
                      : model.searchResults.isEmpty
                          ? Center(child: Text('Sin resultados'))
                          : GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onPanDown: (_) => FocusScope.of(context).requestFocus(FocusNode()),
                              child: Scrollbar(
                                child: GridView.builder(
                                    itemCount: model.searchResults.length + 1,
                                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                        // crossAxisCount: getColumns(context),
                                        maxCrossAxisExtent: 600,
                                        mainAxisExtent: 150,
                                        childAspectRatio: MediaQuery.of(context).size.width /
                                            (MediaQuery.of(context).size.height / 4),
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10),
                                    padding: EdgeInsets.zero,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (ctx, i) => i < model.searchResults.length
                                        ? SearchResultListItem(
                                            searchResult: model.searchResults[i],
                                            searchCriteria: model.queryControl.value,
                                          )
                                        : model.hasMore
                                            ? Builder(
                                                builder: (context) {
                                                  model.fetchMore(context);
                                                  return SizedBox(
                                                    height: 10,
                                                    child: LinearProgressIndicator(),
                                                  );
                                                },
                                              )
                                            : Container()),
                              ),
                            ),
            ),
          ],
        ),
      ),
    );
  }

  int getColumns(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    int columns = 1;

    if (width > 750) {
      columns = 2;
    }
    return columns;
  }
}
