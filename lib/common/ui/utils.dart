import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:movie_search/common/model/tv.dart';
import 'package:movie_search/common/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ContentDivider extends StatelessWidget {
  const ContentDivider({super.key, required this.value});

  final String? value;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: value != null && value!.isNotEmpty && value != 'N/A',
      child: Container(
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5), child: Divider(height: 1)),
      ),
    );
  }
}

class ContentRow extends StatelessWidget {
  final String? label1;
  final String? value1;
  final String? label2;
  final String? value2;

  const ContentRow({super.key, this.value1, this.value2, this.label1, this.label2});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: value1 != null || value2 != null,
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
      ),
    );
  }
}

class ContentDynamic extends StatelessWidget {
  final List<String?>? labels;
  final List<String?>? values;

  const ContentDynamic({super.key, this.labels, this.values});

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
      ),
    );
  }
}

class ContentHorizontal extends StatelessWidget {
  final String? label;
  final String? content;
  final double padding;
  final Widget? subtitle;
  final TextStyle? contentStyle;
  final bool forceLight;
  final bool centered;

  const ContentHorizontal({
    super.key,
    this.label,
    this.content,
    this.padding = 0,
    this.subtitle,
    this.contentStyle,
    this.forceLight = false,
    this.centered = false,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: subtitle != null || (content != null && content!.isNotEmpty && content != 'N/A'),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: padding),
        // color: forceLight ? Colors.white10 : Theme.of(context).colorScheme.background,
        child: ListTile(
          title: label != null
              ? Text(
                  label!,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.theme.colorScheme.secondary,
                  ),
                  textAlign: centered ? TextAlign.center : TextAlign.start,
                )
              : null,
          subtitle:
              subtitle ??
              Text(
                content != null && content!.isNotEmpty ? content! : '',
                style: contentStyle ?? Theme.of(context).textTheme.titleMedium,
                textAlign: centered ? TextAlign.justify : TextAlign.start,
                overflow: .visible,
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
                        color: Colors.white,
                        colorBlendMode: BlendMode.dstATop,
                        width: 80,
                      ),
                    )
                  : Text(e.key, style: Theme.of(context).textTheme.titleMedium),
            )
            .toList(),
      ),
    );
  }
}

Future<T?> showBlurDialog<T>({
  required BuildContext context,
  required Widget child,
  double sigma = 6.0,
  Color barrierColor = Colors.black26,
  Duration transitionDuration = const Duration(milliseconds: 200),
}) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Dismiss',
    barrierColor: Colors.transparent,
    transitionDuration: transitionDuration,
    pageBuilder: (ctx, anim1, anim2) {
      return SafeArea(
        child: Stack(
          children: [
            // Blur de fondo
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
                child: Container(color: barrierColor.withOpacity(0.0)),
              ),
            ),
            // Tap fuera: cierra el diálogo
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => ctx.pop,
                child: Container(color: Colors.transparent, width: 100.w, height: 100.h,),
              ),
            ),
            // Contenido del diálogo; consumir taps para que no burbujeen al detector de atrás
            Center(
              child: GestureDetector(
                onTap: () {}, // consume taps dentro del diálogo
                child: Material(
                  color: Colors.transparent,
                  child: child,
                ),
              ),
            ),
          ],
        ),
      );
    },
    transitionBuilder: (ctx, anim, secAnim, widget) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
        child: widget,
      );
    },
  );
}