import 'movie.dart';

class TvApi {
  TvApi({
    this.backdropPath,
    this.createdBy,
    this.episodeRunTime,
    this.firstAirDate,
    this.genres,
    this.homepage,
    this.id,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.name,
    this.nextEpisodeToAir,
    this.networks,
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
    this.seasons,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.type,
    this.voteAverage,
    this.voteCount,
  });
  final String backdropPath;
  final List<CreatedBy> createdBy;
  final List<int> episodeRunTime;
  final String firstAirDate;
  final List<Genres> genres;
  final String homepage;
  final int id;
  final bool inProduction;
  final List<String> languages;
  final String lastAirDate;
  final LastEpisodeToAir lastEpisodeToAir;
  final String name;
  final Null nextEpisodeToAir;
  final List<Networks> networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<ProductionCompanies> productionCompanies;
  final List<ProductionCountries> productionCountries;
  final List<Seasons> seasons;
  final List<SpokenLanguages> spokenLanguages;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  TvApi.fromJson(Map<String, dynamic> json)
      : backdropPath = json['backdrop_path'],
        createdBy = List.from(json['created_by'])
            .map((e) => CreatedBy.fromJson(e))
            .toList(),
        episodeRunTime = List.castFrom<dynamic, int>(json['episode_run_time']),
        firstAirDate = json['first_air_date'],
        genres =
            List.from(json['genres']).map((e) => Genres.fromJson(e)).toList(),
        homepage = json['homepage'],
        id = json['id'],
        inProduction = json['in_production'],
        languages = List.castFrom<dynamic, String>(json['languages']),
        lastAirDate = json['last_air_date'],
        lastEpisodeToAir =
            LastEpisodeToAir.fromJson(json['last_episode_to_air']),
        name = json['name'],
        nextEpisodeToAir = null,
        networks = List.from(json['networks'])
            .map((e) => Networks.fromJson(e))
            .toList(),
        numberOfEpisodes = json['number_of_episodes'],
        numberOfSeasons = json['number_of_seasons'],
        originCountry = List.castFrom<dynamic, String>(json['origin_country']),
        originalLanguage = json['original_language'],
        originalName = json['original_name'],
        overview = json['overview'],
        popularity = json['popularity'],
        posterPath = json['poster_path'],
        productionCompanies = List.from(json['production_companies'])
            .map((e) => ProductionCompanies.fromJson(e))
            .toList(),
        productionCountries = List.from(json['production_countries'])
            .map((e) => ProductionCountries.fromJson(e))
            .toList(),
        seasons =
            List.from(json['seasons']).map((e) => Seasons.fromJson(e)).toList(),
        spokenLanguages = List.from(json['spoken_languages'])
            .map((e) => SpokenLanguages.fromJson(e))
            .toList(),
        status = json['status'],
        tagline = json['tagline'],
        type = json['type'],
        voteAverage = json['vote_average'],
        voteCount = json['vote_count'];
}

class CreatedBy {
  CreatedBy({
    this.id,
    this.creditId,
    this.name,
    this.gender,
    this.profilePath,
  });
  final int id;
  final String creditId;
  final String name;
  final int gender;
  final String profilePath;

  CreatedBy.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        creditId = json['credit_id'],
        name = json['name'],
        gender = json['gender'],
        profilePath = json['profile_path'];
}

class LastEpisodeToAir {
  LastEpisodeToAir({
    this.airDate,
    this.episodeNumber,
    this.id,
    this.name,
    this.overview,
    this.productionCode,
    this.seasonNumber,
    this.stillPath,
    this.voteAverage,
    this.voteCount,
  });
  final String airDate;
  final int episodeNumber;
  final int id;
  final String name;
  final String overview;
  final String productionCode;
  final int seasonNumber;
  final String stillPath;
  final double voteAverage;
  final int voteCount;

  LastEpisodeToAir.fromJson(Map<String, dynamic> json)
      : airDate = json['air_date'],
        episodeNumber = json['episode_number'],
        id = json['id'],
        name = json['name'],
        overview = json['overview'],
        productionCode = json['production_code'],
        seasonNumber = json['season_number'],
        stillPath = json['still_path'],
        voteAverage = json['vote_average'],
        voteCount = json['vote_count'];
}

class Networks {
  Networks({
    this.name,
    this.id,
    this.logoPath,
    this.originCountry,
  });
  final String name;
  final int id;
  final String logoPath;
  final String originCountry;

  Networks.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        logoPath = json['logo_path'],
        originCountry = json['origin_country'];
}

class Seasons {
  Seasons({
    this.airDate,
    this.episodeCount,
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
  });
  final String airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final int seasonNumber;

  Seasons.fromJson(Map<String, dynamic> json)
      : airDate = json['air_date'],
        episodeCount = json['episode_count'],
        id = json['id'],
        name = json['name'],
        overview = json['overview'],
        posterPath = json['poster_path'],
        seasonNumber = json['season_number'];
}
