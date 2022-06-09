import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:movie_search/providers/util.dart';

class DefaultPlaceholder extends StatelessWidget {
  const DefaultPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Colors.grey;
    final colorBaseValue =
        Theme.of(context).brightness == Brightness.dark ? 700 : 300;
    final colorHighlightValue =
        Theme.of(context).brightness == Brightness.dark ? 600 : 100;
    return Container(
        child: Shimmer.fromColors(
            baseColor: color[colorBaseValue]!,
            highlightColor: color[colorHighlightValue]!,
            child: Card(child: SizedBox.expand())));
  }
}

class GridItemPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Colors.grey;
    final int colorBaseValue =
        Theme.of(context).brightness == Brightness.dark ? 700 : 300;
    final colorHighlightValue =
        Theme.of(context).brightness == Brightness.dark ? 600 : 100;
    return Container(
      padding: const EdgeInsets.all(6),
      child: Card(
        elevation: 5,
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Expanded(
              child: Shimmer.fromColors(
                baseColor: color[colorBaseValue]!,
                highlightColor: color[colorHighlightValue]!,
                child: Container(
                  child: SizedBox.expand(),
                  decoration: BoxDecoration(color: context.theme.cardColor),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 10, top: 5),
              child: Shimmer.fromColors(
                baseColor: color[colorBaseValue]!,
                highlightColor: color[colorHighlightValue]!,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 1,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.white,
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      color: Colors.white,
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.white,
                    ),
                    // Container(
                    //   width: double.infinity,
                    //   height: 1,
                    //   margin:
                    //       EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    //   color: Colors.white,
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
