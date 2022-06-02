import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movie_search/modules/home/home_screen.dart';
import 'package:movie_search/modules/splash/splash_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class SplashScreen extends StatelessWidget {
  static String route = "/splash";

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: model.hasError
            ? _buildError(context, model)
            : model.isBusy
                ? _buildBusyIndicator(context)
                : Builder(builder: (context) {
                    _navigateHome(context);
                    return _buildBusyIndicator(context);
                  }),
      ),
      viewModelBuilder: () => SplashViewModel(context.read()),
    );
  }

  _buildError(BuildContext context, SplashViewModel model) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.network_locked, size: 160),
            SizedBox(height: 20),
            Text('Parece que ocurrio un error, verifica que tengas conexión a Internet.',
                textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline6),
          ],
        ),
      );

  _buildBusyIndicator(BuildContext context) {
    final strokeWidth = 10.0;
    final imageSize = 200.0;

    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/images/ic_launcher.png',
            width: imageSize,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: imageSize + strokeWidth,
            width: imageSize + strokeWidth,
            child: CircularProgressIndicator(strokeWidth: strokeWidth),
          ),
        ),
        Positioned(
          bottom: 100,
          left: 10,
          right: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Movie Search', style: context.theme.textTheme.headline5),
              SizedBox(height: 10),
              Text('by Andrés Forns', style: context.theme.textTheme.caption),
            ],
          ),
        ),
      ],
    );
  }

  _navigateHome(BuildContext context) {
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
    });
  }
}
