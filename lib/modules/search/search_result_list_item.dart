import 'package:flutter/material.dart';
import 'package:movie_search/core/content_preview.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_main_image.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_page.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/search/search_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/routes.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stacked/stacked.dart';

import '../../ui/widgets/panara_button.dart';

class SearchResultListItem extends StatelessWidget {
  final BaseSearchResult searchResult;
  final String? searchCriteria;
  final bool conpactMode;

  SearchResultListItem({
    Key? key,
    required this.searchResult,
    this.searchCriteria,
    this.conpactMode = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return this.conpactMode
        ? _ResultListItemCompact(
            searchResult: searchResult,
            searchCriteria: searchCriteria,
          )
        : _ResultListItem(
            searchResult: searchResult,
            showTitles: true,
            searchCriteria: searchCriteria,
          );
  }
}

class ItemGridCarousel extends StatelessWidget {
  final BaseSearchResult searchResult;

  ItemGridCarousel({Key? key, required this.searchResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: _ResultListItem(
        searchResult: searchResult,
        showTitles: true,
      ),
    );
  }
}

class _ResultListItem extends StatelessWidget {
  const _ResultListItem({
    required this.searchResult,
    this.showTitles = false,
    this.searchCriteria,
  });

  final BaseSearchResult searchResult;
  final bool showTitles;
  final String? searchCriteria;

  _onPressed(BuildContext context) {
    final child = ItemDetailPage(
      item: this.searchResult,
      heroTagPrefix: UiUtils.generateRandomString(),
    );
    Navigator.of(context).push(Routes.defaultRoute(null, child));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (searchCriteria != null)
          SharedPreferencesHelper.getInstance()
              .updateSearchHistory(searchCriteria!);
        // searchViewModel.queryControl.unfocus();
        _onPressed(context);
      },
      child: Card(
        elevation: 0,
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.all(10),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (searchResult.backDropImage != null)
              ContentImageWidget(
                searchResult.backDropImage,
                ignorePointer: true,
                isBackdrop: true,
              ),
            if (showTitles)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Spacer(),
                  Container(
                    color: context.theme.colorScheme.surface.withOpacity(0.7),
                    child: ListTile(
                      title: Text(
                        searchResult.title ?? '-',
                        textAlign: TextAlign.end,
                        style: context.theme.textTheme.headlineSmall,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (searchResult.titleOriginal != null &&
                              searchResult.titleOriginal != searchResult.title)
                            Text(
                              searchResult.titleOriginal!,
                              textAlign: TextAlign.end,
                              style: context.theme.textTheme.titleMedium,
                              maxLines: 1,
                            ),
                          if (searchResult.type != TMDB_API_TYPE.PERSON)
                            Text(searchResult.type.nameSingular)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            if (searchResult.backDropImage == null)
              Row(
                children: [
                  AspectRatio(
                    aspectRatio: 9 / 16,
                    child: Card(
                      margin: const EdgeInsets.fromLTRB(3, 3, 0, 3),
                      child: Card(
                        clipBehavior: Clip.hardEdge,
                        child: ContentImageWidget(
                          searchResult.posterImage,
                          ignorePointer: true,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _ResultListItemCompact extends ViewModelWidget<SearchViewModel> {
  const _ResultListItemCompact({
    required this.searchResult,
    this.searchCriteria,
  });

  final BaseSearchResult searchResult;
  final String? searchCriteria;

  _onPressed(BuildContext context) {
    PanaraCustomDialog.show(
      context,
      barrierDismissible: true,
      children: [
        ListTile(
          title: Text(
            searchResult.title ?? '-',
            style: context.theme.textTheme.headlineMedium,
          ),
          subtitle: Text(
            searchResult.type.nameSingular ?? '-',
            style: context.theme.textTheme.titleMedium,
          ),
        ),
        if (searchResult.posterImage != null)
          Card(
            clipBehavior: Clip.hardEdge,
            child: ContentImageWidget(
              searchResult.posterImage,
              fit: BoxFit.fitHeight,
              withPlaceholder: false,
            ),
          ),
        const SizedBox(height: 10),
        PanaraButton(
          buttonTextColor: Colors.white,
          text: 'Ver detalles',
          onTap: () {
            Navigator.of(context).pop();
            final child = ItemDetailPage(
              item: this.searchResult,
              heroTagPrefix: UiUtils.generateRandomString(),
            );
            Navigator.of(context).push(Routes.defaultRoute(null, child));
          },
          bgColor: PanaraColors.normal,
          isOutlined: false,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, SearchViewModel searchViewModel) {
    if (searchResult.type == TMDB_API_TYPE.UNKNOWN) {
      return const SizedBox();
    }
    return ListTile(
      onTap: () => _onPressed(context),
      title: RichText(
        text: TextSpan(
          children: _getTextSpans(searchResult.title ?? '', searchCriteria,
              context: context),
        ),
      ),
      subtitle: searchResult.titleOriginal != null &&
              searchResult.titleOriginal != searchResult.title
          ? Text(
              searchResult.titleOriginal!,
              style: context.theme.textTheme.titleSmall?.copyWith(
                fontStyle: FontStyle.italic,
              ),
              maxLines: 1,
            )
          : null,
      trailing: searchResult.type != TMDB_API_TYPE.PERSON
          ? null
          : Icon(
              Icons.person_outline_outlined,
              color: context.theme.colorScheme.primary,
            ),
    );
  }

  List<TextSpan> _getTextSpans(
    String? original,
    String? highlight, {
    required BuildContext context,
  }) {
    final originalStyle = context.theme.textTheme.titleLarge;
    final highlightStyle = context.theme.textTheme.titleLarge?.copyWith(
      color: context.theme.colorScheme.primary,
      // fontWeight: FontWeight.bold,
    );

    if (original == null || original.isEmpty) {
      return [TextSpan(text: '', style: originalStyle)];
    }

    if (highlight == null || highlight.isEmpty) {
      return [TextSpan(text: original, style: originalStyle)];
    }

    // Convertimos a minúsculas para buscar sin distinguir mayúsculas/minúsculas
    String originalLower = original.toLowerCase();
    String highlightLower = highlight.toLowerCase();
    int start = originalLower.indexOf(highlightLower);

    if (start == -1) {
      return [TextSpan(text: original, style: originalStyle)];
    }

    List<TextSpan> spans = [];

    // Agregar el texto antes del resaltado
    spans.add(TextSpan(
      text: original.substring(0, start),
      style: originalStyle,
    ));

    // Agregar el texto resaltado
    spans.add(TextSpan(
      text: original.substring(start, start + highlight.length),
      // Mantiene el texto original
      style: highlightStyle,
    ));

    // Agregar el texto después del resaltado
    spans.add(TextSpan(
      text: original.substring(start + highlight.length),
      style: originalStyle,
    ));

    return spans;
  }
}
