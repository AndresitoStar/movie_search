import 'package:flutter/material.dart';
import 'package:movie_search/model/api/models/tv.dart';
import 'package:movie_search/modules/audiovisual/componets/item_tv_episodes.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_detail_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/routes.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stacked/stacked.dart';

import 'item_detail_main_image.dart';

class ItemDetailTvSeasonView extends ViewModelWidget<ItemDetailViewModel> {
  final bool sliver;

  const ItemDetailTvSeasonView(this.sliver, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ItemDetailViewModel model) {
    final child = Stack(
      fit: StackFit.loose,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            image: model.data!.tvShow!.backdropPath == null
                ? null
                : DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      BlendMode.luminosity,
                    ),
                    image: NetworkImage(
                      '$URL_IMAGE_MEDIUM${model.data!.tvShow!.backdropPath}',
                    ),
                  ),
          ),
          child: ListTile(
            title: RichText(
              text: TextSpan(
                  text: 'Temporadas:',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                  children: [
                    TextSpan(
                      text: ' ${model.data!.tvShow!.numberOfSeasons}',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                    )
                  ]),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _SeasonCard(
                  season: model.data!.tvShow!.seasons!.last,
                  tvApi: model.data!.tvShow!,
                  isLast: true,
                ),
                Row(
                  children: [
                    Spacer(),
                    ElevatedButton(
                      onPressed: model.isBusy
                          ? null
                          : () => Navigator.of(context).push(
                                Routes.defaultRoute(
                                  null,
                                  _SeasonScreen(
                                    seasons: model.data!.tvShow!.seasons!,
                                    tv: model.data!.tvShow!,
                                  ),
                                ),
                              ),
                      child: Text('Ver todas...'),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
    return sliver ? SliverToBoxAdapter(child: child) : child;
  }
}

class _SeasonCard extends StatelessWidget {
  final Seasons season;
  final TvShow tvApi;
  final bool isLast;

  const _SeasonCard({Key? key, required this.season, this.isLast = false, required this.tvApi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          Routes.defaultRoute(
            null,
            EpisodesPage(
              season: season,
              tvApi: tvApi,
            ),
          ),
        ),
        child: Card(
          elevation: 10,
          clipBehavior: Clip.hardEdge,
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 9 / 16,
                child: ContentImageWidget(
                  season.posterPath,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (this.isLast)
                      Container(
                        color: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'Ultima',
                          style: Theme.of(context).primaryTextTheme.titleMedium,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            season.name ?? '',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Capitulos: ${season.episodeCount}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(height: 8),
                          Text(
                            season.overview ?? '',
                            maxLines: 3,
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SeasonScreen extends StatelessWidget {
  const _SeasonScreen({Key? key, required this.seasons, required this.tv}) : super(key: key);
  final List<Seasons> seasons;
  final TvShow tv;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tv.name ?? ''),
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(MyIcons.arrow_left),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Device.screenType == ScreenType.mobile
          ? ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: seasons.length,
              itemBuilder: (ctx, i) => _SeasonCard(
                season: seasons[i],
                isLast: i == seasons.length - 1,
                tvApi: tv,
              ),
            )
          : GridView.builder(
              itemCount: seasons.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: getColumns(context),
                childAspectRatio: 2.667,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (ctx, i) => _SeasonCard(
                season: seasons[i],
                isLast: i == seasons.length - 1,
                tvApi: tv,
              ),
            ),
    );
  }

  int getColumns(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return (width ~/ 350).clamp(1, 3);
  }
}
