import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/ui/icons.dart';

import 'circular_button.dart';

class DialogImage extends StatefulWidget {
  final String imageUrl;

  const DialogImage({
    Key key,
    @required this.imageUrl,
  })  : assert(imageUrl != null),
        super(key: key);

  @override
  _DialogImageState createState() => _DialogImageState();

  static Future show({
    @required BuildContext context,
    @required String imageUrl,
  }) {
    return showDialog(
      context: context,
      builder: (context) => DialogImage(imageUrl: imageUrl),
    );
  }
}

class _DialogImageState extends State<DialogImage> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 6.0),
            child: Container(
                decoration: BoxDecoration(
              color: Colors.transparent,
            )),
          ),
          ExtendedImage.network(
            widget.imageUrl,
            fit: BoxFit.fitWidth,
            //enableLoadState: false,
            mode: ExtendedImageMode.gesture,
            initGestureConfigHandler: (state) => GestureConfig(
              minScale: 0.9,
              animationMinScale: 0.7,
              maxScale: 3.0,
              animationMaxScale: 3.5,
              speed: 1.0,
              inertialSpeed: 100.0,
              initialScale: 0.9,
              inPageView: true,
              initialAlignment: InitialAlignment.center,
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: MyCircularButton(
              icon: Icon(MyIcons.clear),
              onPressed: () => Navigator.of(context).pop(),
            ),
          )
        ],
      ),
    );
  }
}
