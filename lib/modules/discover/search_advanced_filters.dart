import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/model/api/models/tv.dart';
import 'package:movie_search/modules/discover/discover_viewmodel.dart';
import 'package:movie_search/modules/search/search_category.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/widgets/advanced_expansion_tile.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

class SearchAdvancedFilterView extends ViewModelWidget<DiscoverViewModel> {
  const SearchAdvancedFilterView(this.expansionTitleGlobalKey, {Key? key}) : super(key: key);

  final GlobalKey<ConfigurableExpansionTileState> expansionTitleGlobalKey;

  @override
  Widget build(BuildContext context, DiscoverViewModel model) {
    final GlobalKey<ConfigurableExpansionTileState> expansionTitleGlobalKeya = GlobalKey();
    return ReactiveForm(
      formGroup: model.form,
      child: ConfigurableExpansionTile(
        key: expansionTitleGlobalKeya,
        kExpand: Duration(milliseconds: 500),
        header: Container(
          width: context.mq.size.width,
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            elevation: 0,
            color: context.theme.inputDecorationTheme.fillColor,
            child: ListTile(
              title: Text('Filtros', style: context.theme.textTheme.titleLarge),
              subtitle: Text(model.filterText, style: context.theme.textTheme.subtitle1),
              trailing: Icon(FontAwesomeIcons.filter, color: Theme.of(context).primaryColor),
            ),
          ),
        ),
        headerExpanded: Container(),
        initiallyExpanded: model.showFilterExpansion,
        onExpansionChanged: (v) => model.toggleFilterExpansion(),
        topBorderOn: true,
        childrenBody: Container(
          height: MediaQuery.of(context).size.height -
              kToolbarHeight -
              kBottomNavigationBarHeight -
              50 -
              (Platform.isIOS ? 60 : 0),
          child: Card(
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            elevation: 0,
            color: context.theme.inputDecorationTheme.fillColor,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        ReactiveFormField<SearchCategory, SearchCategory>(
                          formControlName: DiscoverViewModel.FORM_TYPE,
                          builder: (field) => Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: SearchCategory.getAll()
                                .map(
                                  (e) => InkWell(
                                    borderRadius: BorderRadius.circular(15),
                                    mouseCursor: SystemMouseCursors.click,
                                    onTap: () => field.control.updateValue(e, emitEvent: true),
                                    child: Chip(
                                      elevation: 0,
                                      backgroundColor: e == model.actualCategory
                                          ? context.theme.colorScheme.secondary
                                          : context.theme.chipTheme.backgroundColor,
                                      label: Text(
                                        e.label,
                                        style: context.theme.chipTheme.labelStyle!.copyWith(
                                          color: e == model.actualCategory
                                              ? context.theme.colorScheme.onPrimary
                                              : context.theme.chipTheme.labelStyle!.color,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        Divider(endIndent: 20, indent: 20),
                        ReactiveValueListenableBuilder(
                          formControlName: DiscoverViewModel.FORM_TYPE,
                          builder: (context, typeControl, _) =>
                              ReactiveFormField<Set<GenreTableData>, Set<GenreTableData>>(
                            formControlName: DiscoverViewModel.FORM_GENRE,
                            builder: (field) => Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                initiallyExpanded: true,
                                title: Text('Generos ${field.value!.length > 0 ? '(${field.value!.length})' : ''}'),
                                children: [
                                  Card(
                                    elevation: 0,
                                    color: context.theme.backgroundColor.withOpacity(0.5),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Wrap(
                                        spacing: 10,
                                        alignment: WrapAlignment.center,
                                        children: model.allFilterGenres
                                            .map(
                                              (e) => GestureDetector(
                                                onTap: () => model.toggleGenreFilter(e),
                                                child: Chip(
                                                  elevation: 0,
                                                  backgroundColor: field.value!.contains(e)
                                                      ? context.theme.colorScheme.secondary
                                                      : context.theme.chipTheme.backgroundColor,
                                                  label: Text(
                                                    e.name,
                                                    style: context.theme.chipTheme.labelStyle!.copyWith(
                                                      color: field.value!.contains(e)
                                                          ? context.theme.colorScheme.onPrimary
                                                          : context.theme.chipTheme.labelStyle!.color,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ReactiveValueListenableBuilder(
                          formControlName: DiscoverViewModel.FORM_TYPE,
                          builder: (context, typeControl, _) => ReactiveFormField<WatchProvider, WatchProvider>(
                            formControlName: DiscoverViewModel.FORM_PROVIDERS,
                            builder: (field) => Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                initiallyExpanded: true,
                                title: Text('Donde verlo...'),
                                children: [
                                  Card(
                                    elevation: 0,
                                    color: context.theme.backgroundColor.withOpacity(0.5),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Wrap(
                                        spacing: 10,
                                        alignment: WrapAlignment.center,
                                        children: model.watchProviders
                                            .map(
                                              (e) => GestureDetector(
                                                onTap: () => model.toggleProvider(e),
                                                child: Chip(
                                                  elevation: 0,
                                                  avatar: Container(
                                                    clipBehavior: Clip.hardEdge,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: CachedNetworkImage(
                                                      imageUrl: '$URL_IMAGE_MEDIUM${e.logoPath}',
                                                      // width: 80,
                                                    ),
                                                  ),
                                                  backgroundColor: e == field.value
                                                      ? context.theme.colorScheme.secondary
                                                      : context.theme.chipTheme.backgroundColor,
                                                  label: Text(
                                                    e.providerName ?? '${e.providerId}',
                                                    style: context.theme.chipTheme.labelStyle!.copyWith(
                                                      color: e == field.value
                                                          ? context.theme.colorScheme.onPrimary
                                                          : context.theme.chipTheme.labelStyle!.color,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
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
                ListTile(
                  trailing: ElevatedButton(
                    child: Text('Buscar'),
                    onPressed: () {
                      model.toggleFilterExpansion();
                      model.search();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
