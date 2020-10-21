import 'package:movie_search/ui/widgets/audiovisual_grid.dart';
import 'package:flutter/material.dart';

class TrendingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Tendencia'),
      ),
      body: AudiovisualGrid(),
    );
  }
}
