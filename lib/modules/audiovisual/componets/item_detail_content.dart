import 'package:flutter/material.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_like_button.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_detail_viewmodel.dart';
import 'package:movie_search/modules/person/components/person_horizontal_list.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:stacked/stacked.dart';

import 'item_detail_ui_util.dart';

class ItemDetailMainContent extends ViewModelWidget<ItemDetailViewModel> {
  @override
  Widget build(BuildContext context, viewModel) {
    final item = viewModel.data;
    final dynamic data =
        item.type == TMDB_API_TYPE.MOVIE ? item.movie : item.tvShow;
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          Hero(
            tag: 'title-${item.id}',
            child: Material(
              color: Colors.transparent,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: Theme.of(context).accentColor),
                ),
              ),
            ),
          ),
          Visibility(
            visible: item.titleOriginal != item.title,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                '(${item.titleOriginal})',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontStyle: FontStyle.italic, fontSize: 16),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: Row(
              children: [
                Icon(MyIcons.imdb, color: Colors.orange, size: 60),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${item.voteAverage}',
                      style: Theme.of(context).textTheme.headline4),
                ),
                Expanded(child: Container()),
                ItemLikeButton(id: item.id, type: viewModel.data.type),
              ],
            ),
          ),
          if (item.genres != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                children: item.genres
                    .map((e) => Chip(
                          label: Text(e),
                          elevation: 3,
                          backgroundColor: Theme.of(context).cardColor,
                        ))
                    .toList(),
              ),
            ),
          ..._overviewAndTagline(context, data),
        ],
      ),
    );
  }

  List<Widget> _overviewAndTagline(BuildContext context, dynamic data) {
    return [
      // if (data.tagline != null && data.tagline.isNotEmpty)
        ListTile(
          title: Text(
            data.tagline ?? '',
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(fontSize: 16, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ),
      ContentHorizontal(content: data.overview),
      Divider(indent: 8, endIndent: 8),
    ];
  }
}
