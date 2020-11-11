import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/ui/widgets/hex_color.dart';
import '../screens/audiovisual_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'default_image.dart';

class AudiovisualGridItem extends StatelessWidget {
  final bool trending;

  const AudiovisualGridItem({Key key, this.trending}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audiovisual = Provider.of<AudiovisualProvider>(context);

    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 5,
      clipBehavior: Clip.hardEdge,
      color: trending ? Theme.of(context).cardTheme.color : Colors.white,
      child: GridTile(
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
          child: Hero(
            tag: audiovisual.id,
            child: Material(
              color: trending ? Theme.of(context).cardTheme.color : Colors.white,
              child: Padding(
                padding: EdgeInsets.all(trending ? 5 : 3),
                child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: audiovisual.data?.image ?? audiovisual.image,
                    placeholder: (_, __) => Container(
                        color: HexColor('#252525'),
                        child: Center(child: CircularProgressIndicator())),
                    errorWidget: (ctx, _, __) => Container(
                        color: HexColor('#252525'), child: Center(child: Icon(Icons.broken_image))),
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
          ),
        ),
        footer: trending ? GridTileBar(
            backgroundColor: Theme.of(context).cardTheme.color,
            subtitle: Text('${trending ? audiovisual.voteAverage : audiovisual.data.score}'),
            title: Text(
              audiovisual.title,
              maxLines: 2,
              style: Theme.of(context).textTheme.subtitle1,
            )) : null,
      ),
    );
  }

}
