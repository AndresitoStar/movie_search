import 'base.dart';

class MovieOld extends ModelBase {
  @override
  fromJsonP(Map<String, dynamic> data) {
    this.title = data['title'];
    this.titleOriginal = data['original_title'];
    this.id = '${data['id']}';
    this.yearOriginal = data['release_date'];
    this.voteAverage = data['vote_average'];
    this.sinopsis = data['overview'];
    this.image = data['poster_path'];
  }

  @override
  String get type => 'movie';
}

class Movie {
  bool adult;
  String backdropPath;
  String genres;
  String homepage;
  int id;
  String imdbId;
  String originalLanguage;
  String originalTitle;
  String overview;
  num popularity;
  String posterPath;
  String productionCompanies;
  String productionCountries;
  String releaseDate;
  num runtime;
  String spokenLanguages;
  String status;
  String tagline;
  String title;
  bool video;
  num voteAverage;

  Movie(
      {this.adult,
      this.backdropPath,
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
      this.runtime,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.title,
      this.video,
      this.voteAverage});

  Movie.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    if (json['genres'] != null) {
      try {
        final genres = List<Genres>();
        json['genres'].forEach((v) {
          genres.add(Genres.fromJson(v));
        });
        this.genres = genres.map((e) => e.name).join(',');
      } catch (e) {}
    }
    homepage = json['homepage'];
    id = json['id'];
    imdbId = json['imdb_id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    if (json['production_companies'] != null) {
      try {
        final productionCompanies = List<ProductionCompanies>();
        json['production_companies'].forEach((v) {
          productionCompanies.add(ProductionCompanies.fromJson(v));
        });
        this.productionCompanies =
            productionCompanies.map((e) => e.name).join(',');
      } catch (e) {}
    }
    if (json['production_countries'] != null) {
      try {
        final countries = List<ProductionCountries>();
        json['production_countries'].forEach((v) {
          countries.add(ProductionCountries.fromJson(v));
        });
        this.productionCountries = countries.map((e) => e.name).join(',');
      } catch (e) {}
    }
    releaseDate = json['release_date'];
    runtime = json['runtime'];
    if (json['spoken_languages'] != null) {
      try {
        final spokenLanguages = List<SpokenLanguages>();
        json['spoken_languages'].forEach((v) {
          spokenLanguages.add(SpokenLanguages.fromJson(v));
        });
        this.spokenLanguages = spokenLanguages.map((e) => e.name).join(',');
      } catch (e) {}
    }
    status = json['status'];
    tagline = json['tagline'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
  }
}

class Genres {
  int id;
  String name;

  Genres({this.id, this.name});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class ProductionCompanies {
  int id;
  String logoPath;
  String name;
  String originCountry;

  ProductionCompanies({this.id, this.logoPath, this.name, this.originCountry});

  ProductionCompanies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logoPath = json['logo_path'];
    name = json['name'];
    originCountry = json['origin_country'];
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
}

class SpokenLanguages {
  String iso6391;
  String name;

  SpokenLanguages({this.iso6391, this.name});

  SpokenLanguages.fromJson(Map<String, dynamic> json) {
    iso6391 = json['iso_639_1'];
    name = json['name'];
  }
}
