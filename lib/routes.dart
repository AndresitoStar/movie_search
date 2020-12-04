import 'package:movie_search/ui/screens/config_splash.dart';
import 'package:movie_search/ui/screens/dashboard.dart';
import 'package:movie_search/ui/screens/onboard.dart';
import 'package:provider/provider.dart';

class Routes {
  static final routes = {
    Dashboard.routeName: (ctx) => Dashboard(),
    ConfigSplashScreen.route: (ctx) =>
        ChangeNotifierProvider.value(value: ConfigSplashViewModel(), child: ConfigSplashScreen()),
    OnboardScreen.routeName: (ctx) => OnboardScreen(),
  };
}
