import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
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

class DashBoardAlter extends StatefulWidget {
  @override
  _DashBoardAlterState createState() => _DashBoardAlterState();
}

class _DashBoardAlterState extends State<DashBoardAlter> {

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
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                            title: Text('Recientes', style: Theme.of(context).textTheme.headline6)),
                        provider.forDashboard == null
                            ? LinearProgressIndicator()
                            : provider.forDashboard.length == 0
                                ? Center(child: Text('Aqui aparecerá lo que hayas visto...'))
                                : CarouselSlider(
                                    options: CarouselOptions(
                                        height: width,
                                        viewportFraction: 0.6,
                                        initialPage: 0,
                                        enableInfiniteScroll: true,
                                        reverse: false,
                                        autoPlay: true,
                                        autoPlayInterval: Duration(seconds: 3),
                                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        enlargeCenterPage: true,
                                        enlargeStrategy: CenterPageEnlargeStrategy.scale),
                                    items: provider.forDashboard.map((i) {
                                      return Builder(
                                        builder: (BuildContext context) =>
                                            ChangeNotifierProvider<AudiovisualProvider>.value(
                                          value: i,
                                          child: AudiovisualHorizontalItem(
                                              trending: false, width: width * 0.6),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                      ],
                    ),
                  ),
                ),
                HorizontalList(
                  gridContent: GRID_CONTENT.TRENDING_MOVIE,
                  headline: 'Películas',
                  list: provider.trendings,
                  width: width * 0.36,
                  height: width * 0.6,
                ),
                HorizontalList(
                  gridContent: GRID_CONTENT.TRENDING_TV,
                  headline: 'Series',
                  list: provider.trendingSeries,
                  width: width * 0.36,
                  height: width * 0.6,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}