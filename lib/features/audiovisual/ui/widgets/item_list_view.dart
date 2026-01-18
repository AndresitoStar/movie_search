import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search/common/domain/search_result.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:movie_search/common/model/tmdb_type.dart';
import 'package:movie_search/common/ui/content_image.dart';
import 'package:movie_search/common/ui/panara_button.dart';
import 'package:movie_search/features/search/provider/search_provider.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchResultListItem extends StatelessWidget {
  final BaseSearchResult searchResult;
  final String? searchCriteria;
  final bool conpactMode;

  const SearchResultListItem({super.key, required this.searchResult, this.searchCriteria, this.conpactMode = false});

  @override
  Widget build(BuildContext context) {
    return conpactMode
        ? _ResultListItemCompact(searchResult: searchResult, searchCriteria: searchCriteria)
        : _ResultListItem(searchResult: searchResult, showTitles: true, searchCriteria: searchCriteria);
  }
}

class _ResultListItem extends StatelessWidget {
  const _ResultListItem({required this.searchResult, this.showTitles = false, this.searchCriteria});

  final BaseSearchResult searchResult;
  final bool showTitles;
  final String? searchCriteria;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // if (searchCriteria != null) SharedPreferencesHelper.getInstance().updateSearchHistory(searchCriteria!);
        context.push(
          '/${searchResult.type.type.toLowerCase()}/${searchResult.id}',
          extra: {'item': searchResult, 'tag': 'search_result_${searchResult.id}'},
        );
      },
      child: Card(
        elevation: 0,
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.all(10),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (searchResult.backDropImage != null)
              ContentImageWidget(searchResult.backDropImage, ignorePointer: true, isBackdrop: true),
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
                          if (searchResult.titleOriginal != null && searchResult.titleOriginal != searchResult.title)
                            Text(
                              searchResult.titleOriginal!,
                              textAlign: TextAlign.end,
                              style: context.theme.textTheme.titleMedium,
                              maxLines: 1,
                            ),
                          if (searchResult.type != TMDB_API_TYPE.PERSON) Text(searchResult.type.nameSingular),
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
                        child: ContentImageWidget(searchResult.posterImage, ignorePointer: true, fit: BoxFit.cover),
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

class _ResultListItemCompact extends ConsumerWidget {
  const _ResultListItemCompact({required this.searchResult, this.searchCriteria});

  final BaseSearchResult searchResult;
  final String? searchCriteria;

  _onPressed(BuildContext context, WidgetRef ref) {
    final isMobile = Device.screenType == ScreenType.mobile;
    if (!isMobile) {
      // set selected item in a provider or bloc
      ref.read(searchSelectedIndexProvider.notifier).setIndex(searchResult.id);

      return;
    }
    PanaraCustomDialog.show(
      context,
      barrierDismissible: true,
      children: [
        ListTile(
          title: Text(searchResult.title ?? '-', style: context.theme.textTheme.headlineMedium),
          subtitle: Text(searchResult.type.nameSingular, style: context.theme.textTheme.titleMedium),
        ),
        if (searchResult.posterImage != null)
          Card(
            clipBehavior: Clip.hardEdge,
            child: ContentImageWidget(searchResult.posterImage, fit: BoxFit.fitHeight, withPlaceholder: false),
          ),
        const SizedBox(height: 10),
        PanaraButton(
          buttonTextColor: Colors.white,
          text: 'Ver detalles',
          onTap: () {
            context.pop();
            context.push(
              '/${searchResult.type.type.toLowerCase()}/${searchResult.id}',
              extra: {'item': searchResult, 'tag': 'search_result_${searchResult.id}'},
            );
          },
          bgColor: PanaraColors.normal,
          isOutlined: false,
        ),
        const SizedBox(height: 10),
        PanaraButton(
          buttonTextColor: Colors.white,
          text: 'Atras',
          onTap: () => context.pop(),
          bgColor: PanaraColors.normal,
          isOutlined: true,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (searchResult.type == TMDB_API_TYPE.UNKNOWN) {
      return const SizedBox();
    }
    final searchItemIdSelected = ref.watch(searchSelectedIndexProvider);
    return ListTile(
      onTap: () => _onPressed(context, ref),
      minTileHeight: 100,
      title: Row(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(children: _getTextSpans(searchResult.title ?? '', searchCriteria, context: context)),
            ),
          ),
        ],
      ),
      subtitle: searchItemIdSelected == searchResult.id
          ? AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: 240,
              width: 90.w,
              padding: EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: .start,
                children: [
                  AspectRatio(
                    aspectRatio: 9 / 16,
                    child: ContentImageWidget(searchResult.posterImage, fit: BoxFit.cover, ignorePointer: true),
                  ),
                  SizedBox(width: 20),
                  Expanded(child: Column(
                    spacing: 10,
                    children: [
                      Expanded(child: Text(searchResult.overview, style: context.theme.textTheme.bodyMedium, overflow: TextOverflow.fade)),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                          onPressed: () {
                            context.push(
                              '/${searchResult.type.type.toLowerCase()}/${searchResult.id}',
                              extra: {'item': searchResult, 'tag': 'search_result_${searchResult.id}'},
                            );
                          },
                          child: Text('Ver detalles'),

                        ),
                      ),
                      SizedBox(height: 1),
                    ],
                  )),
                ],
              ),
            )
          : null,
      trailing: searchResult.type != TMDB_API_TYPE.PERSON
          ? null
          : Icon(Icons.person_outline_outlined, color: context.theme.colorScheme.primary),
    );
  }

  List<TextSpan> _getTextSpans(String? original, String? highlight, {required BuildContext context}) {
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
    spans.add(TextSpan(text: original.substring(0, start), style: originalStyle));

    // Agregar el texto resaltado
    spans.add(
      TextSpan(
        text: original.substring(start, start + highlight.length),
        // Mantiene el texto original
        style: highlightStyle,
      ),
    );

    // Agregar el texto después del resaltado
    spans.add(TextSpan(text: original.substring(start + highlight.length), style: originalStyle));

    return spans;
  }
}

class ItemGridCarousel extends StatelessWidget {
  final BaseSearchResult searchResult;

  const ItemGridCarousel({super.key, required this.searchResult});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: _ResultListItem(searchResult: searchResult, showTitles: true),
    );
  }
}
