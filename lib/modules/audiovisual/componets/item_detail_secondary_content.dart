import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/model/api/models/movie.dart';
import 'package:movie_search/model/api/models/person.dart';
import 'package:movie_search/model/api/models/tv.dart';
import 'package:movie_search/modules/audiovisual/componets/item_collection.dart';
import 'package:movie_search/modules/audiovisual/componets/item_tv_season.dart';
import 'package:movie_search/modules/audiovisual/componets/item_watch_providers_view.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_detail_viewmodel.dart';
import 'package:movie_search/modules/person/components/person_horizontal_list.dart';
import 'package:movie_search/modules/themes/theme_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'item_detail_ui_util.dart';

class ItemDetailSecondaryContent extends ViewModelWidget<ItemDetailViewModel> {
  final bool isSliver;

  ItemDetailSecondaryContent({this.isSliver = true});

  @override
  Widget build(BuildContext context, viewModel) {
    final BaseSearchResult item = viewModel.data!;
    final children = <Widget>[
      if (item.type == TMDB_API_TYPE.MOVIE) ..._movieContentWidgets(context, item.movie!),
      if (item.type == TMDB_API_TYPE.TV_SHOW) ..._tvShowsContentWidgets(context, item.tvShow!),
      if (item.type == TMDB_API_TYPE.PERSON) ..._personContentWidgets(context, item.person!),
    ];
    return isSliver ? SliverList(delegate: SliverChildListDelegate(children)) : Column(children: children);
  }

  List<Widget> _movieContentWidgets(BuildContext context, Movie movie) {
    return [
      if (movie.homepage != null && movie.homepage!.isNotEmpty)
        ContentHorizontal(
          padding: 8,
          label: 'Sitio Oficial',
          subtitle: GestureDetector(
            onTap: () => launchUrl(Uri.parse(movie.homepage!)),
            child: Text(
              movie.homepage!,
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ContentRow(
        label1: 'Pais',
        label2: 'Idioma',
        value1: movie.productionCountries?.join(', '),
        value2: movie.spokenLanguages?.join(', '),
      ),
      if (movie.releaseDate?.isNotEmpty ?? false)
        ContentRow(
          label1: 'Fecha de estreno',
          label2: 'Duración',
          value1: DateTime.tryParse(movie.releaseDate!)?.format,
          value2: movie.runtime != null ? '${movie.runtime} minutos' : null,
        ),
      ContentDivider(value: movie.productionCompanies?.join(', ')),
      ContentHorizontal(
        padding: 8,
        label: 'Productora',
        // content: movie.productionCompanies?.join(', '),
        subtitle: LogosWidget.fromLogoList(movie.productionCompanies!),
        forceLight: Theme.of(context).brightness == Brightness.dark,
      ),
      if (movie.collection != null) ...[
        Divider(indent: 8, endIndent: 8),
        ItemCollectionView(
          collection: movie.collection!,
          sliver: false,
        ),
      ],
      ItemWatchProvidersView(type: TMDB_API_TYPE.MOVIE.type, id: movie.id),
    ];
  }

  List<Widget> _tvShowsContentWidgets(BuildContext context, TvShow tvShow) {
    return [
      ContentRow(
        label1: 'Pais',
        label2: 'Idioma',
        value1: tvShow.productionCountries?.join(', '),
        value2: tvShow.spokenLanguages?.join(', '),
      ),
      ContentRow(
        label1: 'Fecha de estreno',
        label2: 'Ultima emisión',
        value1: tvShow.firstAirDate == null ? null : DateTime.tryParse(tvShow.firstAirDate!)?.format,
        value2: tvShow.lastAirDate == null ? null : DateTime.tryParse(tvShow.lastAirDate!)?.format,
      ),
      if (tvShow.seasons != null && tvShow.seasons!.length > 0) ItemDetailTvSeasonView(false),
      if (tvShow.createdByPerson != null && tvShow.createdByPerson!.isNotEmpty)
        ListTile(
          title: Text(
            'Creadores',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
          ),
          subtitle: Container(
            height: 330,
            child: PersonHorizontalList(
              items: tvShow.createdByPerson!,
              tag: '${tvShow.id}',
            ),
          ),
        ),
      if (tvShow.homepage != null && tvShow.homepage!.isNotEmpty)
        ContentHorizontal(
          padding: 8,
          label: 'Sitio Oficial',
          subtitle: GestureDetector(
            onTap: () => launchUrlString(tvShow.homepage!),
            child: Text(
              tvShow.homepage!,
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      if (tvShow.productionCompanies != null && tvShow.productionCompanies!.isNotEmpty)
        ContentHorizontal(
          padding: 8,
          label: 'Productora',
          forceLight: true,
          // content: tvShow.productionCompanies.join(', '),
          subtitle: LogosWidget.fromLogoList(tvShow.productionCompanies!),
        ),
      if (tvShow.networks != null)
        ContentHorizontal(
          padding: 8,
          label: 'Cadenas Televisivas',
          forceLight: true,
          subtitle: LogosWidget.fromLogoList(tvShow.networks!),
        ),
      ItemWatchProvidersView(type: TMDB_API_TYPE.TV_SHOW.type, id: tvShow.id),
    ];
  }

  List<Widget> _personContentWidgets(BuildContext context, Person item) {
    return [
      ContentRow(
        label1: 'Conocida por',
        label2: 'Lugar de Nacimiento',
        value1: item.knownForDepartment,
        value2: item.placeOfBirth,
      ),
    ];
  }
}
