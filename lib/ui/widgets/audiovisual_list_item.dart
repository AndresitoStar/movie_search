import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/providers/audiovisuales_provider.dart';
import '../screens/audiovisual_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudiovisualListItem extends StatelessWidget {
  final _types = {'movie': 'Película', 'series': 'Serie', 'episode': 'Programa de TV'};

  @override
  Widget build(BuildContext context) {
    final audiovisual = Provider.of<AudiovisualProvider>(context, listen: false);

    return Card(
      elevation: 5,
      child: ListTile(
        onTap: () {
          Navigator.of(context)
              .push(PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 400),
                  pageBuilder: (context, __, ___) => ChangeNotifierProvider.value(
                      value: audiovisual,
                      child: AudiovisualDetail(
                        trending: false,
                      ))))
              .then((_) {
          });
        },
        title: Hero(
            tag: 'title-${audiovisual.id}',
            child: Material(
                color: Colors.transparent,
                child: Text(audiovisual.title, style: Theme.of(context).textTheme.headline6))),
        subtitle: Text('${_types[audiovisual.type]}/${audiovisual.year}',
            style: Theme.of(context).textTheme.subtitle2),
      ),
    );
  }
}
