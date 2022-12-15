import 'package:flutter/material.dart';
import 'package:movie_search/modules/home/custom_segmented_view_pages.dart';
import 'package:movie_search/modules/home/home_search_bar.dart';
import 'package:movie_search/modules/trending/trending_card.dart';
import 'package:movie_search/modules/trending/trending_viewmodel.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';
import 'package:movie_search/ui/widgets/theme_switcher.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final movieTrending = TrendingCard(
      content: TrendingContent.MOVIE,
      key: UniqueKey(),
    );
    final moviePopular = TrendingCard(
      content: TrendingContent.MOVIE,
      trendingType: TrendingType.POPULAR,
      key: UniqueKey(),
    );
    final tvTrending = TrendingCard(
      content: TrendingContent.TV,
      key: UniqueKey(),
    );
    final tvPopular = TrendingCard(
      content: TrendingContent.TV,
      trendingType: TrendingType.POPULAR,
      key: UniqueKey(),
    );
    final personTrending = TrendingCard(
      content: TrendingContent.PERSON,
      key: UniqueKey(),
    );
    final personPopular = TrendingCard(
      content: TrendingContent.PERSON,
      trendingType: TrendingType.POPULAR,
      key: UniqueKey(),
    );

    return CustomScaffold(
      bottomBarIndex: 0,
      body: Column(
        children: [
          AppBar(
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Image.asset('assets/images/ic_launcher.png'),
            ),
            actions: [MyThemeBtn()],
            title: Text('Movie Search'),
            titleSpacing: 0,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Bienvenido(a)',
                        style: theme.textTheme.headline5!.copyWith(color: theme.colorScheme.primary),
                      ),
                      subtitle: Text(
                        'Millones de películas, programas de televisión y personas por descubrir. Explora ahora.',
                        style: theme.textTheme.subtitle1!.copyWith(color: theme.hintColor),
                      ),
                    ),
                    Divider(),
                    HomeSearchBar(),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Peliculas',
                        style: theme.textTheme.headlineMedium!.copyWith(color: theme.colorScheme.primary),
                      ),
                    ),
                    CustomSegmentedPageView(
                      pages: [movieTrending, moviePopular],
                      tabs: ['Tendencia', 'Popular'],
                    ),
                    ListTile(
                      title: Text(
                        'Series y Televisión',
                        style: theme.textTheme.headlineMedium!.copyWith(color: theme.colorScheme.primary),
                      ),
                    ),
                    CustomSegmentedPageView(
                      pages: [tvTrending, tvPopular],
                      tabs: ['Tendencia', 'Popular'],
                    ),
                    ListTile(
                      title: Text(
                        'Personas',
                        style: theme.textTheme.headlineMedium!.copyWith(color: theme.colorScheme.primary),
                      ),
                    ),
                    CustomSegmentedPageView(
                      pages: [personTrending, personPopular],
                      tabs: ['Tendencia', 'Popular'],
                    ),
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
