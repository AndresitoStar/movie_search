import 'package:flutter/material.dart';
import 'package:movie_search/model/api/models/tv.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_appbar.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_main_image.dart';
import 'package:movie_search/modules/audiovisual/componets/item_tv_episode_detail.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_tv_season_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/routes.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stacked/stacked.dart';

class EpisodesPage extends StatelessWidget {
  final Seasons season;
  final TvShow tvApi;

  const EpisodesPage({Key? key, required this.season, required this.tvApi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ItemSeasonViewModel>.reactive(
      viewModelBuilder: () => ItemSeasonViewModel(season, tvApi),
      builder: (context, model, _) => Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          top: true,
          child: Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
            floatingActionButton: Device.screenType != ScreenType.mobile
                ? FloatingActionButton.extended(
                    onPressed: () => Navigator.of(context).pop(),
                    label: Text('ATRAS'),
                    icon: Icon(MyIcons.arrow_left),
                  )
                : null,
            body:
                /* model.hasError
                ? Center(
                    child: Text('${model.modelError?.toString()}'),
                  )
                :  */
                Device.screenType != ScreenType.mobile ? _Landscape(season, tvApi) : _Portrait(season, tvApi),
          ),
        ),
      ),
    );
  }
}

class _Portrait extends ViewModelWidget<ItemSeasonViewModel> {
  final Seasons season;
  final TvShow tvShow;

  _Portrait(this.season, this.tvShow);

  @override
  Widget build(BuildContext context, ItemSeasonViewModel model) {
    final theme = Theme.of(context).textTheme;
    return CustomScrollView(
      cacheExtent: 1000,
      slivers: <Widget>[
        ItemDetailSliverAppBar(ContentImageWidget(season.posterPath, fit: BoxFit.fitWidth)),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      tvShow.name ?? '',
                      textAlign: TextAlign.center,
                      style: theme.headlineMedium,
                    ),
                    Text(
                      season.name ?? '',
                      textAlign: TextAlign.center,
                      style: theme.headlineSmall,
                    ),
                    if (season.overview != null && season.overview!.isNotEmpty) ...[
                      SizedBox(height: 20),
                      Text(
                        season.overview ?? '',
                        textAlign: TextAlign.center,
                        style: theme.bodyLarge,
                      ),
                    ],
                    SizedBox(height: 20),
                    if (model.isBusy)
                      ...[1, 1, 1, 1, 1]
                          .map((e) => AspectRatio(aspectRatio: 16 / 9, child: GridItemPlaceholder()))
                          .toList()
                    else if (model.season.episodes != null)
                      ...model.season.episodes!
                          .map((episode) => Card(
                                margin: const EdgeInsets.only(
                                  bottom: 20,
                                  left: 10,
                                  right: 10,
                                ),
                                clipBehavior: Clip.hardEdge,
                                // elevation: 0,
                                // color: Colors.transparent,
                                child: Stack(
                                  children: [
                                    Container(
                                      child: ListTile(
                                        onTap: () => Navigator.of(context).push(
                                          Routes.defaultRoute(
                                            null,
                                            ItemEpisodeDetailPage(
                                              episode: episode,
                                              season: season,
                                              tvShow: tvShow,
                                              heroTagPrefix: '${tvShow.id}-${season.id}-${episode.id}',
                                            ),
                                          ),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Capítulo: ${episode.episodeNumber}',
                                              style: theme.titleMedium,
                                              textAlign: TextAlign.end,
                                            ),
                                            Text(
                                              episode.name ?? '',
                                              style: theme.titleLarge,
                                              textAlign: TextAlign.end,
                                            ),
                                            Text(
                                              episode.overview ?? '',
                                              style: theme.bodySmall,
                                              textAlign: TextAlign.end,
                                            ),
                                            Divider(indent: 8, endIndent: 8),
                                            if (episode.airDate != null && episode.airDate!.isNotEmpty)
                                              Text(
                                                DateTime.tryParse(episode.airDate!)?.format ?? '',
                                                textAlign: TextAlign.end,
                                              ),
                                          ],
                                        ),
                                      ),
                                      decoration: episode.stillPath == null
                                          ? null
                                          : BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                colorFilter: ColorFilter.mode(
                                                  Theme.of(context).colorScheme.background.withOpacity(0.7),
                                                  BlendMode.luminosity,
                                                ),
                                                image: NetworkImage('$URL_IMAGE_MEDIUM${episode.stillPath}'),
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList()
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Landscape extends ViewModelWidget<ItemSeasonViewModel> {
  final Seasons season;
  final TvShow tvShow;

  _Landscape(this.season, this.tvShow);

  @override
  Widget build(BuildContext context, ItemSeasonViewModel model) {
    final theme = Theme.of(context).textTheme;
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            children: [
              if (season.posterPath != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: ContentImageWidget(season.posterPath, fit: BoxFit.fitWidth),
                ),
              SizedBox(height: 10),
              Text(
                tvShow.name ?? '',
                textAlign: TextAlign.center,
                style: theme.headlineMedium,
              ),
              Text(
                season.name ?? '',
                textAlign: TextAlign.center,
                style: theme.headlineSmall,
              ),
              if (season.overview != null && season.overview!.isNotEmpty) ...[
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Text(
                        season.overview!,
                        textAlign: TextAlign.center,
                        style: theme.bodyLarge,
                      ),
                    ),
                  ),
                )
              ] else
                Spacer(),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  if (model.isBusy)
                    ...[1, 1, 1, 1, 1]
                        .map((e) => AspectRatio(aspectRatio: 16 / 9, child: GridItemPlaceholder()))
                        .toList()
                  else if (model.season.episodes != null)
                    ...model.season.episodes!
                        .map((episode) => Card(
                              margin: const EdgeInsets.only(
                                bottom: 20,
                                left: 10,
                                right: 10,
                              ),
                              clipBehavior: Clip.hardEdge,
                              // elevation: 0,
                              // color: Colors.transparent,
                              child: Stack(
                                children: [
                                  Container(
                                    child: ListTile(
                                      onTap: () => Navigator.of(context).push(
                                        Routes.defaultRoute(
                                          null,
                                          ItemEpisodeDetailPage(
                                            episode: episode,
                                            season: season,
                                            tvShow: tvShow,
                                            heroTagPrefix: '${tvShow.id}-${season.id}-${episode.id}',
                                          ),
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Capítulo: ${episode.episodeNumber}',
                                            style: theme.titleMedium,
                                            textAlign: TextAlign.end,
                                          ),
                                          Text(
                                            episode.name ?? '',
                                            style: theme.titleLarge,
                                            textAlign: TextAlign.end,
                                          ),
                                          Text(
                                            episode.overview ?? '',
                                            style: theme.bodySmall,
                                            textAlign: TextAlign.end,
                                          ),
                                          Divider(indent: 8, endIndent: 8),
                                          if (episode.airDate != null && episode.airDate!.isNotEmpty)
                                            Text(
                                              DateTime.tryParse(episode.airDate!)?.format ?? '',
                                              textAlign: TextAlign.end,
                                            ),
                                        ],
                                      ),
                                    ),
                                    decoration: episode.stillPath == null
                                        ? null
                                        : BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              colorFilter: ColorFilter.mode(
                                                Theme.of(context).colorScheme.background.withOpacity(0.7),
                                                BlendMode.luminosity,
                                              ),
                                              image: NetworkImage('$URL_IMAGE_MEDIUM${episode.stillPath}'),
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ))
                        .toList()
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
