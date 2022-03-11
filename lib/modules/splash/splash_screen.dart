import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movie_search/modules/home/home_screen.dart';
import 'package:movie_search/modules/splash/splash_viewmodel.dart';
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
                ? _buildBusyIndicator()
                : Builder(builder: (context) {
                    _navigateHome(context);
                    return _buildBusyIndicator();
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
            Text(
                'Parece que ocurrio un error, verifica que tengas conexión a Internet.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6),
          ],
        ),
      );

  _buildBusyIndicator() => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/ic_launcher.png',
              width: 200,
            ),
            SizedBox(height: 64),
            SizedBox(
              height: 60,
              width: 60,
              child: CircularProgressIndicator(strokeWidth: 1),
            ),
          ],
        ),
      );

  _navigateHome(BuildContext context) {
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      // Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
    });
  }
}
