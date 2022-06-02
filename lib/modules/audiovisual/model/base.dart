import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/model/api/models/movie.dart';
import 'package:movie_search/model/api/models/tv.dart';
import 'package:movie_search/providers/util.dart';

class BaseSearchResult {
  int id;
  String title;
  String titleOriginal;
  String releaseDate;
  String posterImage;
  String backDropImage;
  num voteAverage;
  TMDB_API_TYPE type;
  MovieApi movie;
  TvApi tvShow;
  Person person;


  String get status => type == TMDB_API_TYPE.MOVIE && movie != null
      ? _parseStatus(movie.status)
      : type == TMDB_API_TYPE.TV_SHOW && tvShow != null
          ? _parseStatus(tvShow.status)
          : null;

  List<String> get genres => type == TMDB_API_TYPE.PERSON
      ? null
      : type == TMDB_API_TYPE.MOVIE && movie?.genres != null
          ? movie.genres.map((e) => e.name).toList()
          : type == TMDB_API_TYPE.TV_SHOW && tvShow?.genres != null
              ? tvShow.genres.map((e) => e.name).toList()
              : null;

  int get year => releaseDate != null ? DateTime.tryParse(releaseDate)?.year : null;

  BaseSearchResult.fromMovie(MovieApi movie)
      : id = movie.id,
        title = movie.title,
        titleOriginal = movie.originalTitle,
        releaseDate = movie.releaseDate,
        posterImage = movie.posterPath,
        backDropImage = movie.backdropPath,
        voteAverage = movie.voteAverage,
        movie = movie,
        type = TMDB_API_TYPE.MOVIE;

  BaseSearchResult.fromTv(TvApi tv)
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
        person = person,
        type = TMDB_API_TYPE.PERSON;

  static BaseSearchResult fromJson(String mediaType, Map<String, dynamic> data) {
    if (mediaType == 'person') {
      return BaseSearchResult.fromPerson(ResponseApiParser.personFromJsonApi(data));
    } else if (mediaType == 'movie') {
      return BaseSearchResult.fromMovie(MovieApi.fromJson(data));
    } else if (mediaType == 'tv') {
      return BaseSearchResult.fromTv(TvApi.fromJson(data));
    }
    return null;
  }

  static String _parseStatus(String value) {
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
}
