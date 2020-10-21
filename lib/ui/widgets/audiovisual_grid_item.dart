import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/ui/widgets/hex_color.dart';
import '../screens/audiovisual_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'default_image.dart';

class AudiovisualGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audiovisual = Provider.of<AudiovisualProvider>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 400),
                pageBuilder: (_, __, ___) => ChangeNotifierProvider.value(
                    value: audiovisual,
                    child: AudiovisualDetail(
                      trending: true,
                    )),
              ),
            );
          },
          splashColor: Colors.white,
          child: Hero(
            tag: audiovisual.id,
            child: Material(
              child: CachedNetworkImage(
                imageUrl: audiovisual.image,
                placeholder: (_, __) => Container(
                    color: HexColor('#252525'), child: Center(child: CircularProgressIndicator())),
                errorWidget: (ctx, _, __) => Container(
                    color: HexColor('#252525'), child: Center(child: Icon(Icons.broken_image))),
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          ),
        ),
        footer: GridTileBar(
            backgroundColor: HexColor('#252525'),
            title: Text(
              audiovisual.title,
              maxLines: 2,
              style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
            )),
      ),
    );
  }

  Color getRatingColor(String score) {
    try {
      var d = double.parse(score);
      if (d < 6) {
        return Colors.redAccent;
      } else if (d < 9) {
        return Colors.yellowAccent;
      }
      return Colors.greenAccent;
    } catch (e) {
      return HexColor('#252525');
    }
  }
}
