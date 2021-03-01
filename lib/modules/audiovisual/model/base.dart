import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/providers/util.dart';

class BaseSearchResult {
  int id;
  String title;
  String titleOriginal;
  String releaseDate;
  String image;
  num voteAverage;
  TMDB_API_TYPE type;
  Movie movie;
  TvShow tvShow;
  Person person;

  bool get isFavourite => type == TMDB_API_TYPE.PERSON && person != null
      ? person.isFavourite
      : type == TMDB_API_TYPE.MOVIE && movie != null
          ? movie.isFavourite
          : type == TMDB_API_TYPE.TV_SHOW && tvShow != null
              ? tvShow.isFavourite
              : false;

  List<String> get genres => type == TMDB_API_TYPE.PERSON
      ? null
      : type == TMDB_API_TYPE.MOVIE && movie != null
          ? movie.genres.split(',')
          : type == TMDB_API_TYPE.TV_SHOW && tvShow != null
              ? tvShow.genres.split(',')
              : null;

  BaseSearchResult.fromMovie(Movie movie)
      : id = movie.id,
        title = movie.title,
        titleOriginal = movie.originalTitle,
        releaseDate = movie.releaseDate,
        image = movie.posterPath,
        voteAverage = movie.popularity,
        movie = movie,
        type = TMDB_API_TYPE.MOVIE;

  BaseSearchResult.fromTv(TvShow tv)
      : id = tv.id,
        title = tv.name,
        titleOriginal = tv.originalName,
        releaseDate = tv.firstAirDate,
        image = tv.posterPath,
        voteAverage = tv.popularity,
        tvShow = tv,
        type = TMDB_API_TYPE.TV_SHOW;

  BaseSearchResult.fromPerson(Person person)
      : id = person.id,
        title = person.name,
        image = person.profilePath,
        person = person,
        type = TMDB_API_TYPE.PERSON;

  static BaseSearchResult fromJson(
      String mediaType, Map<String, dynamic> data) {
    if (mediaType == 'person') {
      return BaseSearchResult.fromPerson(
          ResponseApiParser.personFromJsonApi(data));
    } else if (mediaType == 'movie') {
      return BaseSearchResult.fromMovie(
          ResponseApiParser.movieFromJsonApi(data));
    } else if (mediaType == 'tv') {
      return BaseSearchResult.fromTv(ResponseApiParser.tvFromJsonApi(data));
    }
    return null;
  }
}
