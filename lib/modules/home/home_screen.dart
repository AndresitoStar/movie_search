import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/home/home_search_bar.dart';
import 'package:movie_search/modules/trending/trending_horizontal_list.dart';
import 'package:movie_search/modules/trending/trending_viewmodel.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScaffold(
      bottomBarIndex: 0,
      body: Column(
        children: [
          AppBar(
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Image.asset('assets/images/ic_launcher.png'),
            ),
            title: Text('Movie Search'),
            titleSpacing: 0,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          ListTile(
                            title: Text(
                              'Bienvenido(a)',
                              style: theme.textTheme.headline5.copyWith(color: theme.colorScheme.primary),
                            ),
                            subtitle: Text(
                              'Millones de películas, programas de televisión y personas por descubrir. Explora ahora.',
                              style: theme.textTheme.subtitle1.copyWith(color: theme.hintColor),
                            ),
                          ),
                          SizedBox(height: 10),
                          HomeSearchBar(),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Divider(),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 320, child: TrendingHorizontalList(content: TrendingContent.MOVIE)),
                          Divider(height: 10),
                          SizedBox(height: 320, child: TrendingHorizontalList(content: TrendingContent.TV)),
                          Divider(),
                          SizedBox(
                            height: 320,
                            child: TrendingHorizontalList(
                              content: TrendingContent.MOVIE,
                              trendingType: TrendingType.POPULAR,
                            ),
                          ),
                          Divider(height: 10),
                          SizedBox(
                            height: 320,
                            child: TrendingHorizontalList(
                              content: TrendingContent.TV,
                              trendingType: TrendingType.POPULAR,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
