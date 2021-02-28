import 'package:movie_search/data/moor_database.dart';

import 'base.dart';
import 'movie.dart';

class Serie extends ModelBase {
  @override
  fromJsonP(Map<String, dynamic> data) {
    this.title = data['name'];
    this.titleOriginal = data['original_name'];
    this.id = '${data['id']}';
    this.yearOriginal = data['first_air_date'];
    this.voteAverage = data['vote_average'];
    this.sinopsis = data['overview'];
    this.image = data['poster_path'];
  }

  @override
  String get type => 'tv';
}

class TvShow {
  String backdropPath;
  List<String> createdBy;
  List<int> episodeRunTime;
  String firstAirDate;
  List<String> genres;
  int id;
  List<String> languages;
  String name;
  int numberOfEpisodes;
  int numberOfSeasons;
  List<String> originCountry;
  String originalLanguage;
  String originalName;
  String overview;
  num popularity;
  String posterPath;
  List<String> productionCompanies;
  List<String> productionCountries;
  List<String> spokenLanguages;
  String status;
  String tagline;
  String type;
  num voteAverage;
  int voteCount;

  TvShow(
      {this.backdropPath,
      this.createdBy,
      this.episodeRunTime,
      this.firstAirDate,
      this.genres,
      this.id,
      this.languages,
      this.name,
      this.numberOfEpisodes,
      this.numberOfSeasons,
      this.originCountry,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.popularity,
      this.posterPath,
      this.productionCompanies,
      this.productionCountries,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.type,
      this.voteAverage,
      this.voteCount});

  TvShow.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];
    if (json['created_by'] != null) {
      createdBy = List<String>();
      json['created_by'].forEach((v) {
        createdBy.add(CreatedBy.fromJson(v).name);
      });
    }
    episodeRunTime = json['episode_run_time']?.cast<int>();
    firstAirDate = json['first_air_date'];
    if (json['genres'] != null) {
      genres = List<String>();
      json['genres'].forEach((v) {
        genres.add(Genres.fromJson(v).name);
      });
    }
    id = json['id'];
    languages = json['languages']?.cast<String>();
    name = json['name'];
    numberOfEpisodes = json['number_of_episodes'];
    numberOfSeasons = json['number_of_seasons'];
    originCountry = json['origin_country']?.cast<String>();
    originalLanguage = json['original_language'];
    originalName = json['original_name'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    if (json['production_companies'] != null) {
      productionCompanies = List<String>();
      json['production_companies'].forEach((v) {
        productionCompanies.add(ProductionCompanies.fromJson(v).name);
      });
    }
    if (json['production_countries'] != null) {
      productionCountries = List<String>();
      json['production_countries'].forEach((v) {
        productionCountries.add(ProductionCountries.fromJson(v).name);
      });
    }
    if (json['spoken_languages'] != null) {
      spokenLanguages = List<String>();
      json['spoken_languages'].forEach((v) {
        spokenLanguages.add(SpokenLanguages.fromJson(v).englishName);
      });
    }
    status = json['status'];
    tagline = json['tagline'];
    type = json['type'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }
}

class CreatedBy {
  int id;
  String creditId;
  String name;
  int gender;
  String profilePath;

  CreatedBy({this.id, this.creditId, this.name, this.gender, this.profilePath});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creditId = json['credit_id'];
    name = json['name'];
    gender = json['gender'];
    profilePath = json['profile_path'];
  }
}

class LastEpisodeToAir {
  String airDate;
  int episodeNumber;
  int id;
  String name;
  String overview;
  String productionCode;
  int seasonNumber;
  String stillPath;
  num voteAverage;
  int voteCount;

  LastEpisodeToAir(
      {this.airDate,
      this.episodeNumber,
      this.id,
      this.name,
      this.overview,
      this.productionCode,
      this.seasonNumber,
      this.stillPath,
      this.voteAverage,
      this.voteCount});

  LastEpisodeToAir.fromJson(Map<String, dynamic> json) {
    airDate = json['air_date'];
    episodeNumber = json['episode_number'];
    id = json['id'];
    name = json['name'];
    overview = json['overview'];
    productionCode = json['production_code'];
    seasonNumber = json['season_number'];
    stillPath = json['still_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }
}

class ProductionCountries {
  String iso31661;
  String name;

  ProductionCountries({this.iso31661, this.name});

  ProductionCountries.fromJson(Map<String, dynamic> json) {
    iso31661 = json['iso_3166_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['iso_3166_1'] = this.iso31661;
    data['name'] = this.name;
    return data;
  }
}

class SpokenLanguages {
  String englishName;
  String iso6391;
  String name;

  SpokenLanguages({this.englishName, this.iso6391, this.name});

  SpokenLanguages.fromJson(Map<String, dynamic> json) {
    englishName = json['english_name'];
    iso6391 = json['iso_639_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['english_name'] = this.englishName;
    data['iso_639_1'] = this.iso6391;
    data['name'] = this.name;
    return data;
  }
}
