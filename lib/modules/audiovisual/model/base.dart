import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/model/serie.dart';
import 'package:movie_search/modules/person/model/person.dart';
import 'package:movie_search/providers/util.dart';

import 'movie.dart';

abstract class ModelBase {
  String id;
  String title;
  String titleOriginal;
  num voteAverage;
  String yearOriginal;
  String sinopsis;
  String image;
  AudiovisualTableData data;

  List<String> get imageList {
    if (data != null) {
      final list = data.imageList.split(',');
      list.removeWhere((element) => element == null || element.isEmpty);
      return list;
    }
    return null;
  }

  String get type;

  static final _constructors = {
    MovieOld: () => MovieOld(),
    Serie: () => Serie(),
  };

  static ModelBase fromJson(Type type, Map<String, dynamic> data) {
    final ModelBase r = _constructors[type]();
    r.fromJsonP(data);
    return r;
  }

  ModelBase(
      {this.id,
      this.title,
      this.titleOriginal,
      this.voteAverage,
      this.yearOriginal,
      this.sinopsis,
      this.image});

  dynamic fromJsonP(Map<String, dynamic> data);

  fromData(AudiovisualTableData data) {
    this.id = data.id;
    this.data = data;
    this.title = data.titulo;
    this.titleOriginal = data.originalTitle;
    this.voteAverage = num.tryParse(data.score);
    this.yearOriginal = data.anno;
    this.sinopsis = data.sinopsis;
    this.image = data.image;
  }
}

class BaseSearchResult {
  int id;
  String title;
  String titleOriginal;
  String releaseDate;
  String image;
  TMDB_API_TYPE type;
  Person person;

  BaseSearchResult.fromMovie(Movie movie)
      : id = movie.id,
        title = movie.title,
        titleOriginal = movie.originalTitle,
        releaseDate = movie.releaseDate,
        image = movie.posterPath,
        type = TMDB_API_TYPE.MOVIE;

  BaseSearchResult.fromTv(TvShow tv)
      : id = tv.id,
        title = tv.name,
        titleOriginal = tv.originalName,
        releaseDate = tv.firstAirDate,
        image = tv.posterPath,
        type = TMDB_API_TYPE.TV_SHOW;

  BaseSearchResult.fromPerson(Person person)
      : id = person.id,
        title = person.name,
        image = person.profilePath,
        person = person,
        type = TMDB_API_TYPE.PERSON;
}
