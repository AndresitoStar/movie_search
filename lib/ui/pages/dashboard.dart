import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:movie_search/providers/audiovisuales_provider.dart';
import 'package:movie_search/ui/pages/trending_page.dart';
import 'package:movie_search/ui/screens/movie_search_delegate.dart';
import 'package:movie_search/ui/widgets/audiovisual_grid_item.dart';
import 'package:movie_search/ui/widgets/hex_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_search/ui/widgets/theme_switcher.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<AudiovisualListProvider>(context).synchronizeDashboard(context);
    return Scaffold(
      body: Container(
//        margin: MediaQuery.of(context).padding,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              pinned: true,
              textTheme: Theme.of(context).textTheme,
              actionsIconTheme: Theme.of(context).iconTheme,
              title: Text('Melon App'),
              actions: [
                MyEasyDynamicThemeBtn(),
                IconButton(
                  onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()),
                  icon: Icon(FontAwesomeIcons.search),
                ),
                IconButton(
                  onPressed: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 400),
                          pageBuilder: (_, __, ___) => TrendingPage())),
                  icon: Icon(
                    FontAwesomeIcons.solidStar,
                    color: Colors.orangeAccent,
                  ),
                ),
                IconButton(
                  onPressed: () => null,
                  icon: Icon(
                    FontAwesomeIcons.solidHeart,
                    color: Colors.redAccent,
                  ),
                ),
              ],
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
                                  value: provider.forDashboard[i], child: AudiovisualGridItem(trending: false,))
                              : Container(),
                          childCount: provider.forDashboard.length,
                        ),
                      ),
                    )
                  : SliverFillRemaining(
                      child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('Busca peliculas o series...'),
//                          FloatingActionButton(
//                            onPressed: () => provider.synchronizeDashboard(context),
//                            child: Icon(FontAwesomeIcons.newspaper),
//                          )
                        ],
                      ),
                    )),
            ),
          ],
        ),
      ),
    );
  }
}
