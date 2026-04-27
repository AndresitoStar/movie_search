import 'package:flutter/material.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:movie_search/common/ui/frino_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PlaceholderImage extends StatelessWidget {
  final double? height;

  const PlaceholderImage({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      constraints: BoxConstraints(maxHeight: 60.h),
      height: height,
      child: Image.asset(
        'assets/images/placeholder.jpg',
        // height: constraint.biggest.height,
        fit: BoxFit.contain,
        width: double.infinity,
      ),
    );
  }
}

class PlaceholderImagePerson extends StatelessWidget {
  final double? height;

  const PlaceholderImagePerson({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      constraints: BoxConstraints(maxHeight: 60.h),
      padding: .all(20),
      height: height,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Icon(FrinoIcons.f_male, color: Colors.black),
      ),
    );
  }
}

class DefaultPlaceholder extends StatelessWidget {
  const DefaultPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: context.theme.highlightColor.withValues(alpha: 0.5));
  }
}
