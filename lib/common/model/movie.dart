import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:movie_search/common/model/tv.dart';

class Movie {
  Movie({
    this.adult,
    this.backdropPath,
    this.collection,
    this.budget,
    this.genres,
    this.homepage,
    required this.id,
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

  final bool? adult;
  final String? backdropPath;
  final Collection? collection;
  final num? budget;
  final List<Genres>? genres;
  final String? homepage;
  final num id;
  final String? imdbId;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final num? popularity;
  final String? posterPath;
  final List<ProductionCompanies>? productionCompanies;
  final List<ProductionCountries>? productionCountries;
  final String? releaseDate;
  final num? revenue;
  final num? runtime;
  final List<SpokenLanguages>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? title;
  final bool? video;
  final num? voteAverage;
  final num? voteCount;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['belongs_to_collection'] = collection?.toJson();
    data['budget'] = budget;
    data['genres'] = genres?.map((e) => e.toJson()).toList();
    data['homepage'] = homepage;
    data['id'] = id;
    data['imdb_id'] = imdbId;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['production_companies'] = productionCompanies?.map((e) => e.toJson()).toList();
    data['production_countries'] = productionCountries?.map((e) => e.toJson()).toList();
    data['release_date'] = releaseDate;
    data['revenue'] = revenue;
    data['runtime'] = runtime;
    data['spoken_languages'] = spokenLanguages?.map((e) => e.toJson()).toList();
    data['status'] = status;
    data['tagline'] = tagline;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }

  String? get displayRuntime => runtime?.minutesToHHMM();

  Movie.fromJson(Map<String, dynamic> json)
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
  Genres({required this.id, required this.name});

  final num id;
  final String name;

  Genres.fromJson(Map<String, dynamic> json) : id = json['id'], name = json['name'];

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  @override
  String toString() {
    return name;
  }
}

class ProductionCompanies extends Logo {
  ProductionCompanies.fromJson(super.json);
}

class ProductionCountries {
  ProductionCountries({required this.iso_3166_1, required this.name});

  final String iso_3166_1;
  final String name;

  ProductionCountries.fromJson(Map<String, dynamic> json) : iso_3166_1 = json['iso_3166_1'], name = json['name'];

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['iso_3166_1'] = iso_3166_1;
    data['name'] = name;
    return data;
  }

  @override
  String toString() {
    return name;
  }
}

class ContentRatings {
  ContentRatings({required this.results});

  final List<ContentRating> results;

  ContentRatings.fromJson(Map<String, dynamic> json)
    : results = json['results'] == null
        ? []
        : List.from(json['results']).map((e) => ContentRating.fromJson(e)).toList();

  ContentRatings.fromJsonCertification(Map<String, dynamic> json)
    : results = json['results'] == null
        ? []
        : List.from(json['results']).map((e) => ContentRating.fromJsonCertification(e)).toList();
}

class ContentRating {
  ContentRating({required this.iso_3166_1, this.rating});

  final String iso_3166_1;
  final String? rating;

  ContentRating.fromJson(Map<String, dynamic> json) : iso_3166_1 = json['iso_3166_1'], rating = json['rating'];

  ContentRating.fromJsonCertification(Map<String, dynamic> json)
    : iso_3166_1 = json['iso_3166_1'],
      rating = json['release_dates'] == null
          ? null
          : List.from(json['release_dates'])
                .map((e) => e['certification'])
                .firstWhere((element) => element != null && element != '', orElse: () => null);
}

class SpokenLanguages {
  SpokenLanguages({required this.iso_639_1, required this.name});

  final String iso_639_1;
  final String name;

  SpokenLanguages.fromJson(Map<String, dynamic> json) : iso_639_1 = json['iso_639_1'], name = json['name'];

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['iso_639_1'] = iso_639_1;
    data['name'] = name;
    return data;
  }

  @override
  String toString() {
    return name;
  }
}

class Collection {
  int id;
  String? name;
  String? posterPath;
  String? backdropPath;
  String? overview;
  List<Movie>? parts;

  Collection({required this.id, this.name, this.posterPath, this.backdropPath, this.overview, this.parts});

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['poster_path'] = posterPath;
    data['backdrop_path'] = backdropPath;
    data['overview'] = overview;
    return data;
  }

  Collection.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      posterPath = json['poster_path'],
      backdropPath = json['backdrop_path'],
      overview = json['overview'],
      parts = json['parts'] == null ? null : List.from(json['parts']).map((e) => Movie.fromJson(e)).toList();
}
