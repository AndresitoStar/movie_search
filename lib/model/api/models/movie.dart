import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:movie_search/model/api/models/tv.dart';

class MovieApi {
  MovieApi({
    this.adult,
    this.backdropPath,
    this.collection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });
  final bool adult;
  final String backdropPath;
  final Collection collection;
  final num budget;
  final List<Genres> genres;
  final String homepage;
  final num id;
  final String imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final num popularity;
  final String posterPath;
  final List<ProductionCompanies> productionCompanies;
  final List<ProductionCountries> productionCountries;
  final String releaseDate;
  final num revenue;
  final num runtime;
  final List<SpokenLanguages> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final num voteAverage;
  final num voteCount;

  MovieApi.fromJson(Map<String, dynamic> json)
      : adult = json['adult'],
        backdropPath = json['backdrop_path'],
        collection = json['belongs_to_collection'] == null
            ? null
            : Collection.fromJson(json['belongs_to_collection']),
        budget = json['budget'],
        genres = json['genres'] == null
            ? null
            : List.from(json['genres']).map((e) => Genres.fromJson(e)).toList(),
        homepage = json['homepage'],
        id = json['id'],
        imdbId = json['imdb_id'],
        originalLanguage = json['original_language'],
        originalTitle = json['original_title'],
        overview = json['overview'],
        popularity = json['popularity'],
        posterPath = json['poster_path'],
        productionCompanies = json['production_companies'] == null
            ? null
            : List.from(json['production_companies'])
                .map((e) => ProductionCompanies.fromJson(e))
                .toList(),
        productionCountries = json['production_countries'] == null
            ? null
            : List.from(json['production_countries'])
                .map((e) => ProductionCountries.fromJson(e))
                .toList(),
        releaseDate = json['release_date'],
        revenue = json['revenue'],
        runtime = json['runtime'],
        spokenLanguages = json['spoken_languages'] == null
            ? null
            : List.from(json['spoken_languages'])
                .map((e) => SpokenLanguages.fromJson(e))
                .toList(),
        status = json['status'],
        tagline = json['tagline'],
        title = json['title'],
        video = json['video'],
        voteAverage = json['vote_average'],
        voteCount = json['vote_count'];
}

class Genres {
  Genres({
    this.id,
    this.name,
  });
  final num id;
  final String name;

  Genres.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  @override
  String toString() {
    return name;
  }
}

class ProductionCompanies extends Logo {
  ProductionCompanies({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });
  final num id;
  final String logoPath;
  final String name;
  final String originCountry;

  ProductionCompanies.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        logoPath = json['logo_path'],
        name = json['name'],
        originCountry = json['origin_country'];

  @override
  String toString() {
    return name;
  }
}

class ProductionCountries {
  ProductionCountries({
    this.iso_3166_1,
    this.name,
  });
  final String iso_3166_1;
  final String name;

  ProductionCountries.fromJson(Map<String, dynamic> json)
      : iso_3166_1 = json['iso_3166_1'],
        name = json['name'];

  @override
  String toString() {
    return name;
  }
}

class SpokenLanguages {
  SpokenLanguages({
    this.iso_639_1,
    this.name,
  });
  final String iso_639_1;
  final String name;

  SpokenLanguages.fromJson(Map<String, dynamic> json)
      : iso_639_1 = json['iso_639_1'],
        name = json['name'];

  @override
  String toString() {
    return name;
  }
}

class Collection {
  int id;
  String name;
  String posterPath;
  String backdropPath;
  String overview;
  List<MovieApi> parts;

  Collection({
    this.id,
    this.name,
    this.posterPath,
    this.backdropPath,
    this.overview,
    this.parts,
  });

  Collection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    posterPath = json['poster_path'];
    backdropPath = json['backdrop_path'];
    overview = json['overview'];
    parts = json['parts'] == null
        ? null
        : List.from(json['parts']).map((e) => MovieApi.fromJson(e)).toList();
  }
}
