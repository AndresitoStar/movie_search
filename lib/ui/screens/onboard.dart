import 'package:flutter/material.dart';
import 'package:movie_search/modules/splash/splash_screen.dart';
import 'package:movie_search/providers/util.dart';

class OnboardScreen extends StatelessWidget {
  static String routeName = "Onboard";

  @override
  Widget build(BuildContext context) {
    final pages = [
      _getPage(
        context: context,
        assetImage: 'assets/images/o_1.webp',
        index: 0,
        text: 'DESCUBRE',
      ),
      _getPage(
        context: context,
        assetImage: 'assets/images/o_2.webp',
        index: 0,
        text: 'DISFRUTA',
      ),
      _getPage(
        context: context,
        assetImage: 'assets/images/o_3.webp',
        index: 0,
        text: 'COLECCIONA',
      ),
    ];
    return Scaffold(
      body: PageView.builder(
        
        itemBuilder: (context, i) => pages[i],
        itemCount: pages.length,
      ),
    );
  }

  Widget _getPage(
      {BuildContext context, String assetImage, String text, int index}) {
    return Container(
      color: Color(0xff141414),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            assetImage,
            fit: BoxFit.contain,
            width: double.infinity,
          ),
          Positioned(
            left: 0,
            right: 0,
            top: kToolbarHeight + 10,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  void navigateToHome(BuildContext context) {
    SharedPreferencesHelper.setFirstTime();
    Navigator.of(context)
        .pushNamedAndRemoveUntil(SplashScreen.route, (route) => false);
  }
}
