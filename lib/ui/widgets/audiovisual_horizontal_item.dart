import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/ui/widgets/hex_color.dart';
import '../screens/audiovisual_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'default_image.dart';

class AudiovisualHorizontalItem extends StatelessWidget {
  final bool trending;
  final double width;

  const AudiovisualHorizontalItem({Key key, this.trending, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audiovisual = Provider.of<AudiovisualProvider>(context, listen: false);

    return Container(
      width: width,
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: Theme.of(context).cardTheme.color,
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
                color: Theme.of(context).cardTheme.color,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: audiovisual.image,
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
          footer: GridTileBar(
              backgroundColor: Theme.of(context).cardTheme.color,
              title: Text(
                audiovisual.title,
                maxLines: 2,
                style: Theme.of(context).textTheme.subtitle1,
              )),
        ),
      ),
    );
  }
}
