import 'package:flutter/material.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_detail_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:stacked/stacked.dart';

import 'item_detail_ui_util.dart';

class ItemDetailSecondaryContent extends ViewModelWidget<ItemDetailViewModel> {
  final bool isSliver;

  ItemDetailSecondaryContent({this.isSliver = true});

  @override
  Widget build(BuildContext context, viewModel) {
    final item = viewModel.data;
    final children = <Widget>[
      if (item.type == TMDB_API_TYPE.MOVIE)
        ..._movieContentWidgets(context, item.movie),
      if (item.type == TMDB_API_TYPE.TV_SHOW)
        ..._tvShowsContentWidgets(context, item.tvShow),
    ];
    return isSliver
        ? SliverList(delegate: SliverChildListDelegate(children))
        : Column(children: children);
  }

  List<Widget> _movieContentWidgets(BuildContext context, Movie movie) {
    return [
      ContentRow(
        label1: 'Pais',
        label2: 'Idioma',
        value1: movie.productionCountries,
        value2: movie.spokenLanguages,
      ),
      ContentRow(
        label1: 'Fecha de estreno',
        label2: 'Duración',
        value1: movie.releaseDate,
        value2: movie.runtime != null ? '${movie.runtime} minutos' : null,
      ),
      ContentDivider(value: movie.productionCompanies),
      ContentHorizontal(
          padding: 8, label: 'Productora', content: movie.productionCompanies),
    ];
  }

  List<Widget> _tvShowsContentWidgets(BuildContext context, TvShow tvShow) {
    return [
      ContentRow(
        label1: 'Temporadas',
        label2: 'Capitulos',
        value1: '${tvShow.numberOfSeasons ?? '-'}',
        value2: '${tvShow.numberOfEpisodes ?? '-'}',
      ),
      ContentRow(
        label1: 'Pais',
        label2: 'Idioma',
        value1: tvShow.productionCountries,
        value2: tvShow.spokenLanguages,
      ),
      ContentRow(
        label1: 'Fecha de estreno',
        label2: 'Duración',
        value1: tvShow.firstAirDate,
        value2: tvShow.episodeRunTime != null
            ? '${tvShow.episodeRunTime} minutos'
            : null,
      ),
      ContentRow(
        label1: 'Director',
        label2: 'Productora',
        value1: tvShow.createdBy,
        value2: tvShow.productionCompanies,
      ),
    ];
  }
}
