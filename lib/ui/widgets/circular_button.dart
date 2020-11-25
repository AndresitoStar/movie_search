import 'package:flutter/material.dart';

/// An easier to use [IconButton] for [FloatingSearchBar]
/// actions.
class MyCircularButton extends StatelessWidget {
  // ignore: public_member_api_docs
  final Widget icon;

  // ignore: public_member_api_docs
  final VoidCallback onPressed;

  /// The size of this icon.
  ///
  /// When not specified, defaults to `24.0`.
  final double size;

  /// The padding of this icon.
  ///
  /// When not specified, defaults to
  /// `EdgeInsets.all(8)`.
  final EdgeInsets padding;

  // ignore: public_member_api_docs
  final String tooltip;
  final Color color;

  /// Creates an easier to use [IconButton] for
  /// [FloatingSearchBar] actions.
  const MyCircularButton({
    Key key,
    @required this.icon,
    @required this.onPressed,
    this.size = 12.0,
    this.color,
    this.padding = const EdgeInsets.all(8),
    this.tooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget button = Material(
      type: MaterialType.circle,
      color: color ?? Theme.of(context).appBarTheme.color,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Padding(
          padding: padding,
          child: icon,
        ),
      ),
    );

    if (tooltip != null) {
      button = Tooltip(
        message: tooltip ?? '',
        child: button,
      );
    }

    return button;
  }
}
