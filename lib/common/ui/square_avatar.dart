// dart
import 'package:flutter/material.dart';

class SquareAvatar extends StatelessWidget {
  final double size;
  final Color? backgroundColor;
  final Widget? child;
  final String? imageAsset;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  const SquareAvatar({
    super.key,
    this.size = 40,
    this.backgroundColor,
    this.child,
    this.imageAsset,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final br = borderRadius ?? BorderRadius.circular(8);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: br,
        child: ClipRRect(
          borderRadius: br,
          child: Container(
            width: size,
            height: size,
            color: backgroundColor ?? Theme.of(context).colorScheme.surface,
            child: imageAsset != null
                ? Image.asset(imageAsset!, fit: BoxFit.cover)
                : (child ?? const SizedBox.shrink()),
          ),
        ),
      ),
    );
  }
}