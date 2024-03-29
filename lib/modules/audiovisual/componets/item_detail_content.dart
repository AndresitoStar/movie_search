import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_detail_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:stacked/stacked.dart';

import 'item_detail_ui_util.dart';

class ItemDetailMainContent extends ViewModelWidget<ItemDetailViewModel> {
  final bool isSliver;

  ItemDetailMainContent({this.isSliver = true});

  @override
  Widget build(BuildContext context, viewModel) {
    final BaseSearchResult item = viewModel.data!;

    String? originalTitle;
    String? overview;
    if (item.type == TMDB_API_TYPE.MOVIE) {
      originalTitle = item.movie!.originalTitle ?? '';
      overview = item.movie!.overview ?? '';
    } else if (item.type == TMDB_API_TYPE.TV_SHOW) {
      originalTitle = item.tvShow!.originalName ?? '';
      overview = item.tvShow!.overview ?? '';
    } else if (item.type == TMDB_API_TYPE.PERSON) {
      overview = item.person!.biography ?? '';
    }

    final children = <Widget>[
      Visibility(
        visible: originalTitle != item.title,
        child: ContentHorizontal(content: originalTitle, label: 'Título Original'),
      ),
      ContentHorizontal(
        content: overview,
        label: item.type == TMDB_API_TYPE.PERSON ? 'Biografía' : 'Sinopsis',
      ),
      // Divider(indent: 8, endIndent: 8),
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
