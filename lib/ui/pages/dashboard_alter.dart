import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/providers/audiovisuales_provider.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/screens/movie_search_delegate.dart';
import 'package:movie_search/ui/widgets/audiovisual_horizontal_item.dart';
import 'package:movie_search/ui/widgets/horizontal_list.dart';
import 'package:movie_search/ui/widgets/theme_switcher.dart';
import 'package:provider/provider.dart';

class DashBoardAlter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<AudiovisualListProvider>(context, listen: false).synchronizeDashboardAlter(context);
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        textTheme: Theme.of(context).textTheme,
        actionsIconTheme: Theme.of(context).iconTheme,
//        title: Text('Melon App'),
        leading: IconButton(
          onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()),
          icon: Icon(FontAwesomeIcons.search),
        ),
        actions: [
          IconButton(
            onPressed: () => null,
            icon: Icon(
              FontAwesomeIcons.solidHeart,
              color: Colors.redAccent,
            ),
          ),
//                IconButton(
//                  onPressed: () => Navigator.push(
//                      context,
//                      PageRouteBuilder(
//                          transitionDuration: Duration(milliseconds: 400),
//                          pageBuilder: (_, __, ___) => TrendingPage())),
//                  icon: Icon(
//                    FontAwesomeIcons.solidStar,
//                    color: Colors.orangeAccent,
//                  ),
//                ),
          MyEasyDynamicThemeBtn(),
        ],
      ),
      body: Container(
        child: Consumer<AudiovisualListProvider>(
            builder: (context, provider, child) => SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ListTile(
                          title: Text('Historial', style: Theme.of(context).textTheme.headline6)),
                      CarouselSlider(
                        options: CarouselOptions(
                            height: width * 0.6,
                            viewportFraction: 0.35,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration: Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.height),
                        items: provider.forDashboard.map((i) {
                          return Builder(
                            builder: (BuildContext context) =>
                                ChangeNotifierProvider<AudiovisualProvider>.value(
                              value: i,
                              child:
                                  AudiovisualHorizontalItem(trending: false, width: width * 0.36),
                            ),
                          );
                        }).toList(),
                      ),
//                      HorizontalList(
//                        gridContent: GRID_CONTENT.TRENDING_MOVIE,
//                        headline: 'Películas',
//                        list: provider.trendings,
//                        height: width * 0.6,
//                        width: width * 0.36,
//                      ),
//                      HorizontalList(
//                        gridContent: GRID_CONTENT.TRENDING_TV,
//                        headline: 'Programas de TV',
//                        list: provider.trendingSeries,
//                        height: width * 0.6,
//                        width: width * 0.36,
//                      ),
                    ],
                  ),
                )),
      ),
    );
  }
}
