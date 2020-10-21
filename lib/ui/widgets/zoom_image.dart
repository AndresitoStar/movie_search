import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'default_image.dart';
import 'hex_color.dart';

class ZoomImage extends StatelessWidget {
  final String imageUrl;

  const ZoomImage({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: HexColor('#252525')),
      ),
      body: Container(
          color: Colors.white,
          child: Center(
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: double.infinity,
              placeholder: (_, __) => SizedBox(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (ctx, _, __) => Center(
                child: Text(
                  'Parece que ocurrio un error',
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Colors.black87),
                ),
              ),
//                  height: h * 0.8,
              fit: BoxFit.cover,
            ),
          )),
    );
  }
}
