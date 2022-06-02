import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_detail_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:stacked/stacked.dart';

import 'item_detail_ui_util.dart';

class ItemDetailMainContent extends ViewModelWidget<ItemDetailViewModel> {
  final bool isSliver;

  ItemDetailMainContent({this.isSliver = true});

  @override
  Widget build(BuildContext context, viewModel) {
    final item = viewModel.data;
    final dynamic data = item.type == TMDB_API_TYPE.MOVIE ? item.movie : item.tvShow;
    final String originalTitle = item.type == TMDB_API_TYPE.MOVIE ? item.movie.originalTitle : item.tvShow.originalName;

    final children = <Widget>[
      // Text('${item.type.nameSingular}, ${item.status ?? ''}',
      //     textAlign: TextAlign.center),
      // if (data.tagline != null && data.tagline.isNotEmpty)
      //   ListTile(
      //     title: Text(
      //       data.tagline ?? '--',
      //       style: Theme.of(context).textTheme.caption.copyWith(fontSize: 16, fontStyle: FontStyle.italic),
      //       textAlign: TextAlign.center,
      //     ),
      //   ),
      Visibility(
        visible: originalTitle != item.title,
        child: ContentHorizontal(
          content: originalTitle,
          label: 'Título Original',
        ),
      ),
      ContentHorizontal(
        content: data.overview,
        label: 'Sinopsis',
      ),
      Divider(indent: 8, endIndent: 8),
    ];

    return isSliver
        ? SliverList(delegate: SliverChildListDelegate(children))
        : Column(
            children: children,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
          );
  }
}
