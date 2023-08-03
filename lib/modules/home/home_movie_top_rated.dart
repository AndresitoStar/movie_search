import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_search/core/content_preview.dart';
import 'package:movie_search/core/infinite_scroll_viewmodel.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/trending/trending_service.dart';
import 'package:movie_search/providers/util.dart';

class HomeAiringViewModel extends InfiniteScrollViewModel<BaseSearchResult> {
  final TrendingService _trendingService;

  HomeAiringViewModel() : _trendingService = TrendingService();

  @override
  Future<AbstractSearchResponse<BaseSearchResult>> makeSearch({int? page}) {
    return _trendingService.getAny('tv', 'on_the_air', page: page ?? 1, mediaType: TMDB_API_TYPE.TV_SHOW.type);
  }
}

class HomeAiringView extends ContentPreviewViewMoreWidget {
  HomeAiringView({Key? key}) : super(key: key);

  @override
  InfiniteScrollViewModel viewModelBuilder(BuildContext context) {
    return HomeAiringViewModel();
  }

  @override
  String get itemGridHeroTag => 'home_airing_today';

  @override
  String get viewMoreButtonHeroTag => 'view_more_btn';

  @override
  bool get itemShowData => false;
}
