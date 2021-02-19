import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:provider/provider.dart';

import '../screens/audiovisual_detail_screen.dart';

class AudiovisualListItem extends StatelessWidget {
  final _types = {'movie': 'Película', 'tv': 'Serie', 'person': 'Persona'};
  final AudiovisualProvider audiovisual;

  AudiovisualListItem({Key key, @required this.audiovisual}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: ListTile(
        // children: [
        //   Visibility(
        //       visible: audiovisual.sinopsis != null &&
        //           audiovisual.sinopsis.isNotEmpty,
        //       child: Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 20),
        //         child: Text(
        //           audiovisual.sinopsis ?? '-',
        //           maxLines: 3,
        //           overflow: TextOverflow.ellipsis,
        //         ),
        //       )),
        //   Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       FlatButton(
        //           onPressed: () {
        //             Navigator.of(context).push(PageRouteBuilder(
        //                 transitionDuration: Duration(milliseconds: 400),
        //                 pageBuilder: (context, __, ___) =>
        //                     ChangeNotifierProvider.value(
        //                         value: audiovisual,
        //                         child: AudiovisualDetail(trending: false))));
        //           },
        //           child: Text('Ver mas...'))
        //     ],
        //   )
        // ],
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 400),
              pageBuilder: (context, __, ___) => ChangeNotifierProvider.value(
                  value: audiovisual,
                  child: AudiovisualDetail(trending: false))));
        },
        title: Hero(
            tag: 'title-${audiovisual.id}',
            child: Material(
              color: Colors.transparent,
              child: Text(audiovisual.title,
                  style: Theme.of(context).textTheme.headline6),
            )),
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(audiovisual.titleOriginal,
                style: Theme.of(context).textTheme.subtitle1),
            Text('${_types[audiovisual.type]}/${audiovisual.year ?? '-'}',
                style: Theme.of(context).textTheme.caption),
          ],
        ),
      ),
    );
  }
}
