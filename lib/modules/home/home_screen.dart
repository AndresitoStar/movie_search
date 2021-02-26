import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/firebase_service.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/model/movie.dart';
import 'package:movie_search/modules/audiovisual/model/serie.dart';
import 'package:movie_search/modules/home/home_search_bar.dart';
import 'package:movie_search/modules/trending/trending_horizontal_list.dart';
import 'package:movie_search/modules/trending/trending_viewmodel.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseService.instance.configure(
      onMessage: (Map<String, dynamic> message) async {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.info,
          title: message['notification']['title'],
          text: message['notification']['body']
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        CoolAlert.show(
            context: context,
            type: CoolAlertType.info,
            title: 'On Launch',
            text: message['notification']['body']
        );
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        CoolAlert.show(
            context: context,
            type: CoolAlertType.info,
            title: 'On Resume',
            text: message['notification']['body']
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomBarIndex: 0,
      body: Container(
        padding: MediaQuery.of(context)
            .padding
            .copyWith(left: 0, right: 0, bottom: 0),
        child: Column(
          children: [
            HomeSearchBar(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  TrendingHorizontalList<Movie>(content: TrendingContent.MOVIE),
                  TrendingHorizontalList<TvShow>(content: TrendingContent.TV),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
