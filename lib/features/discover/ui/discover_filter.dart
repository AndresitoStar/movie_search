import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:movie_search/common/model/country.dart';
import 'package:movie_search/common/model/genre.dart';
import 'package:movie_search/common/model/tmdb_type.dart';
import 'package:movie_search/common/provider/genres_provider.dart';
import 'package:movie_search/common/ui/expansion_tile_card.dart';
import 'package:movie_search/common/ui/frino_icons.dart';
import 'package:movie_search/common/ui/utils.dart';
import 'package:movie_search/features/discover/provider/discover_provider.dart';
import 'package:movie_search/features/home/provider/home_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DiscoverFilterBar extends ConsumerWidget {
  const DiscoverFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final type = ref.watch(homeContentTypeProvider);
    final currentFilter = ref.watch(discoverFilterProvider);
    final isLandscape = Device.screenType == ScreenType.desktop || Device.screenType == ScreenType.tablet;

    return ListTile(
      title: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(spacing: 10, children: [
          Chip(label: Text(type.value!.nameSingular)),
          if (currentFilter.sortOrder != null)
            Chip(label: Text('Ordenado por: ${currentFilter.sortOrder!.label}')),
          if (currentFilter.genres != null && currentFilter.genres!.isNotEmpty)
            Chip(label: Text('Generos: ${currentFilter.genres!.map((e) => e.name).join(', ')}')),
        ]),
      ),
      trailing: IconButton(
        icon: Icon(FrinoIcons.f_filter),
        onPressed: () {
          if (isLandscape) {
            DiscoverFilterView.showAsDialog(context);
          } else {
            DiscoverFilterView.showAsBottomSheet(context);
          }
        },
      ),
    );
  }
}

class DiscoverFilterView extends ConsumerWidget {
  DiscoverFilterView({super.key});
  final _keySortOrderCard = GlobalKey<ExpansionTileCardState>();

  // static showDialogMethod
  static Future showAsDialog(BuildContext context) async {
    await showBlurDialog(
      context: context,
      child: Dialog(
        child: Container(
          constraints: BoxConstraints(maxWidth: Adaptive.px(500)),
          height: 80.h,
          child: DiscoverFilterView(),
        ),
      ),
    );
  }

  static Future showAsBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,

      builder: (context) => SizedBox(height: 85.h, child: DiscoverFilterView()),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentTypeProvider = ref.watch(homeContentTypeProvider);
    final genresProvider = ref.watch(genresByTypeProvider(contentTypeProvider.value!));
    final currentFilter = ref.watch(discoverFilterProvider);
    final sortOrdersValues = contentTypeProvider.value == TMDB_API_TYPE.MOVIE
        ? SortOrder.movieSortOrders()
        : SortOrder.tvSortOrders();

