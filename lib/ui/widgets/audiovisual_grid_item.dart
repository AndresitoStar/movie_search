import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/providers/util.dart';
import 'package:provider/provider.dart';

import '../screens/audiovisual_detail_screen.dart';

class AudiovisualGridItem extends StatelessWidget {
  final bool trending;
  final bool showData;
  final bool withThemeColor;

  const AudiovisualGridItem(
      {Key key, this.trending, this.showData = true, this.withThemeColor = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audiovisual = Provider.of<AudiovisualProvider>(context);
    final hero = Hero(
      tag: '$trending${audiovisual.id}',
      child: Material(
        color: withThemeColor ? Theme.of(context).cardColor : Colors.white,
        child: Padding(
          padding: EdgeInsets.all(trending ? 5 : 3),
          child: ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(3),
            child: FutureBuilder<String>(
              future: audiovisual.checkImageCachedQuality(),
              initialData: URL_IMAGE_SMALL,
              builder: (context, snapshot) {
                return CachedNetworkImage(
                  imageUrl: '${snapshot.data}${audiovisual.image}',
                  placeholder: (_, __) => Container(
                      color: Colors.transparent, child: Center(child: CircularProgressIndicator())),
                  errorWidget: (ctx, _, __) => Container(
                      color: Colors.transparent, child: Center(child: Icon(FrinoIcons.f_image))),
                  fit: BoxFit.cover,
                );
              }
            ),
          ),
        ),
      ),
    );
    final db = Provider.of<MyDatabase>(context, listen: false);
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 5,
      clipBehavior: Clip.hardEdge,
      color: withThemeColor ? Theme.of(context).cardTheme.color : Colors.white,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 400),
              pageBuilder: (_, __, ___) => ChangeNotifierProvider.value(
                  value: audiovisual, child: AudiovisualDetail(trending: trending)),
            ),
          );
        },
        child: showData
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(flex: 5, child: hero),
                  Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        Positioned(
                            bottom: 12,
                            left: 12,
                            child: Text(
                              '${trending ? audiovisual.voteAverage : audiovisual.data.score ?? ''}',
                              style: Theme.of(context).textTheme.subtitle1,
                            )),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: StreamBuilder<bool>(
                            stream: audiovisual.loadingStreamController,
                            initialData: false,
                            builder: (_, loadingSnapshot) => loadingSnapshot.data
                                ? Container(
                                    padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.all(5),
                                    child: Center(
                                        child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(strokeWidth: 1),
                                    )),
                                  )
                                : StreamBuilder<List<String>>(
                                    stream: db.watchFavouritesId(),
                                    initialData: [],
                                    builder: (context, snapshot) => IconButton(
                                        onPressed: () =>
                                            audiovisual.toggleFavourite(context: context),
                                        alignment: Alignment.centerRight,
                                        icon: snapshot.data.contains(audiovisual.id) || (audiovisual.data?.isFavourite ?? false)
                                            ? Icon(FrinoIcons.f_heart, color: Colors.redAccent)
                                            : Icon(FrinoIcons.f_heart))),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            audiovisual.title ?? '' + '\n',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            : hero,
      ),
    );
  }
}
