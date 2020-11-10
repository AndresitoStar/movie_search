import 'package:movie_search/ui/widgets/audiovisual_grid.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/ui/widgets/theme_switcher.dart';

class TrendingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tendencia',
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
      ),
    );
  }
}
