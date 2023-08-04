import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_search/core/content_preview.dart';
import 'package:movie_search/core/infinite_scroll_viewmodel.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/trending/trending_service.dart';
import 'package:movie_search/providers/util.dart';

class HomeUpcomingViewModel extends InfiniteScrollViewModel<BaseSearchResult> {
  final TrendingService _trendingService;

  HomeUpcomingViewModel() : _trendingService = TrendingService();

  @override
  Future<AbstractSearchResponse<BaseSearchResult>> makeSearch({int? page}) {
    return _trendingService.getAny('movie', 'upcoming', page: page ?? 1, mediaType: TMDB_API_TYPE.MOVIE.type);
  }
}

class HomeUpcomingView extends ContentPreviewViewMoreWidget {
  HomeUpcomingView({Key? key}) : super(key: key);

  @override
  InfiniteScrollViewModel viewModelBuilder(BuildContext context) {
    return HomeUpcomingViewModel();
  }

  @override
  String get itemGridHeroTag => 'home_now_playing';

  @override
  String get viewMoreButtonHeroTag => 'view_more_btn';

  @override
  bool get itemShowData => true;
}
