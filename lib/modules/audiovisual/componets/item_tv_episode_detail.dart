import 'package:flutter/material.dart';
import 'package:movie_search/model/api/models/tv.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_appbar.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_main_image.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_episode_viewmodel.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:stacked/stacked.dart';

class ItemEpisodeDetailPage extends StatelessWidget {
  final Episode episode;
  final TvShow tvShow;
  final Seasons season;
  final String heroTagPrefix;

  const ItemEpisodeDetailPage({
    Key? key,
    required this.season,
    required this.episode,
    required this.tvShow,
    this.heroTagPrefix = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final landscape = MediaQuery.of(context).size.aspectRatio > 0.7;
    return ViewModelBuilder<ItemEpisodeDetailViewModel>.reactive(
      viewModelBuilder: () => ItemEpisodeDetailViewModel(episode: episode, season: season, tvShow: tvShow),
      builder: (context, model, _) {
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SafeArea(
            top: true,
            child: Scaffold(
              floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
              floatingActionButton: landscape
                  ? FloatingActionButton.extended(
                      onPressed: () => Navigator.of(context).pop(),
                      label: Text('ATRAS'),
                      icon: Icon(MyIcons.arrow_left),
                    )
                  : null,
              body: landscape ? Container() : _Portrait(),
            ),
          ),
        );
      },
    );
  }
}

class _Portrait extends ViewModelWidget<ItemEpisodeDetailViewModel> {
  _Portrait();

  @override
  Widget build(BuildContext context, ItemEpisodeDetailViewModel model) {
    final theme = Theme.of(context).textTheme;
    return CustomScrollView(
      cacheExtent: 1000,
      slivers: <Widget>[
        ItemDetailSliverAppBar(ContentImageWidget(model.episode.stillPath, fit: BoxFit.fitWidth)),
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
                      model.episode.name ?? '',
                      textAlign: TextAlign.center,
                      style: theme.headline4,
                    ),
                    Text(
                      '${model.season.name ?? 'Temporada ${model.season.seasonNumber}'} / Capítulo ${model.episode.episodeNumber}',
                      textAlign: TextAlign.center,
                      style: theme.headline5,
                    ),
                    Text(
                      model.tvShow.name ?? '',
                      textAlign: TextAlign.center,
                      style: theme.headline6,
                    ),
                    if (model.episode.overview != null && model.episode.overview!.isNotEmpty) ...[
                      SizedBox(height: 20),
                      Text(
                        model.episode.overview ?? '',
                        textAlign: TextAlign.center,
                        style: theme.bodyText1,
                      ),
                    ],
                    SizedBox(height: 20),
                    if (model.isBusy)
                      ...[1, 1, 1, 1, 1]
                          .map((e) => AspectRatio(aspectRatio: 16 / 9, child: GridItemPlaceholder()))
                          .toList()
                    else if (model.videos.isEmpty) ...[Text('No existen videos')] else
                      ...model.videos
                          .map((video) => Card(
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
                                        title: Text(
                                          video.name ?? '',
                                          style: theme.subtitle1,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                      decoration: video.isYoutube
                                          ? null
                                          : BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                colorFilter: ColorFilter.mode(
                                                  Theme.of(context).colorScheme.background.withOpacity(0.7),
                                                  BlendMode.luminosity,
                                                ),
                                                image: NetworkImage(video.youtubeThumbnail),
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
