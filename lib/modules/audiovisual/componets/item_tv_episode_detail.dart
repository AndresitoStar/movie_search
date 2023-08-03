import 'package:flutter/material.dart';
import 'package:movie_search/model/api/models/tv.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_appbar.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_main_image.dart';
import 'package:movie_search/modules/audiovisual/componets/items_images_button.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_episode_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/rest/resolver.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
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
              body: landscape ? _Landscape() : _Portrait(),
            ),
          ),
        );
      },
    );
  }
}

class _Portrait extends ViewModelWidget<ItemEpisodeDetailViewModel> {
  @override
  Widget build(BuildContext context, ItemEpisodeDetailViewModel model) {
    return CustomScrollView(
      cacheExtent: 1000,
      slivers: <Widget>[
        ItemDetailSliverAppBar(ContentImageWidget(model.episode.stillPath, fit: BoxFit.fitWidth)),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              _Content(),
            ],
          ),
        ),
      ],
    );
  }
}

class _Landscape extends ViewModelWidget<ItemEpisodeDetailViewModel> {
  @override
  Widget build(BuildContext context, ItemEpisodeDetailViewModel model) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ContentImageWidget(model.episode.stillPath, fit: BoxFit.fitWidth),
          SingleChildScrollView(
            child: _Content(),
            padding: EdgeInsets.symmetric(horizontal: 10.w),
          ),
        ],
      ),
    );
  }
}

class _Content extends ViewModelWidget<ItemEpisodeDetailViewModel> {
  @override
  Widget build(BuildContext context, ItemEpisodeDetailViewModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 10),
          Text(
            model.episode.name ?? '',
            textAlign: TextAlign.center,
            style: context.theme.textTheme.headlineMedium!.copyWith(fontStyle: FontStyle.italic),
          ),
          Text(
            '${model.season.name ?? 'Temporada ${model.season.seasonNumber}'} / Capítulo ${model.episode.episodeNumber}',
            textAlign: TextAlign.center,
            style: context.theme.textTheme.headlineSmall,
          ),
          Text(
            model.tvShow.name ?? '',
            textAlign: TextAlign.center,
            style: context.theme.textTheme.titleLarge,
          ),
          if (model.images.isNotEmpty && model.images.length > 1)
            ListTile(
              trailing: ShowImagesButton(
                title: model.episode.name ?? model.tvShow.name ?? '',
                images: {MediaImageType.BACKDROP: model.images},
              ),
            ),
          if (model.episode.overview != null && model.episode.overview!.isNotEmpty) ...[
            SizedBox(height: 20),
            Text(
              model.episode.overview ?? '',
              textAlign: TextAlign.center,
              style: context.theme.textTheme.bodyLarge,
            ),
          ],
          SizedBox(height: 20),
          if (model.isBusy)
            ...[1, 1, 1, 1, 1].map((e) => AspectRatio(aspectRatio: 16 / 9, child: GridItemPlaceholder())).toList()
          else if (model.videos.isNotEmpty)
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
                                style: context.theme.textTheme.titleMedium,
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
    );
  }
}
