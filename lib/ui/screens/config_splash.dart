import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/repository/repository_movie.dart';
import 'package:movie_search/ui/screens/dashboard.dart';
import 'package:provider/provider.dart';

class ConfigSplashViewModel with ChangeNotifier {
  bool loading = true;
  bool success = false;

  load(BuildContext context) async {
    final repository = MovieRepository.getInstance(context);
    success = await repository.syncCountries() && await repository.syncLanguages();
    loading = false;
    notifyListeners();
  }
}

class ConfigSplashScreen extends StatelessWidget {
  static String route = "ConfigSplashScreen";

  @override
  Widget build(BuildContext context) {
    final ConfigSplashViewModel viewModel =
        Provider.of<ConfigSplashViewModel>(context, listen: false);
    Future.delayed(Duration(milliseconds: 300), () => viewModel.load(context));
    return Scaffold(
      body: Consumer<ConfigSplashViewModel>(
        builder: (context, viewModel, child) => viewModel.loading
            ? Center(child: CircularProgressIndicator())
            : !viewModel.success
                ? Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Parece que ocurrio un error de conexion'),
                      RaisedButton(
                          onPressed: () => viewModel.load(context), child: Text('Reintentar'))
                    ],
                  )
                : Builder(builder: (context) {
                    Future.delayed(
                        Duration(milliseconds: 500),
                        () => Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => Dashboard(),
                                settings: RouteSettings(name: Dashboard.routeName),
                              ),
                              (route) => false,
                            ));
                    return Center(child: CircularProgressIndicator());
                  }),
      ),
    );
  }
}
