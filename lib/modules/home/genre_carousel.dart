import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/core/content_preview.dart';
import 'package:movie_search/core/content_type_controller.dart';
import 'package:movie_search/model/api/models/genre.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/home/home_screen.dart';
import 'package:movie_search/modules/splash/config_singleton.dart';
import 'package:movie_search/modules/trending/trending_service.dart';
import 'package:movie_search/providers/util.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stacked/stacked.dart';
import 'package:get_it/get_it.dart';

import '../search/search_result_list_item.dart';

class GenreCarouselWidget extends StackedView<GenreCarouselViewModel> {
  @override
  Widget builder(
      BuildContext context, GenreCarouselViewModel viewModel, Widget? child) {
    if (viewModel.isBusy || viewModel.initialised == false) {
      return Center(child: CircularProgressIndicator());
    }
    return DefaultTabController(
      length: viewModel.tabsCountForCurrentType,
      initialIndex: 0,
      child: Builder(builder: (context) {
        DefaultTabController.of(context).addListener(() {
          viewModel.loadGenreItems(viewModel
              .genresForCurrentType[DefaultTabController.of(context).index]);
        });
        return Column(
          children: [
            Container(
              color: context.theme.colorScheme.primary,
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                isScrollable: true,
                labelColor: Theme.of(context).colorScheme.onPrimary,
                tabAlignment: Device.screenType == ScreenType.mobile
                    ? TabAlignment.start
                    : TabAlignment.center,
                indicatorColor: Theme.of(context).colorScheme.onPrimary,
                unselectedLabelColor: context.theme.colorScheme.onPrimary,
                labelStyle: context.theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: context.theme.textTheme.titleSmall,
                tabs: viewModel.genresForCurrentType
                    .map((e) => Tab(text: e.name))
                    .toList(),
              ),
            ),
            _ActualGenreWidget(),
          ],
        );
      }),
    );
  }

  @override
  GenreCarouselViewModel viewModelBuilder(BuildContext context) =>
      GenreCarouselViewModel();

  @override
  void onViewModelReady(GenreCarouselViewModel viewModel) {
    viewModel.loadInitialData();
    viewModel.listenForHomeControllerChanges();
    super.onViewModelReady(viewModel);
  }
}

class _ActualGenreWidget extends ViewModelWidget<GenreCarouselViewModel> {
  final int itemsCount = 5;

  @override
  Widget build(BuildContext context, GenreCarouselViewModel viewModel) {
    int columns = UiUtils.calculateColumns(
        context: context, itemWidth: 400, minValue: 1, maxValue: 5);

    return Builder(builder: (context) {
      final genre = viewModel.actualGenre;
      if (viewModel.busy(genre) || viewModel.itemsForActualGenre.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }
      final control = FormControl<int>(value: 0);
      final items = viewModel.itemsForActualGenre
          .where((element) => element.backDropImage != null)
          .toList()
          .sublist(0, itemsCount)
          .map((item) => ItemGridCarousel(searchResult: item))
          .toList();
      return Container(
        child: CarouselSlider(
            items: items,
            options: CarouselOptions(
              initialPage: 0,
              viewportFraction: 1 / columns,
              aspectRatio: 1.778 * columns,
              enableInfiniteScroll: true,
              disableCenter: true,
              onPageChanged: (index, reason) {
                control.updateValue(index);
              },
              reverse: false,
              autoPlay: true,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
            )),
      );
    });
  }
}

class GenreCarouselViewModel extends BaseViewModel {
  final TrendingService _trendingService = TrendingService();

  GenreCarouselViewModel();

  Map<String, List<Genre>> _genres = {};

  Map<String, List<Genre>> get genres => {..._genres};

  Map<Genre, List<BaseSearchResult>> _allGenreMap = {};

  Map<Genre, List<BaseSearchResult>> get allGenreMap => {..._allGenreMap};

  FormControl<Genre> _actualGenreControl = FormControl<Genre>();

  Genre? get actualGenre => _actualGenreControl.value;

  List<BaseSearchResult> get itemsForActualGenre =>
      _allGenreMap[_actualGenreControl.value] ?? [];

  int get tabsCountForCurrentType {
    final type = ContentTypeController.getInstance().currentType;
    return _genres[type.type]?.length ?? 0;
  }

  List<Genre> get genresForCurrentType {
    final type = ContentTypeController.getInstance().currentType;
    return _genres[type.type] ?? [];
  }

  void listenForHomeControllerChanges() {
    GetIt.instance<HomeController>().loadingStream.listen((event) async {
      final actualType = ContentTypeController.getInstance().currentType;
      if (_genres[actualType.type] == null) return;
      await loadGenreItems(_genres[actualType.type]!.first);
      notifyListeners();
    });
    // _actualGenreControl.valueChanges.listen((event) {
    //   if (event != null) {
    //     loadGenreItems(event);
    //   }
    // });
  }

  Future loadInitialData() async {
    setBusy(true);
    try {
      Future loadGenre(String type) async {
        await ConfigSingleton.instance.syncGenres();
        final genres = ConfigSingleton.instance.getGenresByType(type);
        final items = Map<Genre, List<BaseSearchResult>>.fromIterable(genres,
            key: (genre) => genre, value: (genre) => []);
        _allGenreMap.addAll(items);
        _genres[type] = genres;
      }

      await loadGenre(TMDB_API_TYPE.MOVIE.type);
      await loadGenre(TMDB_API_TYPE.TV_SHOW.type);

      final actualType = ContentTypeController.getInstance().currentType;
      await loadGenreItems(_genres[actualType.type]!.first);

      setBusy(false);
      setInitialised(true);
    } catch (e) {
      setError(e);
    }
  }

  Future loadGenreItems(Genre genre) async {
    if (busy(genre)) return;
    setBusyForObject(genre, true);
    _actualGenreControl.updateValue(genre);
    try {
      final type = ContentTypeController.getInstance().currentType;
      if (_allGenreMap[genre]?.isEmpty ?? true) {
        final response =
            await _trendingService.getDiscover(type.type, genres: [genre.id]);
        _allGenreMap[genre] = response.result;
      }
      setBusyForObject(genre, false);
    } catch (e) {
      setError(e);
    }
  }
}
