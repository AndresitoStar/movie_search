import 'package:flutter/material.dart';

class ContentDivider extends StatelessWidget {
  const ContentDivider({
    Key key,
    @required this.value,
  }) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: value != null && value.isNotEmpty && value != 'N/A',
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Divider(height: 1),
        ),
      ),
    );
  }
}

class ContentRow extends StatelessWidget {
  final String label1;
  final String value1;
  final String label2;
  final String value2;

  const ContentRow(
      {Key key, this.value1, this.value2, this.label1, this.label2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: value1 != null && value2 != null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ContentDivider(value: value1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ContentHorizontal(
                        label: label1, content: value1),
                  ),
                  Expanded(
                    child: ContentHorizontal(
                        label: label2, content: value2),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

class ContentHorizontal extends StatelessWidget {
  final String label;
  final String content;
  final double padding;

  const ContentHorizontal({Key key, this.label, this.content, this.padding = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: content != null && content.isNotEmpty && content != 'N/A',
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: ListTile(
          title: label != null
              ? Text(label,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(fontWeight: FontWeight.bold))
              : null,
          subtitle: Text(content != null && content.isNotEmpty ? content : '',
              style: Theme.of(context).textTheme.subtitle1),
        ),
      ),
    );
  }
}
