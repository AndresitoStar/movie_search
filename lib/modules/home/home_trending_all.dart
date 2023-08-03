import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_search/core/content_preview.dart';
import 'package:movie_search/core/infinite_scroll_viewmodel.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/trending/trending_service.dart';

enum TrendingWindow {
  DAY('day', 'Hoy'),
  WEEK('week', 'Esta Semana');

  final String apiName;
  final String title;

  const TrendingWindow(this.apiName, this.title);
}

class HomeTrendingAllViewModel extends InfiniteScrollViewModel<BaseSearchResult> {
  final TrendingService _trendingService;
  final TrendingWindow window;

  HomeTrendingAllViewModel({required this.window}) : _trendingService = TrendingService();

  @override
  Future<AbstractSearchResponse<BaseSearchResult>> makeSearch({int? page}) {
    return _trendingService.getAny('trending/all', window.apiName, page: page ?? 1);
  }
}

class HomeTrendingAllView extends ContentPreviewViewMoreWidget {
  final TrendingWindow window;

  HomeTrendingAllView({Key? key, required this.window}) : super(key: key);

  @override
  InfiniteScrollViewModel viewModelBuilder(BuildContext context) {
    return HomeTrendingAllViewModel(window: window);
  }

  @override
  String get itemGridHeroTag => 'home_all_${window.apiName}';

  @override
  String get viewMoreButtonHeroTag => 'view_more_btn_${window.apiName}';
}
