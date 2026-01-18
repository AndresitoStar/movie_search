import 'package:flutter/material.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:movie_search/common/ui/bottom_bar.dart';
import 'package:movie_search/common/ui/icons.dart';
import 'package:movie_search/common/ui/scaffold.dart';
import 'package:movie_search/features/home/ui/home_contents.dart';
import 'package:movie_search/features/home/ui/home_content_type_widget.dart';
import 'package:movie_search/features/home/ui/home_genre_carousel.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends StatelessWidget {
  static String routeName = "/home";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Device.screenType == ScreenType.mobile;
    return CustomScaffold(
      bottomBarIndex: 0,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: HomeGenreCarousel(key: UniqueKey()),
            ),
            HomeActualGenreCarousel(key: UniqueKey()),
            HomeTrendingWidget(key: UniqueKey()),
            HomePopularPersonWidget(key: UniqueKey()),
            HomePopularWidget(key: UniqueKey()),
            HomeUpcomingWidget(key: UniqueKey()),
            HomeNowPlayingWidget(key: UniqueKey()),
            HomeAiringTodayWidget(key: UniqueKey()),
            HomeOnTheAirWidget(key: UniqueKey()),
            HomeTopRatedWidget(key: UniqueKey()),
          ],
        ),
      ),
      appBar: CustomScaffoldAppbar(
        title: ContentTypeWidget(),
        customActions: [
          if (isMobile)
            IconButton(onPressed: context.goSearch, icon: Icon(MyIcons.search)),
        ],
        bottomBarIndex: 0,
      ),
    );
  }
}
