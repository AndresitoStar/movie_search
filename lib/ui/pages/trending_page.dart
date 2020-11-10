import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/widgets/audiovisual_grid.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/ui/widgets/theme_switcher.dart';

class TrendingPage extends StatelessWidget {
  final GRID_CONTENT gridContent;

  const TrendingPage({Key key, this.gridContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          gridContent.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [MyEasyDynamicThemeBtn()],
      ),
      body: AudiovisualGrid(
        trending: true,
        gridContent: gridContent,
      ),
    );
  }
}
