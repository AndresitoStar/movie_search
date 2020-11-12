import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/providers/audiovisuales_provider.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/widgets/audiovisual_grid_item.dart';
import 'package:movie_search/ui/widgets/horizontal_list.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _carouselStream = StreamController<num>.broadcast();

  @override
  void dispose() {
    _carouselStream.close();
    SharedPreferencesHelper.getInstance().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<MyDatabase>(context, listen: false);
    final size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return CustomScaffold(
      bottomBarIndex: 0,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              StreamBuilder<bool>(
                stream: SharedPreferencesHelper.getInstance().streamForRecent,
                initialData: false,
                builder: (context, snapshot) => Visibility(
                  visible: snapshot.data,
                  child: StreamBuilder<List<AudiovisualTableData>>(
                      stream: db.watchDashboard(),
                      initialData: [],
                      builder: (context, snapshot) {
                        return Container(
                          color: Theme.of(context).appBarTheme.color,
                          constraints: BoxConstraints(maxHeight: width - 100),
                          child: Stack(
                            fit: StackFit.expand,
                            alignment: Alignment.bottomCenter,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: CarouselSlider(
                                  options: CarouselOptions(
                                      viewportFraction: 8 / 16,
                                      initialPage: 0,
                                      enableInfiniteScroll: false,
                                      disableCenter: true,
                                      reverse: false,
                                      autoPlay: true,
                                      onScrolled: (index) => _carouselStream.add(index),
                                      autoPlayInterval: Duration(seconds: 3),
                                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      enlargeCenterPage: true,
                                      enlargeStrategy: CenterPageEnlargeStrategy.scale),
                                  items: snapshot.data.map((i) {
                                    return Builder(
                                      builder: (BuildContext context) =>
                                          ChangeNotifierProvider<AudiovisualProvider>.value(
                                        value: AudiovisualProvider.fromData(i),
                                        child: AspectRatio(
                                            child: AudiovisualGridItem(
                                              trending: false,
                                              showData: false,
                                              withThemeColor: false,
                                            ),
                                            aspectRatio: 3 / 5),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: StreamBuilder<num>(
                                    stream: _carouselStream.stream,
                                    initialData: 0,
                                    builder: (context, snapshotPages) {
                                      if (snapshot.data != null && snapshot.data.length == 0)
                                        return Text('');
                                      return DotsIndicator(
                                        mainAxisSize: MainAxisSize.min,
                                        dotsCount: snapshot.data?.length ?? 1,
                                        position: snapshotPages.data.toDouble(),
                                        decorator: DotsDecorator(
                                          color: EasyDynamicTheme.of(context).themeMode ==
                                                  ThemeMode.light
                                              ? Colors.black12
                                              : Colors.white12, // Inactive color
                                          activeColor: Colors.orangeAccent,
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
              ChangeNotifierProvider.value(
                  value: AudiovisualListProviderHelper.getInstance()
                      .getProvider(GRID_CONTENT.TRENDING_MOVIE),
                  child: HorizontalList(height: width * 0.75)),
              ChangeNotifierProvider.value(
                  value: AudiovisualListProviderHelper.getInstance()
                      .getProvider(GRID_CONTENT.TRENDING_TV),
                  child: HorizontalList(height: width * 0.75)),
            ]),
          ),
        ],
      ),
    );
  }
}
