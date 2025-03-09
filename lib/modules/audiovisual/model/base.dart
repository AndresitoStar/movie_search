import 'package:movie_search/model/api/models/movie.dart';
import 'package:movie_search/model/api/models/person.dart';
import 'package:movie_search/model/api/models/tv.dart';
import 'package:movie_search/providers/util.dart';

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

  BaseSearchResult.fromMovie(Movie movie)
      : id = movie.id,
        title = movie.title,
        titleOriginal = movie.originalTitle,
        releaseDate = movie.releaseDate,
        posterImage = movie.posterPath,
        backDropImage = movie.backdropPath,
        voteAverage = movie.voteAverage,
        movie = movie,
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

  BaseSearchResult.fromPerson(Person person)
      : id = person.id,
        title = person.name,
        posterImage = person.profilePath,
        subtitle = person.character,
        person = person,
        type = TMDB_API_TYPE.PERSON;

  static BaseSearchResult fromJson(String mediaType, Map<String, dynamic> data) {
    if (mediaType == 'person') {
      return BaseSearchResult.fromPerson(Person.fromJson(data));
    } else if (mediaType == 'movie') {
      return BaseSearchResult.fromMovie(Movie.fromJson(data));
    } else if (mediaType == 'tv') {
      return BaseSearchResult.fromTv(TvShow.fromJson(data));
    }
    throw Exception('API TYPE NOT IMPLEMENTED!');
  }

  BaseSearchResult._(
    num id,
    String? type,
    String? title,
    String? posterImage,
  )   : id = id,
        title = title,
        posterImage = posterImage,
        type = TMDB_API_TYPE.values.singleWhere((element) => element.type == type);

  static BaseSearchResult lite({
    required String mediaType,
    required num id,
    String? title,
    String? posterImage,
  }) {
    return BaseSearchResult._(id, mediaType, title, posterImage);
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
    return {
      'id': this.id,
      'title': this.title,
      'posterImage': this.posterImage,
      'type': this.type.type,
    };
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
