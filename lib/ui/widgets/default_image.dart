import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'hex_color.dart';

class PlaceholderImage extends StatelessWidget {
  final double heigth;

  const PlaceholderImage({
    Key key,
    this.heigth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            FontAwesomeIcons.solidImage,
            color: Colors.white12,
            size: MediaQuery.of(context).size.width / 3,
          ),
//          Container(height: 10,),
          Text(
            'Presione para ver portada',
            style:
                Theme.of(context).textTheme.title.copyWith(color: Colors.white),
          )
        ],
      ),
      color: Colors.transparent,
    );
  }
}
