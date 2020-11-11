import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
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
      tag: audiovisual.id,
      child: Material(
        color: withThemeColor ? Theme.of(context).cardTheme.color : Colors.white,
        child: Padding(
          padding: EdgeInsets.all(trending ? 5 : 3),
          child: ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(3),
            child: CachedNetworkImage(
              imageUrl: audiovisual.data?.image ?? audiovisual.image,
              placeholder: (_, __) => Container(
                  color: Colors.transparent, child: Center(child: CircularProgressIndicator())),
              errorWidget: (ctx, _, __) => Container(
                  color: Colors.transparent, child: Center(child: Icon(Icons.broken_image))),
              fit: BoxFit.cover,
//                        height: double.infinity,
//                        width: double.infinity,
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
                    child: ListTile(
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${trending ? audiovisual.voteAverage : audiovisual.data.score}'),
                            trending
                                ? StreamBuilder<List<String>>(
                                    stream: db.watchFavouritesId(),
                                    initialData: [],
                                    builder: (context, snapshot) => IconButton(
                                        onPressed: snapshot.data.contains(audiovisual.id)
                                            ? () => audiovisual.toggleFavourite(context: context)
                                            : null,
                                        icon: snapshot.data.contains(audiovisual.id)
                                            ? Icon(FontAwesomeIcons.solidHeart,
                                                color: Colors.redAccent)
                                            : Icon(FontAwesomeIcons.heart)))
                                : IconButton(
                                    onPressed: () => audiovisual.toggleFavourite(context: context),
                                    icon: audiovisual.isFavourite
                                        ? Icon(FontAwesomeIcons.solidHeart, color: Colors.redAccent)
                                        : Icon(FontAwesomeIcons.heart)),
                          ],
                        ),
                        title: Text(
                          audiovisual.title,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16),
                        )),
                  )
                ],
              )
            : hero,
      ),
    );
  }
}
