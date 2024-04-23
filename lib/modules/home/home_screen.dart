import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_search/modules/home/home_movie_now_playing.dart';
import 'package:movie_search/modules/home/home_movie_top_rated.dart';
import 'package:movie_search/modules/home/home_movie_upcoming.dart';
import 'package:movie_search/modules/home/home_search_bar.dart';
import 'package:movie_search/modules/home/home_trending_all.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';
import 'package:movie_search/ui/widgets/theme_switcher.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rxdart/rxdart.dart';

import 'custom_segmented_view_pages.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScaffold(
      bottomBarIndex: 0,
      body: Column(
        children: [
          if (Device.screenType == ScreenType.mobile) ...[
            AppBar(
              title: Text('Movie Search'),
              centerTitle: true,
            ),
            Divider(height: 1),
          ],
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 10),
              child: RefreshIndicator(
                onRefresh: () => GetIt.instance<HomeController>().loading(),
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
                          style: theme.textTheme.titleMedium /*!.copyWith(color: theme.hintColor)*/,
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
          ),
        ],
      ),
    );
  }
}

class HomeController {
  final _loadingSubject = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get loadingStream => _loadingSubject.stream;

  Future loading() async {
    _loadingSubject.add(true);
  }

  void finishLoading() {
    _loadingSubject.add(false);
  }
}
