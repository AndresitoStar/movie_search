import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_search/modules/home/content_type_widget.dart';
import 'package:movie_search/modules/home/genre_carousel.dart';
import 'package:movie_search/modules/home/home_movie_now_playing.dart';
import 'package:movie_search/modules/home/home_movie_top_rated.dart';
import 'package:movie_search/modules/home/home_movie_upcoming.dart';
import 'package:movie_search/modules/home/home_search_bar.dart';
import 'package:movie_search/modules/home/home_trending_all.dart';
import 'package:movie_search/modules/search/search_screen.dart';
import 'package:movie_search/ui/icons.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(SearchScreen.routeName),
        child: Icon(MyIcons.search),
      ),
      body: Column(
        children: [
          if (Device.screenType == ScreenType.mobile) ...[
            AppBar(
              title: ContentTypeWidget(),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(SearchScreen.routeName),
                  icon: Icon(MyIcons.search),
                ),
              ],
            ),
            Divider(height: 1, color: theme.colorScheme.onBackground),
          ],
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 10),
              child: RefreshIndicator(
                onRefresh: () => GetIt.instance<HomeController>().loading(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GenreCarouselWidget(),
                      HomeTrendingAllView(
                          window: TrendingWindow.DAY, key: UniqueKey()),
                      // HomeTrendingAllView(window: TrendingWindow.WEEK, key: UniqueKey()),
                      // CustomSegmentedPageView(
                      //   title: 'Lo Ultimo en Tendencia',
                      //   pages: [
                      //     HomeTrendingAllView(window: TrendingWindow.DAY, key: UniqueKey()),
                      //     HomeTrendingAllView(window: TrendingWindow.WEEK, key: UniqueKey()),
                      //   ],
                      //   tabs: [TrendingWindow.DAY.title, TrendingWindow.WEEK.title],
                      // ),
                      HomeNowPlayingView(key: UniqueKey()),
                      HomeUpcomingView(key: UniqueKey()),
                      HomeAiringView(key: UniqueKey()),
                      // CustomSegmentedPageView(
                      //   title: 'Lo Mas Popular',
                      //   pages: [
                      //     HomeNowPlayingView(key: UniqueKey()),
                      //     HomeUpcomingView(key: UniqueKey()),
                      //     HomeAiringView(key: UniqueKey()),
                      //   ],
                      //   tabs: ['Now Playing', 'Upcoming', 'Al Aire'],
                      // ),
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
