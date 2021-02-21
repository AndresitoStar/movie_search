import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:movie_search/modules/splash/splash_screen.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/widgets/hex_color.dart';

class OnboardScreen extends StatelessWidget {
  static String routeName = "Onboard";

  @override
  Widget build(BuildContext context) {
    final titleStyle =
        Theme.of(context).textTheme.headline4.copyWith(color: Colors.white70);
    final pages = [
      PageViewModel(
        title: "",
        bodyWidget: Center(
            child: Image.asset(
          'assets/images/o_1.webp',
          fit: BoxFit.fill,
          width: double.infinity,
        )),
        footer: Text('DESCUBRE', style: titleStyle),
        decoration: const PageDecoration(
          titleTextStyle: TextStyle(color: Colors.orange),
          contentPadding: const EdgeInsets.all(0),
          bodyTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
        ),
      ),
      PageViewModel(
        title: "",
        bodyWidget: Center(
            child: Image.asset(
          'assets/images/o_2.webp',
          fit: BoxFit.fill,
          width: double.infinity,
        )),
        footer: Text('COMPARTE', style: titleStyle),
        decoration: const PageDecoration(
          titleTextStyle: TextStyle(color: Colors.orange),
          contentPadding: const EdgeInsets.all(0),
          bodyTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
        ),
      ),
      PageViewModel(
        title: "",
        bodyWidget: Center(
            child: Image.asset(
          'assets/images/o_3.webp',
          fit: BoxFit.fill,
          width: double.infinity,
        )),
        footer: Text('COLECCIONA', style: titleStyle),
        decoration: const PageDecoration(
          titleTextStyle: TextStyle(color: Colors.orange),
          contentPadding: const EdgeInsets.all(0),
          bodyTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
        ),
      ),
    ];
    return Scaffold(
      body: IntroductionScreen(
        pages: pages,
        onDone: () => navigateToHome(context),
        onSkip: () => navigateToHome(context),
        showSkipButton: true,
        skip: Text(
          'OMITIR',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.white70),
        ),
        next: const Icon(
          FrinoIcons.f_arrow_right,
          color: Colors.white70,
        ),
        done: Text("COMENZAR",
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.white70)),
        globalBackgroundColor: HexColor('#0A0A0A'),
        dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: Theme.of(context).primaryColor,
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }

  void navigateToHome(BuildContext context) {
    SharedPreferencesHelper.setFirstTime();
    Navigator.of(context)
        .pushNamedAndRemoveUntil(SplashScreen.route, (route) => false);
  }
}
