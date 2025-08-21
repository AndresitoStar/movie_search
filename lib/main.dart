import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:movie_search/core/content_type_controller.dart';
import 'package:movie_search/core/infinite_scroll_viewmodel.dart';
import 'package:movie_search/firebase_options.dart';
import 'package:movie_search/modules/account/viewModel/account_viewmodel.dart';
import 'package:movie_search/modules/favourite/viewmodel/favourite_viewmodel.dart';
import 'package:movie_search/modules/home/home_movie_now_playing.dart';
import 'package:movie_search/modules/home/home_screen.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/routes.dart';
import 'package:movie_search/ui/widgets/extensions.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'modules/home/home_movie_top_rated.dart';
import 'modules/home/home_movie_upcoming.dart';
import 'modules/home/home_popular.dart';
import 'modules/home/home_trending_all.dart';
import 'modules/themes/theme_viewmodel.dart';

final GlobalKey<ScaffoldState> drawerKey = new GlobalKey<ScaffoldState>();
final GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();
final getIt = GetIt.instance;

void main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDateFormatting("es_ES", null);
  final color = await _resolveColorSchema();
  SharedPreferencesHelper.wasHereBefore().then((value) => runApp(EasyDynamicThemeWidget(child: App(color: color))));
  await ContentTypeController.getInstance().loadCurrentType();
  _configureSingleton();
}

_configureSingleton() {
  
  getIt.registerSingleton<HomeController>(HomeController());
  getIt.registerFactory<InfiniteScrollViewModel>(
    () => HomeNowPlayingViewModel(),
    instanceName: HomeNowPlayingViewModel.instanceName,
  );
  getIt.registerFactory<InfiniteScrollViewModel>(
    () => HomeTopRatedViewModel(),
    instanceName: HomeTopRatedViewModel.instanceName,
  );
  getIt.registerFactory<InfiniteScrollViewModel>(
    () => HomePopularViewModel(),
    instanceName: HomePopularViewModel.instanceName,
  );
  getIt.registerFactory<InfiniteScrollViewModel>(
    () => HomeUpcomingViewModel(),
    instanceName: HomeUpcomingViewModel.instanceName,
  );
  getIt.registerFactory<InfiniteScrollViewModel>(
    () => HomeTrendingAllViewModel(window: TrendingWindow.WEEK),
    instanceName: HomeTrendingAllViewModel.instanceName,
  );
}

Future<FlexScheme> _resolveColorSchema() async {
  final color = await SharedPreferencesHelper.getFlexSchemaColor();
  if (color == null) return FlexScheme.ebonyClay;
  return FlexScheme.values.singleWhere((c) => c.toString() == color);
}

class App extends StatelessWidget {
  final FlexScheme color;

  App({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      maxTabletWidth: 720,
      builder: (context, orientation, screenType) => MultiProvider(
        providers: [
          ChangeNotifierProvider<AccountViewModel>(create: (context) => AccountViewModel()..checkUserLogged()),
          ChangeNotifierProvider<FavouritesViewModel>(create: (context) => FavouritesViewModel()),
        ],
        child: ViewModelBuilder<ThemeViewModel>.reactive(
          viewModelBuilder: () => ThemeViewModel(
            color,
            themeMode: EasyDynamicTheme.of(context).themeMode ?? ThemeMode.system,
          ),
          builder: (context, model, child) => MaterialApp.router(
            title: 'Movie Search',
            debugShowCheckedModeBanner: false,
            theme: model.theme,
            darkTheme: model.darkTheme,
            themeMode: EasyDynamicTheme.of(context).themeMode,
            routerConfig: Routes.go_routes,
            scrollBehavior: MyCustomScrollBehavior(),
          ),
        ),
      ),
    );
  }
}
