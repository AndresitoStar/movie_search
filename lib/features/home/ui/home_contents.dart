import 'package:movie_search/common/model/tmdb_type.dart';
import 'package:movie_search/common/provider/infinite_scroll_content_provider.dart';
import 'package:movie_search/common/ui/content_preview_horizontal_list.dart';

class HomeTrendingWidget extends ContentPreviewViewMoreWidget {
  HomeTrendingWidget({super.key}) {
    config = ContentConfig.trending;
  }

  @override
  String get itemGridHeroTag => 'home_content_trending_item';

  @override
  // TODO: implement pageRouteName
  String get pageRouteName => throw UnimplementedError();

  @override
  String get title => '{{type}} en Tendencias';

  @override
  String get viewMoreButtonHeroTag => 'home_content_trending_view_more';
}

class HomeNowPlayingWidget extends ContentPreviewViewMoreWidget {
  HomeNowPlayingWidget({super.key}) {
    config = ContentConfig.nowPlaying;
  }

  @override
  String get itemGridHeroTag => 'home_content_now_playing_item';

  @override
  // TODO: implement pageRouteName
  String get pageRouteName => throw UnimplementedError();

  @override
  String get title => 'Ahora en cines';

  @override
  String get viewMoreButtonHeroTag => 'home_content_now_playing_view_more';

  @override
  TMDB_API_TYPE get forcedType => TMDB_API_TYPE.MOVIE;

  @override
  TMDB_API_TYPE? get requiredType => TMDB_API_TYPE.MOVIE;
}

class HomePopularPersonWidget extends ContentPreviewViewMoreWidget {
  HomePopularPersonWidget({super.key}) {
    config = ContentConfig.popularPerson;
  }

  @override
  String get itemGridHeroTag => 'home_person_popular_item';

  @override
  // TODO: implement pageRouteName
  String get pageRouteName => throw UnimplementedError();

  @override
  String get title => 'Personas populares';

  @override
  String get viewMoreButtonHeroTag => 'home_content_person_popular_view_more';

  @override
  TMDB_API_TYPE get forcedType => TMDB_API_TYPE.PERSON;
}

class HomePopularWidget extends ContentPreviewViewMoreWidget {
  HomePopularWidget({super.key}) {
    config = ContentConfig.popular;
  }

  @override
  String get itemGridHeroTag => 'home_popular_item';

  @override
  // TODO: implement pageRouteName
  String get pageRouteName => throw UnimplementedError();

  @override
  String get title => '{{type}} populares';

  @override
  String get viewMoreButtonHeroTag => 'home_content_popular_view_more';
}

class HomeUpcomingWidget extends ContentPreviewViewMoreWidget {
  HomeUpcomingWidget({super.key});

  @override
  ContentConfig get config => ContentConfig.upcoming;

  @override
  String get itemGridHeroTag => 'home_upcoming_item';

  @override
  // TODO: implement pageRouteName
  String get pageRouteName => throw UnimplementedError();

  @override
  String get title => 'Las {{type}} que se vienen';

  @override
  String get viewMoreButtonHeroTag => 'home_content_upcoming_view_more';

  @override
  TMDB_API_TYPE get requiredType => TMDB_API_TYPE.MOVIE;
}

class HomeTopRatedWidget extends ContentPreviewViewMoreWidget {
  HomeTopRatedWidget({super.key});

  @override
  ContentConfig get config => ContentConfig.topRated;

  @override
  String get itemGridHeroTag => 'home_top_rated_item';

  @override
  // TODO: implement pageRouteName
  String get pageRouteName => throw UnimplementedError();

  @override
  String get title => 'Ranking de {{type}}';

  @override
  String get viewMoreButtonHeroTag => 'home_content_top_rated_view_more';
}

class HomeAiringTodayWidget extends ContentPreviewViewMoreWidget {
  HomeAiringTodayWidget({super.key});

  @override
  ContentConfig get config => ContentConfig.airingToday;

  @override
  String get itemGridHeroTag => 'home_airing_today_item';

  @override
  // TODO: implement pageRouteName
  String get pageRouteName => throw UnimplementedError();

  @override
  String get title => '{{type}} que se emiten hoy';

  @override
  String get viewMoreButtonHeroTag => 'home_content_airing_today_view_more';

  @override
  TMDB_API_TYPE get requiredType => TMDB_API_TYPE.TV_SHOW;
}

class HomeOnTheAirWidget extends ContentPreviewViewMoreWidget {
  HomeOnTheAirWidget({super.key});

  @override
  ContentConfig get config => ContentConfig.onTheAir;

  @override
  String get itemGridHeroTag => 'home_on_the_air_item';

  @override
  // TODO: implement pageRouteName
  String get pageRouteName => throw UnimplementedError();

  @override
  String get title => '{{type}} que se emiten esta semana';

  @override
  String get viewMoreButtonHeroTag => 'home_content_on_the_air_view_more';

  @override
  TMDB_API_TYPE get requiredType => TMDB_API_TYPE.TV_SHOW;
}
