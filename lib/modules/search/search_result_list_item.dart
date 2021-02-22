import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_page.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/providers/util.dart';

class SearchResultListItem extends StatelessWidget {
  final _types = {'movie': 'Película', 'tv': 'Serie', 'person': 'Persona'};
  final ModelBase audiovisual;
  final String searchCriteria;

  SearchResultListItem({Key key, @required this.audiovisual, this.searchCriteria}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedColor: Colors.transparent,
      openColor: Colors.transparent,
      transitionDuration: Duration(milliseconds: 400),
      closedElevation: 0.0,
      openElevation: 0.0,
      closedBuilder: (context, open) => Card(
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: ListTile(
          onTap: () {
            if (searchCriteria != null)
              SharedPreferencesHelper.getInstance().updateSearchHistory(searchCriteria);
            open.call();
          },
          title: Hero(
              tag: 'title-${audiovisual.id}',
              child: Material(
                color: Colors.transparent,
                child: Text(audiovisual.title,
                    style: Theme.of(context).textTheme.headline6),
              )),
          subtitle: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(audiovisual.titleOriginal,
                  style: Theme.of(context).textTheme.subtitle1),
              Text('${_types[audiovisual.type]}/${audiovisual.yearOriginal ?? '-'}',
                  style: Theme.of(context).textTheme.caption),
            ],
          ),
        ),
      ),
      openBuilder: (context, close) =>
          ItemDetailPage(item: this.audiovisual),
    );
  }
}
