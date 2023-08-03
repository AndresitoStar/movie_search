import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/model/api/models/tv.dart';
import 'package:movie_search/modules/themes/theme_viewmodel.dart';
import 'package:movie_search/providers/util.dart';

class ContentDivider extends StatelessWidget {
  const ContentDivider({
    Key? key,
    required this.value,
  }) : super(key: key);

  final String? value;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: value != null && value!.isNotEmpty && value != 'N/A',
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
  final String? label1;
  final String? value1;
  final String? label2;
  final String? value2;

  const ContentRow({Key? key, this.value1, this.value2, this.label1, this.label2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: value1 != null && value2 != null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ContentDivider(value: 'value1'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (value1 != null && value1!.isNotEmpty)
                    Expanded(
                      child: ContentHorizontal(label: label1, content: value1),
                    ),
                  if (value2 != null && value2!.isNotEmpty)
                    Expanded(
                      child: ContentHorizontal(label: label2, content: value2),
                    ),
                ],
              ),
            ],
          ),
        ));
  }
}

class ContentDynamic extends StatelessWidget {
  final List<String?>? labels;
  final List<String?>? values;

  const ContentDynamic({Key? key, this.labels, this.values}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (labels == null || values == null) return Container();
    return Visibility(
        visible: labels != null && values != null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ContentDivider(value: 'value1'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (var i = 0; i < labels!.length; i++)
                    values![i] != null
                        ? Expanded(
                            child: ContentHorizontal(label: labels![i], content: values![i]),
                          )
                        : Container(),
                ],
              ),
            ],
          ),
        ));
  }
}

class ContentHorizontal extends StatelessWidget {
  final String? label;
  final String? content;
  final double padding;
  final Widget? subtitle;
  final TextStyle? contentStyle;
  final bool forceLight;

  const ContentHorizontal(
      {Key? key, this.label, this.content, this.padding = 0, this.subtitle, this.contentStyle, this.forceLight = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Visibility(
      visible: subtitle != null || (content != null && content!.isNotEmpty && content != 'N/A'),
      child: Theme(
        data: forceLight ? ThemeViewModel.of(context).theme : Theme.of(context),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: padding),
          color: forceLight ? Colors.white70 : Theme.of(context).colorScheme.background,
          child: ListTile(
            title: label != null
                ? Text(
                    label!,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: forceLight ? Theme.of(context).primaryColorDark : primaryColor,
                        ),
                  )
                : null,
            subtitle: subtitle ??
                Text(
                  content != null && content!.isNotEmpty ? content! : '',
                  style: contentStyle ?? Theme.of(context).textTheme.titleMedium,
                ),
          ),
        ),
      ),
    );
  }
}

class LogosWidget extends StatelessWidget {
  final List<MapEntry<String, String?>> list;

  const LogosWidget({super.key, required this.list});

  static LogosWidget fromLogoList(List<Logo> list) =>
      LogosWidget(list: list.map((e) => MapEntry(e.name!, e.logoPath)).toList());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Theme(
        data: ThemeViewModel.of(context).theme,
        child: Wrap(
          runSpacing: 8,
          spacing: 10,
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: list
              .map(
                (e) => e.value != null
                    ? Tooltip(
                        message: e.key,
                        child: CachedNetworkImage(
                          imageUrl: '$URL_IMAGE_MEDIUM${e.value}',
                          width: 80,
                        ),
                      )
                    : Text(
                        e.key,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
              )
              .toList(),
        ),
      ),
    );
  }
}
