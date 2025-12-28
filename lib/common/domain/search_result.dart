import 'package:movie_search/common/model/movie.dart';
import 'package:movie_search/common/model/person.dart';
import 'package:movie_search/common/model/tmdb_type.dart';
import 'package:movie_search/common/model/tv.dart';

class BaseSearchResult {
  num id;
  String? title;
  String? subtitle;
  String? titleOriginal;
  String? releaseDate;
  String? posterImage;
  String? backDropImage;
  num? voteAverage;
  TMDB_API_TYPE type;
  Movie? movie;
  TvShow? tvShow;
  Person? person;
  Map<String, dynamic> extraData = {};

  String? get status => type == TMDB_API_TYPE.MOVIE && movie != null
      ? _parseStatus(movie?.status)
      : type == TMDB_API_TYPE.TV_SHOW && tvShow != null
      ? _parseStatus(tvShow?.status)
      : null;

  List<String>? get genres => type == TMDB_API_TYPE.PERSON
      ? null
      : type == TMDB_API_TYPE.MOVIE && movie?.genres != null
      ? movie!.genres!.map((e) => e.name).toList()
      : type == TMDB_API_TYPE.TV_SHOW && tvShow?.genres != null
      ? tvShow!.genres!.map((e) => e.name).toList()
      : null;

  int? get year => releaseDate != null ? DateTime.tryParse(releaseDate!)?.year : null;

  String? get originalTitle => movie?.originalTitle ?? tvShow?.originalName;

  String? get tagline => movie?.tagline ?? tvShow?.tagline;

  String get overview {
    return movie?.overview ?? tvShow?.overview ?? person?.biography ?? 'No overview available.';
  }

  BaseSearchResult.fromMovie(Movie this.movie)
    : id = movie.id,
      title = movie.title,
      titleOriginal = movie.originalTitle,
      releaseDate = movie.releaseDate,
      posterImage = movie.posterPath,
      backDropImage = movie.backdropPath,
      voteAverage = movie.voteAverage,
      type = TMDB_API_TYPE.MOVIE;

  BaseSearchResult.fromTv(TvShow tv)
    : id = tv.id,
      title = tv.name,
      titleOriginal = tv.originalName,
      releaseDate = tv.firstAirDate,
      posterImage = tv.posterPath,
      backDropImage = tv.backdropPath,
      voteAverage = tv.voteAverage,
      tvShow = tv,
      type = TMDB_API_TYPE.TV_SHOW;

  BaseSearchResult.fromPerson(Person this.person)
    : id = person.id,
      title = person.name,
      posterImage = person.profilePath,
      subtitle = person.character,
      type = TMDB_API_TYPE.PERSON;

  isPerson() => type == TMDB_API_TYPE.PERSON;
  isMovie() => type == TMDB_API_TYPE.MOVIE;
  isTvShow() => type == TMDB_API_TYPE.TV_SHOW;
  hasBackdrop() => backDropImage != null && backDropImage!.isNotEmpty;

  static BaseSearchResult fromJson(String? mediaType, Map<String, dynamic> data) {
    if (mediaType == 'person') {
      return BaseSearchResult.fromPerson(Person.fromJson(data));
    } else if (mediaType == 'movie') {
      return BaseSearchResult.fromMovie(Movie.fromJson(data));
    } else if (mediaType == 'tv') {
      return BaseSearchResult.fromTv(TvShow.fromJson(data));
    }

    return BaseSearchResult.lite(mediaType: mediaType ?? '', id: data['id'] as num, title: data['title'])
      ..extraData = data
      ..type = TMDB_API_TYPE.UNKNOWN;
  }

  BaseSearchResult._(this.id, String? type, this.title, this.posterImage) : type = _parseType(type);

  completeWithExtraData(String type) {
    if (extraData.isNotEmpty) {
      this.type = tmdbFromString(type);
      if (this.type == TMDB_API_TYPE.PERSON) {
        person = Person.fromJson(extraData);
        title = person?.name;
        posterImage = person?.profilePath;
      } else if (this.type == TMDB_API_TYPE.MOVIE) {
        movie = Movie.fromJson(extraData);
        title = movie?.title;
        titleOriginal = movie?.originalTitle;
        releaseDate = movie?.releaseDate;
        posterImage = movie?.posterPath;
        backDropImage = movie?.backdropPath;
        voteAverage = movie?.voteAverage;
      } else if (this.type == TMDB_API_TYPE.TV_SHOW) {
        tvShow = TvShow.fromJson(extraData);
        title = tvShow?.name;
        titleOriginal = tvShow?.originalName;
        releaseDate = tvShow?.firstAirDate;
        posterImage = tvShow?.posterPath;
        backDropImage = tvShow?.backdropPath;
        voteAverage = tvShow?.voteAverage;
      }
      extraData = {};
    }
  }

  static BaseSearchResult lite({required String mediaType, required num id, String? title, String? posterImage}) {
    return BaseSearchResult._(id, mediaType, title, posterImage);
  }

  static TMDB_API_TYPE _parseType(String? type) {
    try {
      return TMDB_API_TYPE.values.singleWhere((element) => element.type == type);
    } catch (e) {
      return TMDB_API_TYPE.UNKNOWN;
    }
  }

  static String? _parseStatus(String? value) {
    switch (value) {
      case 'Rumored':
        return 'Rumores';
      case 'Planned':
        return 'Planificada';
      case 'In Production':
        return 'En Producción';
      case 'Post Production':
        return 'Post Production';
      case 'Released':
        return 'Estrenada';
      case 'Canceled':
        return 'Cancelada';
      case 'Ended':
        return 'Terminada';
      default:
        return value;
    }
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'posterImage': posterImage, 'type': type.type};
  }

  factory BaseSearchResult.fromMap(Map<String, dynamic> map) {
    return BaseSearchResult.lite(
      id: map['id'] as num,
      title: map['title'] as String,
      posterImage: map['posterImage'] as String,
      mediaType: map['type'] as String,
    );
  }
}
