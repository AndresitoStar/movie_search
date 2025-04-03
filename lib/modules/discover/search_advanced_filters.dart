import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_search/model/api/models/api.dart';
import 'package:movie_search/model/api/models/country.dart';
import 'package:movie_search/model/api/models/genre.dart';
import 'package:movie_search/model/api/models/tv.dart';
import 'package:movie_search/modules/discover/discover_viewmodel.dart';
import 'package:movie_search/modules/discover/search_by_person.dart';
import 'package:movie_search/modules/search/search_category.dart';
import 'package:movie_search/modules/splash/config_singleton.dart';
import 'package:movie_search/providers/util.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

class SearchAdvancedFilterView extends ViewModelWidget<DiscoverViewModel> {
  final _keySortOrderCard = GlobalKey<ExpansionTileCardState>();

  @override
  Widget build(BuildContext context, DiscoverViewModel model) {
    return SafeArea(
      child: Scaffold(
        // elevation: 0,
        appBar: AppBar(
          title: Text('Filtros avanzados'),
          forceMaterialTransparency: true,
          titleSpacing: 0,
        ),
        body: ReactiveForm(
          formGroup: model.form,
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.zero,
                elevation: 10,
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.zero)),
                child: Column(
                  children: [
                    ReactiveFormField<SearchCategory, SearchCategory>(
                      formControlName: DiscoverViewModel.FORM_TYPE,
                      builder: (field) =>
                          Column(
                            children: ListTile.divideTiles(
                              context: context,
                              tiles: SearchCategory.getAll()
                                  .map(
                                    (e) =>
                                    ListTile(
                                      onTap: () =>
                                          field.control
                                              .updateValue(e, emitEvent: true),
                                      trailing: Icon(
                                        e == field.value
                                            ? Icons.circle
                                            : Icons.circle_outlined,
                                        color: e == field.value
                                            ? context.theme.colorScheme.tertiary
                                            : null,
                                      ),
                                      title: Text(
                                        e.label,
                                        overflow: TextOverflow.fade,
                                        textWidthBasis: TextWidthBasis.parent,
                                        style: context.theme.chipTheme
                                            .labelStyle,
                                      ),
                                    ),
                              )
                                  .toList(),
                            ).toList(),
                          ),
                    ),
                    Container(
                      color: context.theme.colorScheme.surface,
                      height: 5,
                    ),
                    ReactiveFormField<SortOrder, SortOrder>(
                      formControlName: DiscoverViewModel.FORM_SORT_ORDER,
                      builder: (field) =>
                          Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTileCard(
                              key: _keySortOrderCard,
                              elevation: 0,
                              baseColor: context.theme.colorScheme.surface
                                  .withOpacity(0.05),
                              expandedColor: context.theme.colorScheme.surface
                                  .withOpacity(0.5),
                              borderRadius: BorderRadius.zero,
                              title: Text('Ordenar por:'),
                              subtitle: Text(
                                field.value?.label ?? '',
                                style: context.theme.textTheme.bodyMedium
                                    ?.copyWith(
                                  color: context.theme.colorScheme.tertiary,
                                ),
                              ),
                              children: ListTile.divideTiles(
                                context: context,
                                tiles: SortOrder.values
                                    .map(
                                      (e) =>
                                      ListTile(
                                        onTap: () {
                                          field.control
                                              .updateValue(e, emitEvent: true);
                                          _keySortOrderCard.currentState
                                              ?.collapse();
                                        },
                                        trailing: Icon(
                                          e == field.value
                                              ? Icons.circle
                                              : Icons.circle_outlined,
                                          color: e == field.value
                                              ? context.theme.colorScheme
                                              .tertiary
                                              : null,
                                        ),
                                        title: Text(
                                          e.label,
                                          overflow: TextOverflow.fade,
                                          textWidthBasis: TextWidthBasis.parent,
                                          style: context.theme.chipTheme
                                              .labelStyle,
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
                      Container(
                        color: context.theme.colorScheme.surface,
                        height: 5,
                      ),
                      SearchByPersonButton(),
                      Divider(),
                      ReactiveValueListenableBuilder(
                        formControlName: DiscoverViewModel.FORM_TYPE,
                        builder: (context, typeControl, _) =>
                            ReactiveFormField<Set<Genre>, Set<Genre>>(
                              formControlName: DiscoverViewModel.FORM_GENRE,
                              builder: (field) {
                                final value = field.value ?? {};
                                return Theme(
                                  data: Theme.of(context)
                                      .copyWith(
                                      dividerColor: Colors.transparent),
                                  child: ExpansionTileCard(
                                    title: Text('Generos'),
                                    subtitle: field.control.isNotNull &&
                                        field.control.value!.isNotEmpty
                                        ? Wrap(
                                      spacing: 5,
                                      children: value
                                          .map((e) =>
                                          Chip(
                                            label: Text(
                                              e.name,
                                              style: context.theme
                                                  .textTheme.bodyMedium
                                                  ?.copyWith(
                                                color: context
                                                    .theme
                                                    .colorScheme
                                                    .onSecondary,
                                                fontWeight:
                                                FontWeight.bold,
                                              ),
                                            ),
                                            side: BorderSide(
                                              color: context
                                                  .theme
                                                  .colorScheme
                                                  .secondary
                                                  .withOpacity(0.7),
                                            ),
                                            backgroundColor: context.theme
                                                .colorScheme.secondary,
                                            deleteIcon: Icon(Icons.clear,
                                                color: context
                                                    .theme
                                                    .colorScheme
                                                    .onSecondary,
                                                size: 12),
                                            onDeleted: () =>
                                                model
                                                    .toggleGenreFilter(e),
                                            deleteIconColor: context.theme
                                                .colorScheme.onSurface,
                                          ))
                                          .toList(),
                                    )
                                        : Text(
                                      'Todos',
                                      style: context
                                          .theme.textTheme.bodyMedium
                                          ?.copyWith(
                                        color: context
                                            .theme.colorScheme.tertiary,
                                      ),
                                    ),
                                    elevation: 0,
                                    baseColor: context.theme.colorScheme.surface
                                        .withValues(alpha: 0.05),
                                    expandedColor: context.theme.colorScheme
                                        .surface
                                        .withValues(alpha: 0.5),
                                    borderRadius: BorderRadius.zero,
                                    children: [
                                      Wrap(
                                        spacing: 10,
                                        alignment: WrapAlignment.start,
                                        children: model.allFilterGenres
                                            .where((s) =>
                                        !value
                                            .map((e) => e.id)
                                            .toList()
                                            .contains(s.id))
                                            .toList()
                                            .map(
                                              (e) =>
                                              GestureDetector(
                                                onTap: () =>
                                                    model.toggleGenreFilter(e),
                                                child: Chip(
                                                  elevation: 0,
                                                  // side: value.contains(e)
                                                  //     ? BorderSide(
                                                  //         color: context.theme
                                                  //             .colorScheme.secondary
                                                  //             .withOpacity(0.7),
                                                  //       )
                                                  //     : BorderSide(
                                                  //         color: context
                                                  //             .theme
                                                  //             .chipTheme
                                                  //             .labelStyle
                                                  //             .color
                                                  //             .withOpacity(0.2)),
                                                  backgroundColor: value
                                                      .contains(e)
                                                      ? context.theme
                                                      .colorScheme
                                                      .secondary
                                                      : context.theme.chipTheme
                                                      .backgroundColor,
                                                  label: Text(
                                                    e.name,
                                                    maxLines: 1,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    style: context
                                                        .theme.textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                      color: value.contains(e)
                                                          ? context.theme
                                                          .colorScheme.onPrimary
                                                          : context.theme
                                                          .colorScheme.primary,
                                                      fontWeight: value
                                                          .contains(e)
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        )
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                      ),
                      Divider(),
                      ReactiveValueListenableBuilder(
                        formControlName: DiscoverViewModel.FORM_TYPE,
                        builder: (context, typeControl, _) =>
                            ReactiveFormField<
                                Set<WatchProvider>,
                                Set<WatchProvider>>(
                              formControlName: DiscoverViewModel.FORM_PROVIDERS,
                              builder: (field) {
                                final value = field.control.value ?? {};
                                return Theme(
                                  data: Theme.of(context)
                                      .copyWith(
                                      dividerColor: Colors.transparent),
                                  child: ExpansionTileCard(
                                    title: Text('Donde ver'),
                                    subtitle: field.control.isNotNull &&
                                        value.isNotEmpty
                                        ? Wrap(
                                      spacing: 5,
                                      children: value
                                          .map((e) =>
                                          Chip(
                                            label: Text(
                                              e.providerName!,
                                              style: context.theme
                                                  .textTheme.bodyMedium
                                                  ?.copyWith(
                                                color: context
                                                    .theme
                                                    .colorScheme
                                                    .onSecondary,
                                                fontWeight:
                                                FontWeight.bold,
                                              ),
                                            ),
                                            avatar: Container(
                                              clipBehavior: Clip.hardEdge,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle),
                                              height: 20,
                                              width: 20,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                '$URL_IMAGE_MEDIUM${e
                                                    .logoPath}',
                                              ),
                                            ),
                                            side: BorderSide(
                                              color: context
                                                  .theme
                                                  .colorScheme
                                                  .secondary
                                                  .withOpacity(0.7),
                                            ),
                                            backgroundColor: context.theme
                                                .colorScheme.secondary,
                                            deleteIcon: Icon(
                                              Icons.clear,
                                              color: context
                                                  .theme
                                                  .colorScheme
                                                  .onSecondary,
                                              size: 12,
                                            ),
                                            onDeleted: () =>
                                                model.toggleProvider(e),
                                            deleteIconColor: context.theme
                                                .colorScheme.onSurface,
                                          ))
                                          .toList(),
                                    )
                                        : null,
                                    elevation: 0,
                                    baseColor: context.theme.colorScheme.surface
                                        .withOpacity(0.05),
                                    expandedColor: context.theme.colorScheme
                                        .surface
                                        .withOpacity(0.5),
                                    borderRadius: BorderRadius.zero,
                                    children: ListTile.divideTiles(
                                      color: context.theme.dividerColor,
                                      context: context,
                                      tiles: model.watchProviders
                                          .toList()
                                          .where((s) =>
                                          !value
                                              .map((e) => e.providerId)
                                              .toList()
                                              .contains(s.providerId))
                                          .map(
                                            (e) =>
                                            ListTile(
                                              onTap: () =>
                                                  model.toggleProvider(e),
                                              leading: Container(
                                                clipBehavior: Clip.hardEdge,
                                                margin: EdgeInsets.all(1),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle),
                                                height: 32,
                                                width: 32,
                                                child: Image.network(
                                                  '$URL_IMAGE_MEDIUM${e
                                                      .logoPath}',
                                                ),
                                              ),
                                              trailing: value.contains(e)
                                                  ? Icon(
                                                FontAwesomeIcons.check,
                                                color: context.theme
                                                    .colorScheme.tertiary,
                                              )
                                                  : null,
                                              title: Text(
                                                e.providerName ??
                                                    '${e.providerId}',
                                                overflow: TextOverflow.fade,
                                                textWidthBasis:
                                                TextWidthBasis.parent,
                                                // textAlign: TextAlign.center,
                                                style: context
                                                    .theme.textTheme.bodyMedium!
                                                    .copyWith(
                                                  color: value.contains(e)
                                                      ? context
                                                      .theme.colorScheme.primary
                                                      : context.theme.textTheme.bodyMedium!.color,
                                                ),
                                              ),
                                            ),
                                      )
                                          .toList(),
                                    ).toList(),
                                  ),
                                );
                              },
                            ),
                      ),
                      Divider(),
                      ReactiveValueListenableBuilder(
                        formControlName: DiscoverViewModel.FORM_COUNTRY,
                        builder: (context, typeControl, _) =>
                            ReactiveFormField<Country, Country>(
                              formControlName: DiscoverViewModel.FORM_COUNTRY,
                              builder: (field) =>
                                  Theme(
                                    data: Theme.of(context)
                                        .copyWith(
                                        dividerColor: Colors.transparent),
                                    child: ListTile(
                                      title: Text('Origen'),
                                      subtitle: field.value != null
                                          ? Text(
                                        field.value!.name,
                                        style: context.theme.textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                          color:
                                          context.theme.colorScheme.tertiary,
                                        ),
                                      )
                                          : Text(
                                        'Todos',
                                        style: context.theme.textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                          color:
                                          context.theme.colorScheme.tertiary,
                                        ),
                                      ),
                                      onTap: () async {
                                        final country = await showDialog<
                                            Country>(
                                          context: context,
                                          builder: (context) =>
                                              SimpleDialog(
                                                title: Text(
                                                    'Selecciona un pais'),
                                                children: [
                                                  ...ConfigSingleton.instance
                                                      .countries
                                                      .map(
                                                        (e) =>
                                                        ListTile(
                                                          title: Text(e.name),
                                                          onTap: () =>
                                                              Navigator.of(
                                                                  context).pop(
                                                                  e),
                                                        ),
                                                  )
                                                      .toList(),
                                                ],
                                              ),
                                        );
                                        if (country != null) {
                                          field.control.updateValue(country);
                                        }
                                      },
                                    ),
                                  ),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              ListTile(
                title: Text('Buscar'),
                tileColor:
                context.theme.colorScheme.onSurface.withValues(alpha: 0.05),
                titleTextStyle: context.theme.textTheme.titleLarge,
                leading: Icon(Icons.check_rounded),
                minLeadingWidth: 0,
                onTap: () async {
                  model.search();
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
