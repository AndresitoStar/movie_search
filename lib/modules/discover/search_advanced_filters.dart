import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        elevation: 0,
        child: ReactiveForm(
          formGroup: model.form,
          child: Column(
            children: [
              SizedBox(height: 10),
              ReactiveFormField<SearchCategory, SearchCategory>(
                formControlName: DiscoverViewModel.FORM_TYPE,
                builder: (field) => Container(
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
                        builder: (context, typeControl, _) => ReactiveFormField<Set<WatchProvider>, Set<WatchProvider>>(
                          formControlName: DiscoverViewModel.FORM_PROVIDERS,
                          builder: (field) => Theme(
                            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTileCard(
                              title: Text('Donde verlo...'),
                              subtitle: field.value!.isNotEmpty
                                  ? Wrap(
                                      spacing: 5,
                                      children: field.value!
                                          .map((e) => Chip(
                                                label: Text(e.providerName!, style: context.theme.textTheme.bodyMedium),
                                                side: BorderSide(color: context.theme.disabledColor),
                                                backgroundColor: context.theme.colorScheme.background,
                                                deleteIcon: Icon(Icons.clear, size: 12),
                                                onDeleted: () => model.toggleProvider(e),
                                                deleteIconColor: context.theme.colorScheme.onBackground,
                                              ))
                                          .toList(),
                                    )
                                  : null,
                              elevation: 0,
                              baseColor: context.theme.colorScheme.background.withOpacity(0.05),
                              expandedColor: context.theme.colorScheme.background.withOpacity(0.5),
                              borderRadius: BorderRadius.zero,
                              children: ListTile.divideTiles(
                                color: context.theme.dividerColor,
                                context: context,
                                tiles: model.watchProviders
                                    .map(
                                      (e) => ListTile(
                                        onTap: () => model.toggleProvider(e),
                                        // tileColor: field.value!.contains(e)
                                        // ? context.theme.colorScheme.tertiary
                                        // : context.theme.colorScheme.background,
                                        leading: Container(
                                          clipBehavior: Clip.hardEdge,
                                          margin: EdgeInsets.all(1),
                                          decoration: BoxDecoration(shape: BoxShape.circle),
                                          height: 32,
                                          width: 32,
                                          child: CachedNetworkImage(imageUrl: '$URL_IMAGE_MEDIUM${e.logoPath}'),
                                        ),
                                        trailing: field.value!.contains(e)
                                            ? Icon(
                                                FontAwesomeIcons.check,
                                                color: context.theme.colorScheme.tertiary,
                                              )
                                            : null,
                                        title: Text(
                                          e.providerName ?? '${e.providerId}',
                                          overflow: TextOverflow.fade,
                                          textWidthBasis: TextWidthBasis.parent,
                                          // textAlign: TextAlign.center,
                                          style: context.theme.chipTheme.labelStyle!.copyWith(
                                            color: field.value!.contains(e)
                                                ? context.theme.colorScheme.primary
                                                : context.theme.chipTheme.labelStyle!.color,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ).toList(),
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
