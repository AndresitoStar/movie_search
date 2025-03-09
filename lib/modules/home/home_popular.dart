import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_search/core/content_preview.dart';
import 'package:movie_search/core/content_type_controller.dart';
import 'package:movie_search/core/infinite_scroll_viewmodel.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/trending/trending_service.dart';
import 'package:movie_search/providers/util.dart';

class HomePopularViewModel extends InfiniteScrollViewModel<BaseSearchResult> {
  final TrendingService _trendingService;

  HomePopularViewModel() : _trendingService = TrendingService();

  @override
  Future<AbstractSearchResponse<BaseSearchResult>> makeSearch(
      {int? page, required bool force}) {
    final type = ContentTypeController.getInstance().currentType;
    return _trendingService.getAny(
      type.type,
      'popular',
      page: page ?? 1,
      mediaType: type.type,
      force: force,
    );
  }
}

class HomePopularView extends ContentPreviewViewMoreWidget {
  HomePopularView({Key? key}) : super(key: key);

  @override
  InfiniteScrollViewModel viewModelBuilder(BuildContext context) {
    return HomePopularViewModel();
  }

  @override
  String get itemGridHeroTag => 'popular';

  @override
  String get viewMoreButtonHeroTag => 'view_more_popular_btn';

  @override
  bool get itemShowData => true;

  @override
  String get title => 'Most Popular';
}
