import 'package:flutter/material.dart';
import 'package:movie_search/modules/home/home_movie_now_playing.dart';
import 'package:movie_search/modules/home/home_movie_top_rated.dart';
import 'package:movie_search/modules/home/home_movie_upcoming.dart';
import 'package:movie_search/modules/home/home_search_bar.dart';
import 'package:movie_search/modules/home/home_trending_all.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';
import 'package:movie_search/ui/widgets/theme_switcher.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'custom_segmented_view_pages.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final movieTrending = TrendingCard(content: TrendingContent.MOVIE, key: UniqueKey());
    // final moviePopular = TrendingCard(
    //   content: TrendingContent.MOVIE,
    //   trendingType: TrendingType.POPULAR,
    //   key: UniqueKey(),
    // );
    // final tvTrending = TrendingCard(content: TrendingContent.TV, key: UniqueKey());
    // final tvPopular = TrendingCard(
    //   content: TrendingContent.TV,
    //   trendingType: TrendingType.POPULAR,
    //   key: UniqueKey(),
    // );
    // final personTrending = TrendingCard(content: TrendingContent.PERSON, key: UniqueKey());
    // final personPopular = TrendingCard(
    //   content: TrendingContent.PERSON,
    //   trendingType: TrendingType.POPULAR,
    //   key: UniqueKey(),
    // );

    return CustomScaffold(
      bottomBarIndex: 0,
      body: Column(
        children: [
          if (Device.screenType == ScreenType.mobile)
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
                        style: theme.textTheme.headlineSmall!.copyWith(color: theme.colorScheme.primary),
                      ),
                      subtitle: Text(
                        'Millones de películas, programas de televisión y personas por descubrir. Explora ahora.',
                        style: theme.textTheme.titleMedium/*!.copyWith(color: theme.hintColor)*/,
                      ),
                    ),
                    Divider(),
                    HomeSearchBar(),
                    Divider(),
                    CustomSegmentedPageView(
                      title: 'Lo Ultimo en Tendencia',
                      pages: [
                        HomeTrendingAllView(window: TrendingWindow.DAY, key: UniqueKey()),
                        HomeTrendingAllView(window: TrendingWindow.WEEK, key: UniqueKey()),
                      ],
                      tabs: [TrendingWindow.DAY.title, TrendingWindow.WEEK.title],
                    ),
                    CustomSegmentedPageView(
                      title: 'Lo Mas Popular',
                      pages: [
                        HomeNowPlayingView(key: UniqueKey()),
                        HomeUpcomingView(key: UniqueKey()),
                        HomeAiringView(key: UniqueKey()),
                      ],
                      tabs: ['Now Playing', 'Upcoming', 'Al Aire'],
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
