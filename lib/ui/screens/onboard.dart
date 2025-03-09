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
        text: 'DESCUBRE',
      ),
      _getPage(
        context: context,
        assetImage: 'assets/images/o_2.webp',
        text: 'DISFRUTA',
      ),
      _getPage(
        context: context,
        assetImage: 'assets/images/o_3.webp',
        text: 'COLECCIONA',
        last: true,
      ),
    ];
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (context, i) => pages[i],
        itemCount: pages.length,
      ),
    );
  }

  Widget _getPage({
    required BuildContext context,
    required String assetImage,
    required String text,
    bool last = false,
  }) {
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
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white70),
            ),
          ),
          if (last)
            Positioned(
              right: 10,
              bottom: 10,
              child: ElevatedButton(
                onPressed: () => navigateToHome(context),
                child: Text('Comenzar'),
                style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.secondary),
              ),
            ),
        ],
      ),
    );
  }

  void navigateToHome(BuildContext context) {
    SharedPreferencesHelper.setFirstTime();
    Navigator.of(context).pushNamedAndRemoveUntil(SplashScreen.route, (route) => false);
  }
}
