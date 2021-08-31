import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_like_button.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_detail_viewmodel.dart';
import 'package:movie_search/modules/imdb_rating/components/imdb_rating.dart';
import 'package:movie_search/modules/video/video_button.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:stacked/stacked.dart';

import 'item_detail_ui_util.dart';

class ItemDetailMainContent extends ViewModelWidget<ItemDetailViewModel> {
  final bool isSliver;

  ItemDetailMainContent({this.isSliver = true});

  @override
  Widget build(BuildContext context, viewModel) {
    final item = viewModel.data;
    final dynamic data =
        item.type == TMDB_API_TYPE.MOVIE ? item.movie : item.tvShow;

    final children = <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          item.title,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(color: Theme.of(context).accentColor),
        ),
      ),
      Text('${item.type.nameSingular}, ${item.status ?? ''}',
          textAlign: TextAlign.center),
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
            Row(
              children: [
                Icon(MyIcons.star, size: 18),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${item.voteAverage}',
                      style: Theme.of(context).textTheme.headline6),
                ),
                ImbdbRatingView(
                  item.id,
                  item.type.type,
                  imdbId: item.movie?.imdbId,
                )
              ],
            ),
            Expanded(child: Container()),
            VideoButton(param: item),
            ItemLikeButton(
                id: item.id, type: viewModel.data.type, iconSize: 42),
          ],
        ),
      ),
      if (item.genres != null && item.genres.isNotEmpty)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: item.genres
                .where((element) => element.isNotEmpty)
                .map((e) => Chip(
                      label: Text(e),
                      elevation: 3,
                      backgroundColor: Theme.of(context).primaryColor,
                    ))
                .toList(),
          ),
        ),
      ..._overviewAndTagline(context, data),
    ];
    return isSliver
        ? SliverList(delegate: SliverChildListDelegate(children))
        : Column(
            children: children,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
