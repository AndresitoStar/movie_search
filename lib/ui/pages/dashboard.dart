import 'package:movie_search/providers/audiovisuales_provider.dart';
import 'package:movie_search/ui/pages/trending_page.dart';
import 'package:movie_search/ui/screens/movie_search_delegate.dart';
import 'package:movie_search/ui/widgets/audiovisual_grid_item.dart';
import 'package:movie_search/ui/widgets/hex_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    Provider.of<AudiovisualListProvider>(context).synchronizeDashboard(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'search',
        onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()),
//        backgroundColor: ,
        child: Icon(FontAwesomeIcons.search, color: HexColor('#252525')),
      ),
      body: Container(
        margin: MediaQuery.of(context).padding,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              pinned: false,
              backgroundColor: HexColor('#252525'),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 400),
                                pageBuilder: (_, __, ___) => TrendingPage())),
                        child: Card(
                          color: Colors.white54,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.solidStar,
                                color: Colors.orangeAccent,
                                size: 40,
                              ),
                              Text(
                                'Tendencia',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      )),
                      Expanded(
                          child: Card(
                        color: Colors.white54,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.solidHeart,
                              color: Colors.redAccent,
                              size: 40,
                            ),
                            Text(
                              'Favoritos',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              expandedHeight: (MediaQuery.of(context).size.height * 0.20),
            ),
            Consumer<AudiovisualListProvider>(
              builder: (context, provider, child) => provider.forDashboard.length > 0
                  ? SliverPadding(
                      padding: const EdgeInsets.all(10.0),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 3 / 5,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                        delegate: SliverChildBuilderDelegate(
                          (ctx, i) => i < provider.forDashboard.length
                              ? ChangeNotifierProvider.value(
                                  value: provider.forDashboard[i], child: AudiovisualGridItem())
                              : Container(),
                          childCount: provider.forDashboard.length + 1,
                        ),
                      ),
                    )
                  : SliverFillRemaining(
                      child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('Sin noticias que mostrar'),
                          FloatingActionButton(
                            onPressed: () => provider.synchronizeDashboard(context),
                            child: Icon(FontAwesomeIcons.newspaper),
                          )
                        ],
                      ),
                    )),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
