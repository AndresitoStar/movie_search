import 'package:flutter/material.dart';

class MyCircularButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final Color? color;

  const MyCircularButton({
    Key? key,
    required this.icon,
    this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget button = Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color ?? Theme.of(context).buttonTheme.colorScheme!.surface,
      ),
      child: IconButton(
        icon: icon,
        onPressed: onPressed,
      ),
    );

    return button;
  }
}