    return ListView(
      children: [
        Card(
          clipBehavior: Clip.hardEdge,
          elevation: 0, // Optional: adjust elevation as needed
          color: Colors.transparent,
          child: ListTile(
            title: Text('Filtros', style: context.theme.textTheme.headlineSmall, textAlign: .center),
            trailing: IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.of(context).pop()),
          ),
        ),
        Divider(),
        Column(
          children: [
            Theme(
              data: context.theme.copyWith(dividerColor: Colors.transparent),
              child: ExpansionTileCard(
                key: _keySortOrderCard,
                elevation: 0,
                baseColor: context.theme.colorScheme.surface.withOpacity(0.05),
                expandedColor: context.theme.colorScheme.surface.withOpacity(0.5),
                borderRadius: BorderRadius.zero,
                title: Text('Ordenar por:'),
                subtitle: Text(
                  currentFilter.sortOrder?.label ?? '',
                  style: context.theme.textTheme.bodyMedium?.copyWith(color: context.theme.colorScheme.tertiary),
                ),
                children: [
                  ...ListTile.divideTiles(
                    context: context,
                    tiles: SortDirection.values
                        .map(
                          (e) => ListTile(
                        onTap: () {
                          ref.read(discoverFilterProvider.notifier).toggleSortDirectionFilter(e);
                        },
                        trailing: Icon(
                          e == currentFilter.sortDirection ? Icons.circle : Icons.circle_outlined,
                          color: e == currentFilter.sortDirection ? context.theme.colorScheme.tertiary : null,
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
                  ),
                  Divider(color: context.colors.primary,),
                  ...ListTile.divideTiles(
                    context: context,
                    tiles: sortOrdersValues
                        .map(
                          (e) => ListTile(
                        onTap: () {
                          ref.read(discoverFilterProvider.notifier).toggleSortOrderFilter(e);
                          // _keySortOrderCard.currentState?.collapse();
                        },
                        trailing: Icon(
                          e == currentFilter.sortOrder ? Icons.circle : Icons.circle_outlined,
                          color: e == currentFilter.sortOrder ? context.theme.colorScheme.tertiary : null,
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
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Column(
          children: [
            // Container(color: context.theme.colorScheme.surface, height: 5),
            //SearchByPersonButton(),
            Divider(),
            if (genresProvider.value != null)
              Builder(
                builder: (field) {
                  final List<Genre> value = ref.watch(discoverFilterProvider).genres ?? [];
                  return Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTileCard(
                      title: Text('Generos'),
                      initiallyExpanded: true,
                      elevation: 0,
                      baseColor: context.theme.colorScheme.surface.withValues(alpha: 0.05),
                      expandedColor: context.theme.colorScheme.surface.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.zero,
                      children: [
                        Wrap(
                          spacing: 8,
                          runSpacing: 5,
                          alignment: WrapAlignment.start,
                          children: genresProvider.value!
                              .toList()
                              .map(
                                (e) => GestureDetector(
                                  onTap: () {
                                    ref.read(discoverFilterProvider.notifier).toggleGenreFilter(e);
                                  },
                                  child: Chip(
                                    elevation: 0,
                                    backgroundColor: value.contains(e)
                                        ? context.theme.colorScheme.secondary
                                        : context.theme.chipTheme.backgroundColor,
                                    label: Text(
                                      e.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: context.theme.textTheme.bodyMedium!.copyWith(
                                        color: value.contains(e)
                                            ? context.theme.colorScheme.onPrimary
                                            : context.theme.colorScheme.primary,
                                        fontWeight: value.contains(e) ? FontWeight.bold : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  );
                },
              ),
            Divider(),
            // ReactiveValueListenableBuilder(
            //   formControlName: DiscoverViewModel.FORM_TYPE,
            //   builder: (context, typeControl, _) => ReactiveFormField<Set<WatchProvider>, Set<WatchProvider>>(
            //     formControlName: DiscoverViewModel.FORM_PROVIDERS,
            //     builder: (field) {
            //       final value = field.control.value ?? {};
            //       return Theme(
            //         data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            //         child: ExpansionTileCard(
            //           title: Text('Donde ver'),
            //           subtitle: field.control.isNotNull && value.isNotEmpty
            //               ? Wrap(
            //                   spacing: 5,
            //                   children: value
            //                       .map(
            //                         (e) => Chip(
            //                           label: Text(
            //                             e.providerName!,
            //                             style: context.theme.textTheme.bodyMedium?.copyWith(
            //                               color: context.theme.colorScheme.onSecondary,
            //                               fontWeight: FontWeight.bold,
            //                             ),
            //                           ),
            //                           avatar: Container(
            //                             clipBehavior: Clip.hardEdge,
            //                             decoration: BoxDecoration(shape: BoxShape.circle),
            //                             height: 20,
            //                             width: 20,
            //                             child: CachedNetworkImage(imageUrl: '$URL_IMAGE_MEDIUM${e.logoPath}'),
            //                           ),
            //                           side: BorderSide(
            //                             color: context.theme.colorScheme.secondary.withOpacity(0.7),
            //                           ),
            //                           backgroundColor: context.theme.colorScheme.secondary,
            //                           deleteIcon: Icon(
            //                             Icons.clear,
            //                             color: context.theme.colorScheme.onSecondary,
            //                             size: 12,
            //                           ),
            //                           onDeleted: () => model.toggleProvider(e),
            //                           deleteIconColor: context.theme.colorScheme.onSurface,
            //                         ),
            //                       )
            //                       .toList(),
            //                 )
            //               : null,
            //           elevation: 0,
            //           baseColor: context.theme.colorScheme.surface.withOpacity(0.05),
            //           expandedColor: context.theme.colorScheme.surface.withOpacity(0.5),
            //           borderRadius: BorderRadius.zero,
            //           children: ListTile.divideTiles(
            //             color: context.theme.dividerColor,
            //             context: context,
            //             tiles: model.watchProviders
            //                 .toList()
            //                 .where((s) => !value.map((e) => e.providerId).toList().contains(s.providerId))
            //                 .map(
            //                   (e) => ListTile(
            //                     onTap: () => model.toggleProvider(e),
            //                     leading: Container(
            //                       clipBehavior: Clip.hardEdge,
            //                       margin: EdgeInsets.all(1),
            //                       decoration: BoxDecoration(shape: BoxShape.circle),
            //                       height: 32,
            //                       width: 32,
            //                       child: Image.network('$URL_IMAGE_MEDIUM${e.logoPath}'),
            //                     ),
            //                     trailing: value.contains(e)
            //                         ? Icon(FontAwesomeIcons.check, color: context.theme.colorScheme.tertiary)
            //                         : null,
            //                     title: Text(
            //                       e.providerName ?? '${e.providerId}',
            //                       overflow: TextOverflow.fade,
            //                       textWidthBasis: TextWidthBasis.parent,
            //                       // textAlign: TextAlign.center,
            //                       style: context.theme.textTheme.bodyMedium!.copyWith(
            //                         color: value.contains(e)
            //                             ? context.theme.colorScheme.primary
            //                             : context.theme.textTheme.bodyMedium!.color,
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //                 .toList(),
            //           ).toList(),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            // Divider(),
            // ReactiveValueListenableBuilder(
            //   formControlName: DiscoverViewModel.FORM_COUNTRY,
            //   builder: (context, typeControl, _) => ReactiveFormField<Country, Country>(
            //     formControlName: DiscoverViewModel.FORM_COUNTRY,
            //     builder: (field) => Theme(
            //       data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            //       child: ListTile(
            //         title: Text('Origen'),
            //         subtitle: field.value != null
            //             ? Text(
            //                 field.value!.name,
            //                 style: context.theme.textTheme.bodyMedium?.copyWith(
            //                   color: context.theme.colorScheme.tertiary,
            //                 ),
            //               )
            //             : Text(
            //                 'Todos',
            //                 style: context.theme.textTheme.bodyMedium?.copyWith(
            //                   color: context.theme.colorScheme.tertiary,
            //                 ),
            //               ),
            //         onTap: () async {
            //           final country = await showDialog<Country>(
            //             context: context,
            //             builder: (context) => SimpleDialog(
            //               title: Text('Selecciona un pais'),
            //               children: [
            //                 ...ConfigSingleton.instance.countries
            //                     .map(
            //                       (e) => ListTile(title: Text(e.name), onTap: () => Navigator.of(context).pop(e)),
            //                     )
            //                     .toList(),
            //               ],
            //             ),
            //           );
            //           if (country != null) {
            //             field.control.updateValue(country);
            //           }
            //         },
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
        SizedBox(height: 10),
        // ListTile(
        //   title: Text('Buscar'),
        //   tileColor: context.theme.colorScheme.onSurface.withValues(alpha: 0.05),
        //   titleTextStyle: context.theme.textTheme.titleLarge,
        //   leading: Icon(Icons.check_rounded),
        //   minLeadingWidth: 0,
        //   onTap: () async {
        //     model.search();
        //     context.pop();
        //   },
        // ),
        SizedBox(height: 10),
      ],
    );
  }
}

const String FORM_TYPE = 'type';
const String FORM_GENRE = 'genre';
const String FORM_CAST = 'cast';
const String FORM_COUNTRY = 'with_origin_country';
const String FORM_PROVIDERS = 'networks';
const String FORM_SORT_ORDER = 'sort_order';
const String FORM_SORT_DIRECTIONS = 'sort_direction';
