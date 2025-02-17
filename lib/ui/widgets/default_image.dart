import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PlaceholderImage extends StatelessWidget {
  final double? height;

  const PlaceholderImage({
    Key? key,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      constraints: BoxConstraints(maxHeight: 60.h),
      child: Image.asset(
        'assets/images/placeholder.jpg',
        // height: constraint.biggest.height,
        fit: BoxFit.contain,
        width: double.infinity,
      ),
      height: height,
    );
  }
}
