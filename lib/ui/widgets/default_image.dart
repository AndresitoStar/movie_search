import 'package:flutter/material.dart';

class PlaceholderImage extends StatelessWidget {
  final double? height;

  const PlaceholderImage({
    Key? key,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: LayoutBuilder(
        // builder: (context, constraint) => Icon(
        //   MyIcons.default_image,
        //   color: Colors.grey.shade100,
        //   size: constraint.biggest.width,
        // ),
        builder: (context, constraint) => Image.asset(
          'assets/images/placeholder.jpg',
          height: constraint.biggest.height,
          fit: BoxFit.cover,
        ),
      ),
      height: height,
    );
  }
}
