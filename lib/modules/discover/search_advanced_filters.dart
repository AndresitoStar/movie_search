import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/model/api/models/api.dart';
import 'package:movie_search/model/api/models/tv.dart';
import 'package:movie_search/modules/discover/discover_viewmodel.dart';
import 'package:movie_search/modules/search/search_category.dart';
import 'package:movie_search/providers/util.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

class SearchAdvancedFilterView extends ViewModelWidget<DiscoverViewModel> {
  final _keySortOrderCard = GlobalKey<ExpansionTileCardState>();

  @override
  Widget build(BuildContext context, DiscoverViewModel model) {
    return SafeArea(
      child: Drawer(
        elevation: 0,
        child: ReactiveForm(
          formGroup: model.form,
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.zero,
                elevation: 10,
                borderOnForeground: true,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
                child: Column(
                  children: [
                    ReactiveFormField<SearchCategory, SearchCategory>(
                      formControlName: DiscoverViewModel.FORM_TYPE,
                      builder: (field) => Column(
                        children: ListTile.divideTiles(
                          context: context,
                          tiles: SearchCategory.getAll()
                              .map(
                                (e) => ListTile(
                                  onTap: () => field.control.updateValue(e, emitEvent: true),
                                  trailing: Icon(
                                    e == field.value ? Icons.circle : Icons.circle_outlined,
                                    color: e == field.value ? context.theme.colorScheme.tertiary : null,
                                  ),
                                  title: Text(
                                    e.label,
                                    overflow: TextOverflow.fade,
                                    textWidthBasis: TextWidthBasis.parent,
                                    style: context.theme.chipTheme.labelStyle,
                                  ),
                                ),
                              )
                              .toList(),
                        ).toList(),
                      ),
                    ),
                    Container(
                      color: context.theme.dividerColor,
                      height: 5,
                    ),
                    ReactiveFormField<SortOrder, SortOrder>(
                      formControlName: DiscoverViewModel.FORM_SORT_ORDER,
                      builder: (field) => Theme(
                        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTileCard(
                          key: _keySortOrderCard,
                          elevation: 0,
                          baseColor: context.theme.colorScheme.background.withOpacity(0.05),
                          expandedColor: context.theme.colorScheme.background.withOpacity(0.5),
                          borderRadius: BorderRadius.zero,
                          title: Text('Ordenar por:'),
                          subtitle: Text(
                            field.value?.label ?? '',
                            style: context.theme.textTheme.bodyMedium?.copyWith(
                              color: context.theme.colorScheme.tertiary,
                            ),
                          ),
                          children: ListTile.divideTiles(
                            context: context,
                            tiles: SortOrder.values
                                .map(
                                  (e) => ListTile(
                                    onTap: () {
                                      field.control.updateValue(e, emitEvent: true);
                                      _keySortOrderCard.currentState?.collapse();
                                    },
                                    trailing: Icon(
                                      e == field.value ? Icons.circle : Icons.circle_outlined,
                                      color: e == field.value ? context.theme.colorScheme.tertiary : null,
                                    ),
                                    title: Text(
                                      e.label,
                                      overflow: TextOverflow.fade,
                                      textWidthBasis: TextWidthBasis.parent,
                                      style: context.theme.chipTheme.labelStyle,
                                    ),
                                  ),
                                )
                                .toList(),
                          ).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
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
                              title: Text('Plataforma'),
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
