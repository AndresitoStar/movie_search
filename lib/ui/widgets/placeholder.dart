import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DefaultPlaceholder extends StatelessWidget {
  const DefaultPlaceholder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Colors.grey;
    final colorBaseValue = Theme.of(context).brightness == Brightness.dark ? 700 : 300;
    final colorHighligthValue = Theme.of(context).brightness == Brightness.dark ? 600 : 100;
    return Container(
        child: Shimmer.fromColors(
            baseColor: color[colorBaseValue],
            highlightColor: color[colorHighligthValue],
            child: Card(child: SizedBox.expand())));
  }
}

class GridItemPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Colors.grey;
    final colorBaseValue = Theme.of(context).brightness == Brightness.dark ? 700 : 300;
    final colorHighligthValue = Theme.of(context).brightness == Brightness.dark ? 600 : 100;
    return Container(
      padding: const EdgeInsets.all(6),
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Shimmer.fromColors(
                baseColor: color[colorBaseValue],
                highlightColor: color[colorHighligthValue],
                child: Card(
                  child: SizedBox.expand(),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Shimmer.fromColors(
                  baseColor: color[colorBaseValue],
                  highlightColor: color[colorHighligthValue],
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
                      Container(
                        width: double.infinity,
                        height: 1,
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
