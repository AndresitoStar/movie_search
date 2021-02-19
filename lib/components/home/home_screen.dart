import 'package:flutter/material.dart';
import 'package:movie_search/components/home/home_search_bar.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomBarIndex: 0,
      body: Container(
        child: ListView(
          children: [
            HomeSearchBar()
          ],
        ),
      ),
    );
  }
}
