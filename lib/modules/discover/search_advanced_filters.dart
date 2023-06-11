import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/model/api/models/tv.dart';
import 'package:movie_search/modules/discover/discover_viewmodel.dart';
import 'package:movie_search/modules/search/search_category.dart';
import 'package:movie_search/providers/util.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

class SearchAdvancedFilterView extends ViewModelWidget<DiscoverViewModel> {
  @override
  Widget build(BuildContext context, DiscoverViewModel model) {
    return SafeArea(
      child: Drawer(
        child: ReactiveForm(
          formGroup: model.form,
          child: Column(
            children: [
              SizedBox(height: 10),
              ReactiveFormField<SearchCategory, SearchCategory>(
                formControlName: DiscoverViewModel.FORM_TYPE,
                builder: (field) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: SearchCategory.getAll()
                        .map(
                          (e) => Expanded(
                            child: Material(
                              borderOnForeground: true,
                              color: e == model.actualCategory
                                  ? context.theme.colorScheme.secondary
                                  : context.theme.chipTheme.backgroundColor,
                              shape: RoundedRectangleBorder(side: BorderSide.none),
                              child: InkWell(
                                mouseCursor: SystemMouseCursors.click,
                                onTap: () => field.control.updateValue(e, emitEvent: true),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  child: Text(
                                    e.label,
                                    textAlign: TextAlign.center,
                                    style: context.theme.chipTheme.labelStyle!.copyWith(
                                      color: e == model.actualCategory
                                          ? context.theme.colorScheme.onPrimary
                                          : context.theme.chipTheme.labelStyle!.color,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              Divider(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ReactiveValueListenableBuilder(
                        formControlName: DiscoverViewModel.FORM_TYPE,
                        builder: (context, typeControl, _) =>
                            ReactiveFormField<Set<GenreTableData>, Set<GenreTableData>>(
                          formControlName: DiscoverViewModel.FORM_GENRE,
                          builder: (field) => Theme(
                            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTileCard(
                              title: Text('Generos ${field.value!.length > 0 ? '(${field.value!.length})' : ''}'),
                              elevation: 0,
                              baseColor: context.theme.colorScheme.background.withOpacity(0.05),
                              expandedColor: context.theme.colorScheme.background.withOpacity(0.5),
                              borderRadius: BorderRadius.zero,
                              children: [
                                Wrap(
                                  spacing: 10,
                                  alignment: WrapAlignment.start,
                                  children: model.allFilterGenres
                                      .map(
                                        (e) => GestureDetector(
                                          onTap: () => model.toggleGenreFilter(e),
                                          child: Chip(
                                            elevation: 0,
                                            deleteIcon: Icon(Icons.clear),
                                            side: field.value!.contains(e)
                                                ? BorderSide(
                                                    color: context.theme.chipTheme.labelStyle!.color!.withOpacity(0.7),
                                                  )
                                                : BorderSide(
                                                    color: context.theme.chipTheme.labelStyle!.color!.withOpacity(0.2)),
                                            backgroundColor: field.value!.contains(e)
                                                ? context.theme.colorScheme.secondary
                                                : context.theme.chipTheme.backgroundColor,
                                            label: Text(
                                              e.name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: context.theme.chipTheme.labelStyle!.copyWith(
                                                color: field.value!.contains(e)
                                                    ? context.theme.colorScheme.onPrimary
                                                    : context.theme.chipTheme.labelStyle!.color,
                                                fontWeight:
                                                    field.value!.contains(e) ? FontWeight.bold : FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(),
                      ReactiveValueListenableBuilder(
                        formControlName: DiscoverViewModel.FORM_TYPE,
                        builder: (context, typeControl, _) => ReactiveFormField<WatchProvider, WatchProvider>(
                          formControlName: DiscoverViewModel.FORM_PROVIDERS,
                          builder: (field) => Theme(
                            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTileCard(
                              title: Text('Donde verlo...'),
                              elevation: 0,
                              baseColor: context.theme.colorScheme.background.withOpacity(0.05),
                              expandedColor: context.theme.colorScheme.background.withOpacity(0.5),
                              borderRadius: BorderRadius.zero,
                              children: [
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: model.watchProviders
                                      .map(
                                        (e) => GestureDetector(
                                          onTap: () => model.toggleProvider(e),
                                          child: Card(
                                            color: e == field.value
                                                ? context.theme.colorScheme.tertiary
                                                : context.theme.chipTheme.backgroundColor,
                                            elevation: 0,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  clipBehavior: Clip.hardEdge,
                                                  margin: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl: '$URL_IMAGE_MEDIUM${e.logoPath}',
                                                    width: 40,
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 3, vertical: 8),
                                                  width: 86,
                                                  child: Text(
                                                    e.providerName ?? '${e.providerId}',
                                                    overflow: TextOverflow.fade,
                                                    textWidthBasis: TextWidthBasis.parent,
                                                    textAlign: TextAlign.center,
                                                    style: context.theme.chipTheme.labelStyle!.copyWith(
                                                      color: e == field.value
                                                          ? context.theme.colorScheme.onTertiary
                                                          : context.theme.chipTheme.labelStyle!.color,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
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
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  model.search();
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.check),
                label: Text("Listo"),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
