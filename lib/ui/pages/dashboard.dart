import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/providers/audiovisuales_provider.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/screens/favs_screen.dart';
import 'package:movie_search/ui/screens/movie_search_delegate.dart';
import 'package:movie_search/ui/widgets/audiovisual_grid_item.dart';
import 'package:movie_search/ui/widgets/horizontal_list.dart';
import 'package:movie_search/ui/widgets/theme_switcher.dart';
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<MyDatabase>(context, listen: false);
    final size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return SafeArea(
      top: true,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverSafeArea(
                top: true,
                sliver: StreamBuilder<List<AudiovisualTableData>>(
                  stream: db.watchDashboard(),
                  initialData: [],
                  builder: (context, snapshot) => SliverAppBar(
                    floating: true,
                    pinned: true,
                    primary: true,
                    textTheme: Theme.of(context).textTheme,
                    actionsIconTheme: Theme.of(context).iconTheme,
                    expandedHeight:
                        !snapshot.hasData || snapshot.data.length == 0 ? 0 : height * 0.4,
                    leading: IconButton(
                      onPressed: () =>
                          showSearch(context: context, delegate: MovieSearchDelegate()),
                      icon: Icon(FontAwesomeIcons.search),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () => goToFavourites(context),
                        icon: Icon(
                          FontAwesomeIcons.solidHeart,
                          color: Colors.redAccent,
                        ),
                      ),
                      MyEasyDynamicThemeBtn(),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: Container(
                        padding: MediaQuery.of(context)
                            .padding
                            .copyWith(left: 0, right: 0, bottom: 0, top: 40),
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
                                        color: Colors.black12, // Inactive color
                                        activeColor: Colors.orangeAccent,
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
          body: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(<Widget>[
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
        ),
      ),
    );
  }

  Future goToFavourites(BuildContext context) {
    return Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 400),
            pageBuilder: (_, __, ___) => FavouriteScreen()));
  }
}

class AudiovisualListProviderHelper {
  static AudiovisualListProviderHelper _instance;

  Map<GRID_CONTENT, AudiovisualListProvider> _map = {};

  AudiovisualListProvider getProvider(GRID_CONTENT key) =>
      _map.putIfAbsent(key, () => AudiovisualListProvider(key));

  static AudiovisualListProviderHelper getInstance() {
    if (_instance == null) _instance = AudiovisualListProviderHelper._();
    return _instance;
  }

  AudiovisualListProviderHelper._();
}
