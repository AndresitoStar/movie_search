import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_search/core/content_preview.dart';
import 'package:movie_search/core/infinite_scroll_viewmodel.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/trending/trending_service.dart';
import 'package:movie_search/providers/util.dart';

class HomeNowPlayingViewModel extends InfiniteScrollViewModel<BaseSearchResult> {
  final TrendingService _trendingService;

  HomeNowPlayingViewModel() : _trendingService = TrendingService();

  @override
  Future<AbstractSearchResponse<BaseSearchResult>> makeSearch({int? page}) {
    return _trendingService.getAny('movie', 'now_playing', page: page ?? 1, mediaType: TMDB_API_TYPE.MOVIE.type);
  }
}

class HomeNowPlayingView extends ContentPreviewViewMoreWidget {
  HomeNowPlayingView({Key? key}) : super(key: key);

  @override
  InfiniteScrollViewModel viewModelBuilder(BuildContext context) {
    return HomeNowPlayingViewModel();
  }

  @override
  String get itemGridHeroTag => 'home_now_playing';

  @override
  String get viewMoreButtonHeroTag => 'view_more_btn';

  @override
  bool get itemShowData => true;
}
