import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/providers/audiovisuales_provider.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/screens/movie_search_delegate.dart';
import 'package:movie_search/ui/widgets/audiovisual_grid_item.dart';
import 'package:movie_search/ui/widgets/horizontal_list.dart';
import 'package:movie_search/ui/widgets/theme_switcher.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<MyDatabase>(context, listen: false);
    var width = MediaQuery.of(context).size.width;
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
                    expandedHeight: !snapshot.hasData || snapshot.data.length == 0 ? 0 : width,
                    leading: IconButton(
                      onPressed: () =>
                          showSearch(context: context, delegate: MovieSearchDelegate()),
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
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: Container(
                        padding: MediaQuery.of(context)
                            .padding
                            .copyWith(left: 0, right: 0, bottom: 0, top: 20),
                        child: CarouselSlider(
                          options: CarouselOptions(
                              height: width * 0.9,
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
                          items: snapshot.data.map((i) {
                            return Builder(
                              builder: (BuildContext context) =>
                                  ChangeNotifierProvider<AudiovisualProvider>.value(
                                value: AudiovisualProvider.fromData(i),
                                child: Container(
                                    child: AudiovisualGridItem(trending: false),
                                    width: width * 0.6),
                              ),
                            );
                          }).toList(),
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
                      value: AudiovisualListProviderHelper.getInstance().getProvider(GRID_CONTENT.TRENDING_MOVIE),
                      child: HorizontalList(width: width * 0.45, height: width * 0.75)),
                  ChangeNotifierProvider.value(
                      value: AudiovisualListProviderHelper.getInstance().getProvider(GRID_CONTENT.TRENDING_TV),
                      child: HorizontalList(width: width * 0.45, height: width * 0.75)),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
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
