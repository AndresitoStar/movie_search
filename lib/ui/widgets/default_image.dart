import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';

class PlaceholderImage extends StatelessWidget {
  final double height;

  const PlaceholderImage({
    Key key,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(child: Icon(FrinoIcons.f_image, size: height / 3)),
      height: height,
    );
  }
}
