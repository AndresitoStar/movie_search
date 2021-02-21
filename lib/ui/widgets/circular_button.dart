import 'package:flutter/material.dart';

class MyCircularButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;

  const MyCircularButton({
    Key key,
    @required this.icon,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget button = Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),
      ),
      child: IconButton(
        icon: icon,
        onPressed: onPressed,
      ),
    );

    return button;
  }
}
