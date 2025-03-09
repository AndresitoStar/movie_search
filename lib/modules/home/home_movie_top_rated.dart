import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_search/core/content_preview.dart';
import 'package:movie_search/core/content_type_controller.dart';
import 'package:movie_search/core/infinite_scroll_viewmodel.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/trending/trending_service.dart';
import 'package:movie_search/providers/util.dart';

class HomeTopRatedViewModel extends InfiniteScrollViewModel<BaseSearchResult> {
  final TrendingService _trendingService;

  HomeTopRatedViewModel() : _trendingService = TrendingService();

  @override
  Future<AbstractSearchResponse<BaseSearchResult>> makeSearch(
      {int? page, required bool force}) {
    final type = ContentTypeController.getInstance().currentType;
    return _trendingService.getAny(
      type.type,
      'top_rated',
      page: page ?? 1,
      mediaType: type.type,
      force: force,
    );
  }
}

class HomeTopRatedView extends ContentPreviewViewMoreWidget {
  HomeTopRatedView({Key? key}) : super(key: key);

  @override
  InfiniteScrollViewModel viewModelBuilder(BuildContext context) {
    return HomeTopRatedViewModel();
  }

  @override
  String get itemGridHeroTag => 'home_airing_today';

  @override
  String get viewMoreButtonHeroTag => 'view_more_btn';

  @override
  bool get itemShowData => true;

  @override
  String get title => 'Top Rated';
}
