import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search/common/domain/search_result.dart';
import 'package:movie_search/common/extensions/date_extensions.dart';
import 'package:movie_search/common/model/movie.dart';
import 'package:movie_search/common/model/person.dart';
import 'package:movie_search/common/model/tmdb_type.dart';
import 'package:movie_search/common/model/tv.dart';
import 'package:movie_search/common/ui/utils.dart';
import 'package:movie_search/features/audiovisual/ui/widgets/credits_horizontal.dart';
import 'package:movie_search/features/audiovisual/ui/widgets/item_detail_collection.dart';
import 'package:movie_search/features/audiovisual/ui/widgets/item_tv_season.dart';
import 'package:movie_search/features/audiovisual/ui/widgets/item_watch_provider_views.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ItemDetailSecondaryContent extends ConsumerWidget {
  final bool isSliver;
  final BaseSearchResult item;

  const ItemDetailSecondaryContent({required this.item, super.key, this.isSliver = true});

  @override
  Widget build(BuildContext context, viewModel) {
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
            child: Text(movie.homepage!, style: TextStyle(decoration: TextDecoration.underline)),
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
      if (movie.productionCompanies != null) ...[
        ContentDivider(value: movie.productionCompanies?.join(', ')),
        ContentHorizontal(
          padding: 8,
          label: 'Productora',
          // content: movie.productionCompanies?.join(', '),
          subtitle: LogosWidget.fromLogoList(movie.productionCompanies!),
          forceLight: Theme.of(context).brightness == Brightness.dark,
        ),
      ],
      if (movie.collection != null) ...[
        Divider(indent: 8, endIndent: 8),
        ItemCollectionView(collection: movie.collection!, sliver: false),
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
        label2: 'Duracion',
        value1: tvShow.firstAirDate == null ? null : DateTime.tryParse(tvShow.firstAirDate!)?.format,
        value2: tvShow.episodeRuntimeAverage == null ? null : '${tvShow.episodeRuntimeAverage} minutos',
      ),
      if (tvShow.seasons != null && tvShow.seasons!.isNotEmpty) ItemDetailTvSeasonView(sliver: false, model: tvShow),
      if (tvShow.createdByPerson != null && tvShow.createdByPerson!.isNotEmpty)
        PersonHorizontalList(persons: tvShow.createdByPerson!, tag: '${tvShow.id}'),
      if (tvShow.homepage != null && tvShow.homepage!.isNotEmpty)
        ContentHorizontal(
          padding: 8,
          label: 'Sitio Oficial',
          subtitle: GestureDetector(
            onTap: () => launchUrlString(tvShow.homepage!),
            child: Text(tvShow.homepage!, style: TextStyle(decoration: TextDecoration.underline)),
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
