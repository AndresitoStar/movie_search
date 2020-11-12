import 'package:flutter/material.dart';

class InformationListItem extends StatelessWidget {
  final String label;
  final Widget trailing;
  final Function onPress;

  const InformationListItem({Key key, @required this.label, this.trailing, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        title: Text(label, style: Theme.of(context).textTheme.headline6),
        trailing: trailing,
      ),
    );
  }
}
