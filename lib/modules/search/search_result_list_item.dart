import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_page.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/person/components/person_detail_screen.dart';
import 'package:movie_search/modules/search/search_result_image.dart';
import 'package:movie_search/providers/util.dart';

class SearchResultListItem extends StatelessWidget {
  final BaseSearchResult searchResult;
  final String searchCriteria;

  SearchResultListItem(
      {Key key, @required this.searchResult, this.searchCriteria})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedColor: Colors.transparent,
      openColor: Colors.transparent,
      transitionDuration: Duration(milliseconds: 400),
      closedElevation: 0.0,
      openElevation: 0.0,
      closedBuilder: (context, open) => Card(
        elevation: 0,
        color: Theme.of(context).cardColor.withOpacity(0.15),
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () {
            if (searchCriteria != null)
              SharedPreferencesHelper.getInstance()
                  .updateSearchHistory(searchCriteria);
            open.call();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchResultItemImage(searchResult.image),
              Container(height: 120),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon(_icons[searchResult.type]),
                    Container(
                      color: Theme.of(context).cardColor,
                      padding: const EdgeInsets.all(5),
                      child: Text(searchResult.type.nameSingular),
                    ),
                    ListTile(
                      title: Text(searchResult.title,
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                color: Theme.of(context).accentColor,
                              )),
                      subtitle: searchResult.titleOriginal != null
                          ? Text(searchResult.titleOriginal,
                              textAlign: TextAlign.end,
                              style: Theme.of(context).textTheme.subtitle1)
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      openBuilder: (context, close) => searchResult.type == TMDB_API_TYPE.PERSON
          ? PersonDetailScreen(param: searchResult.person)
          : ItemDetailPage(item: this.searchResult),
    );
  }
}
