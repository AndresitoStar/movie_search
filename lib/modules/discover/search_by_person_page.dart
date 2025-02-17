import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_main_image.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/search/search_bar.dart' as sb;
import 'package:movie_search/modules/search/search_service.dart';
import 'package:movie_search/modules/search/search_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

class SearchPersonListPage extends StatelessWidget {
  SearchPersonListPage({super.key, required Set<BaseSearchResult> cast}) {
    castControl = FormControl<Set<BaseSearchResult>>(value: cast);
  }

  static String routeName = "/search/person";

  late FormControl<Set<BaseSearchResult>> castControl;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context, castControl.value);
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cast by:'),
        ),
        body: ViewModelBuilder<SearchViewModel>.reactive(
            viewModelBuilder: () => SearchViewModel(
                  SearchService(type: TMDB_API_TYPE.PERSON.type),
                  context.read(),
                ),
            builder: (context, model, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  sb.SearchBar(hint: 'Buscar personas...'),
                  ReactiveFormField<Set<BaseSearchResult>,
                      Set<BaseSearchResult>>(
                    formControl: castControl,
                    builder: (field) => AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      color:
                          context.theme.colorScheme.onSurface.withOpacity(0.05),
                      margin: EdgeInsets.only(
                          bottom: castControl.value!.isEmpty ? 0 : 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Wrap(
                        spacing: 5,
                        children: castControl.value!
                            .map(
                              (e) => Chip(
                                label: Text(e.title ?? '-'),
                                onDeleted: () {
                                  field.value!.remove(e);
                                  field.control.updateValueAndValidity();
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  ReactiveFormField<Set<BaseSearchResult>,
                      Set<BaseSearchResult>>(
                    formControl: castControl,
                    builder: (field) => Expanded(
                      child: LayoutBuilder(builder: (context, constraints) {
                        int columns = (constraints.maxWidth ~/ 150).clamp(2, 6);

                        return ViewModelBuilder<SearchViewModel>.reactive(
                          viewModelBuilder: () => context.read(),
                          builder: (context, model, child) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: model.isBusy
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : model.searchResults.isEmpty
                                    ? Center(child: Text('Sin resultados'))
                                    : GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onPanDown: (_) => FocusScope.of(context)
                                            .requestFocus(FocusNode()),
                                        child: Scrollbar(
                                          child: GridView.builder(
                                            itemCount:
                                                model.searchResults.length +
                                                    columns,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: columns,
                                              childAspectRatio: 9 / 16,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                            ),
                                            padding: EdgeInsets.zero,
                                            physics: BouncingScrollPhysics(),
                                            itemBuilder: (ctx, i) => i <
                                                    model.searchResults.length
                                                ? Builder(builder: (context) {
                                                    final item =
                                                        model.searchResults[i];
                                                    return GestureDetector(
                                                      onTap: () {
                                                        field.value!.add(item);
                                                        field.control
                                                            .updateValueAndValidity();
                                                      },
                                                      child: Card(
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        elevation: 5,
                                                        borderOnForeground:
                                                            true,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          side: field.value!
                                                                  .contains(
                                                                      item)
                                                              ? BorderSide(
                                                                  color: context
                                                                      .theme
                                                                      .colorScheme
                                                                      .primary,
                                                                  width: 5,
                                                                )
                                                              : BorderSide.none,
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  ContentImageWidget(
                                                                item.posterImage,
                                                                ignorePointer:
                                                                    true,
                                                              ),
                                                            ),
                                                            ListTile(
                                                              title: Text(
                                                                  item.title ??
                                                                      '-'),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  })
                                                : model.hasMore
                                                    ? GridItemPlaceholder()
                                                    : Container(),
                                          ),
                                        ),
                                      ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
