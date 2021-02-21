import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movie_search/modules/home/home_screen.dart';
import 'package:movie_search/modules/splash/splash_viewmodel.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/ui/screens/dashboard.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  static String route = "/splash";

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: model.hasError
            ? Center(child: Text('Parece que ocurrio un error...'))
            : !model.dataReady
                ? _buildBusyIndicator()
                : Builder(builder: (context) {
                    _navigateHome(context);
                    return _buildBusyIndicator();
                  }),
      ),
      viewModelBuilder: () => SplashViewModel(context.read()),
    );
  }

  _buildBusyIndicator() => Center(child: CircularProgressIndicator());

  _navigateHome(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
    });
  }
}
