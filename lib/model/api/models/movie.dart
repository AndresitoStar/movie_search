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

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['adult'] = adult;
    _data['backdrop_path'] = backdropPath;
    _data['belongs_to_collection'] = collection != null ? collection.toJson() : null;
    _data['budget'] = budget;
    _data['genres'] = genres == null ? null : genres.map((e) => e.toJson()).toList();
    _data['homepage'] = homepage;
    _data['id'] = id;
    _data['imdb_id'] = imdbId;
    _data['original_language'] = originalLanguage;
    _data['original_title'] = originalTitle;
    _data['overview'] = overview;
    _data['popularity'] = popularity;
    _data['poster_path'] = posterPath;
    _data['production_companies'] =
        productionCompanies == null ? null : productionCompanies.map((e) => e.toJson()).toList();
    _data['production_countries'] =
        productionCountries == null ? null : productionCountries.map((e) => e.toJson()).toList();
    _data['release_date'] = releaseDate;
    _data['revenue'] = revenue;
    _data['runtime'] = runtime;
    _data['spoken_languages'] = spokenLanguages == null ? null : spokenLanguages.map((e) => e.toJson()).toList();
    _data['status'] = status;
    _data['tagline'] = tagline;
    _data['title'] = title;
    _data['video'] = video;
    _data['vote_average'] = voteAverage;
    _data['vote_count'] = voteCount;
    return _data;
  }

  MovieApi.fromJson(Map<String, dynamic> json)
      : adult = json['adult'],
        backdropPath = json['backdrop_path'],
        collection = json['belongs_to_collection'] == null ? null : Collection.fromJson(json['belongs_to_collection']),
        budget = json['budget'],
        genres = json['genres'] == null ? null : List.from(json['genres']).map((e) => Genres.fromJson(e)).toList(),
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
            : List.from(json['production_companies']).map((e) => ProductionCompanies.fromJson(e)).toList(),
        productionCountries = json['production_countries'] == null
            ? null
            : List.from(json['production_countries']).map((e) => ProductionCountries.fromJson(e)).toList(),
        releaseDate = json['release_date'],
        revenue = json['revenue'],
        runtime = json['runtime'],
        spokenLanguages = json['spoken_languages'] == null
            ? null
            : List.from(json['spoken_languages']).map((e) => SpokenLanguages.fromJson(e)).toList(),
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

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }

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

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['logo_path'] = logoPath;
    _data['name'] = name;
    _data['origin_country'] = originCountry;
    return _data;
  }

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

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['iso_3166_1'] = iso_3166_1;
    _data['name'] = name;
    return _data;
  }

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

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['iso_639_1'] = iso_639_1;
    _data['name'] = name;
    return _data;
  }

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

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['poster_path'] = posterPath;
    _data['backdrop_path'] = backdropPath;
    _data['overview'] = overview;
    return _data;
  }

  Collection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    posterPath = json['poster_path'];
    backdropPath = json['backdrop_path'];
    overview = json['overview'];
    parts = json['parts'] == null ? null : List.from(json['parts']).map((e) => MovieApi.fromJson(e)).toList();
  }
}
