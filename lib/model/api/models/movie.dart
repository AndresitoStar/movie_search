class MovieApi {
  MovieApi({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
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
  final Null belongsToCollection;
  final int budget;
  final List<Genres> genres;
  final String homepage;
  final int id;
  final String imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final Null posterPath;
  final List<ProductionCompanies> productionCompanies;
  final List<ProductionCountries> productionCountries;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final List<SpokenLanguages> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieApi.fromJson(Map<String, dynamic> json)
      : adult = json['adult'],
        backdropPath = json['backdrop_path'],
        belongsToCollection = null,
        budget = json['budget'],
        genres =
            List.from(json['genres']).map((e) => Genres.fromJson(e)).toList(),
        homepage = json['homepage'],
        id = json['id'],
        imdbId = json['imdb_id'],
        originalLanguage = json['original_language'],
        originalTitle = json['original_title'],
        overview = json['overview'],
        popularity = json['popularity'],
        posterPath = null,
        productionCompanies = List.from(json['production_companies'])
            .map((e) => ProductionCompanies.fromJson(e))
            .toList(),
        productionCountries = List.from(json['production_countries'])
            .map((e) => ProductionCountries.fromJson(e))
            .toList(),
        releaseDate = json['release_date'],
        revenue = json['revenue'],
        runtime = json['runtime'],
        spokenLanguages = List.from(json['spoken_languages'])
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
  final int id;
  final String name;

  Genres.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
}

class ProductionCompanies {
  ProductionCompanies({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });
  final int id;
  final String logoPath;
  final String name;
  final String originCountry;

  ProductionCompanies.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        logoPath = null,
        name = json['name'],
        originCountry = json['origin_country'];
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
}
