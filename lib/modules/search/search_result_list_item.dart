import 'package:flutter/material.dart';
import 'package:movie_search/core/content_preview.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_main_image.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_page.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/search/search_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/routes.dart';
import 'package:provider/provider.dart';

class SearchResultListItem extends StatelessWidget {
  final BaseSearchResult searchResult;
  final String? searchCriteria;

  SearchResultListItem(
      {Key? key, required this.searchResult, this.searchCriteria})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchViewModel? searchViewModel = context.read();
    return GestureDetector(
      onTap: () {
        if (searchCriteria != null)
          SharedPreferencesHelper.getInstance()
              .updateSearchHistory(searchCriteria!);
        if (searchViewModel != null) searchViewModel.queryControl.unfocus();
        _onPressed(context);
      },
      child: Card(
        elevation: 0,
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.all(10),
        child: _ResultListItem(searchResult: searchResult, showTitles: true),
      ),
    );
  }

  _onPressed(BuildContext context) {
    final child = ItemDetailPage(
      item: this.searchResult,
      heroTagPrefix: UiUtils.generateRandomString(),
    );
    Navigator.of(context).push(Routes.defaultRoute(null, child));
  }
}

class ItemGridCarousel extends StatelessWidget {
  final BaseSearchResult searchResult;

  ItemGridCarousel({Key? key, required this.searchResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onPressed(context);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: _ResultListItem(searchResult: searchResult, showTitles: true),
      ),
    );
  }

  _onPressed(BuildContext context) {
    final child = ItemDetailPage(
      item: this.searchResult,
      heroTagPrefix: UiUtils.generateRandomString(),
    );
    Navigator.of(context).push(Routes.defaultRoute(null, child));
  }
}

class _ResultListItem extends StatelessWidget {
  const _ResultListItem({
    required this.searchResult,
    this.showTitles = false,
  });

  final BaseSearchResult searchResult;
  final bool showTitles;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.zero,
      elevation: 3,
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
    );
  }
}
