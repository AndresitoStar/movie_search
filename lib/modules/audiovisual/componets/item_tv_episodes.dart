import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_search/model/api/models/tv.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_appbar.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_main_image.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_tv_season_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:stacked/stacked.dart';

class EpisodesPage extends StatelessWidget {
  final Seasons season;
  final TvShow tvApi;

  const EpisodesPage({Key key, @required this.season, @required this.tvApi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final landscape = MediaQuery.of(context).size.aspectRatio > 0.7;
    return ViewModelBuilder<ItemSeasonViewModel>.reactive(
      viewModelBuilder: () => ItemSeasonViewModel(season, tvApi),
      builder: (context, model, _) => Container(
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
            body:
                /* model.hasError
                ? Center(
                    child: Text('${model.modelError?.toString()}'),
                  )
                :  */
                landscape ? Container() : _Portrait(season),
          ),
        ),
      ),
    );
  }
}

class _Portrait extends ViewModelWidget<ItemSeasonViewModel> {
  final Seasons season;

  _Portrait(this.season);

  @override
  Widget build(BuildContext context, ItemSeasonViewModel model) {
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
                      season.name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(height: 20),
                    Text(
                      season.overview,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(height: 20),
                    if (!model.isBusy && model.season?.episodes != null)
                      ...model.season.episodes
                          .map((e) => Card(
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
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Capítulo: ${e.episodeNumber}',
                                              style: Theme.of(context).textTheme.subtitle1,
                                              textAlign: TextAlign.end,
                                            ),
                                            Text(
                                              e.name,
                                              style: Theme.of(context).textTheme.headline6,
                                              textAlign: TextAlign.end,
                                            ),
                                            Text(
                                              e.overview,
                                              style: Theme.of(context).textTheme.caption,
                                              textAlign: TextAlign.end,
                                            ),
                                            Divider(indent: 8, endIndent: 8),
                                            Text(
                                              DateTime.tryParse(e.airDate).format,
                                              textAlign: TextAlign.end,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: e.stillPath == null
                                          ? null
                                          : BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                colorFilter: ColorFilter.mode(
                                                  Theme.of(context).colorScheme.background.withOpacity(0.7),
                                                  BlendMode.luminosity,
                                                ),
                                                image: NetworkImage('$URL_IMAGE_MEDIUM${e.stillPath}'),
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
