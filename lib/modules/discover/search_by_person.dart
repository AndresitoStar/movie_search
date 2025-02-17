import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/discover/discover_viewmodel.dart';
import 'package:movie_search/modules/discover/search_by_person_page.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/routes.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

class SearchByPersonButton extends ViewModelWidget<DiscoverViewModel> {
  const SearchByPersonButton({super.key});

  @override
  Widget build(BuildContext context, DiscoverViewModel model) {
    return ReactiveFormField<Set<BaseSearchResult>, Set<BaseSearchResult>>(
        formControlName: DiscoverViewModel.FORM_CAST,
        builder: (field) {
          return ExpansionTileCard(
            elevation: 0,
            baseColor: context.theme.colorScheme.surface.withOpacity(0.05),
            expandedColor: context.theme.colorScheme.surface.withOpacity(0.5),
            borderRadius: BorderRadius.zero,
            title: Text('Cast'),
            subtitle: Wrap(
              spacing: 5,
              alignment: WrapAlignment.start,
              children: field.value!
                  .map((e) => Chip(
                label: Text(
                  e.title!,
                  style: context.theme.textTheme
                      .bodyMedium
                      ?.copyWith(
                    color: context
                        .theme
                        .colorScheme
                        .onSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                side: BorderSide(
                  color: context
                      .theme
                      .chipTheme
                      .secondaryLabelStyle!
                      .color!
                      .withOpacity(0.7),
                ),
                backgroundColor: context.theme
                    .colorScheme.secondary,
                deleteIcon: Icon(
                  Icons.clear,
                  color: context.theme
                      .colorScheme.onSecondary,
                  size: 12,
                ),
                onDeleted: () {
                  field.value!.remove(e);
                  field.control.updateValueAndValidity();
                },
                deleteIconColor: context.theme
                    .colorScheme.onBackground,
              ))
                  .toList(),
            ),
            children: [
              ListTile(
                title: Text('Add cast'),
                tileColor: context.theme.colorScheme.onSurface.withValues(alpha: 0.05),
                leading: Icon(Icons.add),
                minLeadingWidth: 0,
                onTap: () async {
                  final result = await Navigator.of(context).push(
                    Routes.defaultRoute(
                      null,
                      SearchPersonListPage(cast: field.value!),
                    ),
                  ) as Set<BaseSearchResult>?;
                  if (result != null) {
                    model.toggleByPersonFilter(result);
                  }
                },
              ),
            ],
            // subtitle: Text(
            //   field.value?.label ?? '',
            //   style: context.theme.textTheme.bodyMedium?.copyWith(
            //     color: context.theme.colorScheme.tertiary,
            //   ),
            // ),
          );
        });
  }
}
