import 'package:movie_search/model/api/models/person.dart';
import 'package:movie_search/ui/widgets/extensions.dart';

import 'movie.dart';

abstract class Logo {
  final num id;
  final String? name;
  final String? logoPath;
  final String? originCountry;

  Logo(Map<String, dynamic> json)
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
  String toString() => name ?? '$id';
}

class TvShow {
  TvShow({
    this.backdropPath,
    this.createdBy,
    this.createdByPerson,
    this.episodeRunTime,
    this.firstAirDate,
    this.genres,
    this.homepage,
    required this.id,
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

  final num id;
  final String? backdropPath;
  final List<CreatedBy>? createdBy;
  final List<Person>? createdByPerson;
  final List<num>? episodeRunTime;
  final String? firstAirDate;
  final List<Genres>? genres;
  final String? homepage;
  final bool? inProduction;
  final List<String>? languages;
  final String? lastAirDate;
  final Episode? lastEpisodeToAir;
  final String? name;
  final Episode? nextEpisodeToAir;
  final List<Networks>? networks;
  final num? numberOfEpisodes;
  final num? numberOfSeasons;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final num? popularity;
  final String? posterPath;
  final List<ProductionCompanies>? productionCompanies;
  final List<ProductionCountries>? productionCountries;
  final List<Seasons>? seasons;
  final List<SpokenLanguages>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? type;
  final num? voteAverage;
  final num? voteCount;

  TvShow.fromJson(Map<String, dynamic> json)
      : backdropPath = json['backdrop_path'],
        createdBy = json['created_by'] == null
            ? null
            : List.from(json['created_by']).map((e) => CreatedBy.fromJson(e)).toList(),
        createdByPerson = json['created_by'] == null
            ? null
            : List.from(json['created_by']).map((e) {
                final c = CreatedBy.fromJson(e);
                return Person(id: c.id, name: c.name, profilePath: c.profilePath);
              }).toList(),
        episodeRunTime =
            json['episode_run_time'] == null ? null : List.castFrom<dynamic, num>(json['episode_run_time']),
        firstAirDate = json['first_air_date'],
        genres = json['genres'] == null ? null : List.from(json['genres']).map((e) => Genres.fromJson(e)).toList(),
        homepage = json['homepage'],
        id = json['id'],
        inProduction = json['in_production'],
        languages = json['languages'] == null ? null : List.castFrom<dynamic, String>(json['languages']),
        lastAirDate = json['last_air_date'],
        lastEpisodeToAir = json['last_episode_to_air'] == null ? null : Episode.fromJson(json['last_episode_to_air']),
        name = json['name'],
        nextEpisodeToAir = json['next_episode_to_air'] == null ? null : Episode.fromJson(json['next_episode_to_air']),
        networks =
            json['networks'] == null ? null : List.from(json['networks']).map((e) => Networks.fromJson(e)).toList(),
        numberOfEpisodes = json['number_of_episodes'],
        numberOfSeasons = json['number_of_seasons'],
        originCountry = json['origin_country'] == null ? null : List.castFrom<dynamic, String>(json['origin_country']),
        originalLanguage = json['original_language'],
        originalName = json['original_name'],
        overview = json['overview'],
        popularity = json['popularity'],
        posterPath = json['poster_path'],
        productionCompanies = json['production_companies'] == null
            ? null
            : List.from(json['production_companies']).map((e) => ProductionCompanies.fromJson(e)).toList(),
        productionCountries = json['production_countries'] == null
            ? null
            : List.from(json['production_countries']).map((e) => ProductionCountries.fromJson(e)).toList(),
        seasons = json['seasons'] == null ? null : List.from(json['seasons']).map((e) => Seasons.fromJson(e)).toList(),
        spokenLanguages = json['spoken_languages'] == null
            ? null
            : List.from(json['spoken_languages']).map((e) => SpokenLanguages.fromJson(e)).toList(),
        status = json['status'],
        tagline = json['tagline'],
        type = json['type'],
        voteAverage = json['vote_average'],
        voteCount = json['vote_count'];

  String? get displayRuntime => episodeRuntimeAverage != null ? '${episodeRuntimeAverage!.minutesToHHMM()}' : null;

  Map<String, dynamic> toJson() {
    return {
      'backdrop_path': this.backdropPath,
      'created_by': this.createdByPerson == null ? null : createdByPerson!.map((e) => e.toJson()).toList(),
      'episode_run_time': this.episodeRunTime == null ? null : episodeRunTime!.map((e) => e).toList(),
      'first_air_date': this.firstAirDate,
      'genres': this.genres == null ? null : genres!.map((e) => e.toJson()).toList(),
      'homepage': this.homepage,
      'id': this.id,
      'in_production': this.inProduction,
      'languages': this.languages == null ? null : languages!.map((e) => e).toList(),
      'last_air_date': this.lastAirDate,
      'last_episode_to_air': this.lastEpisodeToAir?.toJson(),
      'name': this.name,
      'next_episode_to_air': this.nextEpisodeToAir?.toJson(),
      'networks': this.networks == null ? null : networks!.map((e) => e.toJson()).toList(),
      'number_of_episodes': this.numberOfEpisodes,
      'number_of_seasons': this.numberOfSeasons,
      'origin_country': this.originCountry == null ? null : originCountry!.map((e) => e).toList(),
      'original_language': this.originalLanguage,
      'original_name': this.originalName,
      'overview': this.overview,
      'popularity': this.popularity,
      'poster_path': this.posterPath,
      'production_companies':
          this.productionCompanies == null ? null : productionCompanies!.map((e) => e.toJson()).toList(),
      'production_countries':
          this.productionCountries == null ? null : productionCountries!.map((e) => e.toJson()).toList(),
      'seasons': this.seasons == null ? null : seasons!.map((e) => e.toJson()).toList(),
      'spoken_languages': this.spokenLanguages == null ? null : spokenLanguages!.map((e) => e.toJson()).toList(),
      'status': this.status,
      'tagline': this.tagline,
      'type': this.type,
      'vote_average': this.voteAverage,
      'vote_count': this.voteCount,
    };
  }

  num? get episodeRuntimeAverage => episodeRunTime != null && episodeRunTime!.isNotEmpty
      ? episodeRunTime!.reduce((x, y) => x + y) / episodeRunTime!.length
      : null;
}

class CreatedBy {
  CreatedBy({
    required this.id,
    this.creditId,
    this.name,
    this.gender,
    this.profilePath,
  });

  final num id;
  final String? creditId;
  final String? name;
  final num? gender;
  final String? profilePath;

  CreatedBy.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        creditId = json['credit_id'],
        name = json['name'],
        gender = json['gender'],
        profilePath = json['profile_path'];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['credit_id'] = creditId;
    _data['name'] = name;
    _data['gender'] = gender;
    _data['profile_path'] = profilePath;
    return _data;
  }

  @override
  String toString() {
    return name ?? '$id';
  }
}

class Networks extends Logo {
  Networks.fromJson(Map<String, dynamic> json) : super(json);
}

class Seasons {
  Seasons({
    required this.id,
    this.airDate,
    this.episodeCount,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
    this.episodes,
  });

  final num id;
  final String? airDate;
  final num? episodeCount;
  final String? name;
  final String? overview;
  final String? posterPath;
  final num? seasonNumber;
  final List<Episode>? episodes;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['air_date'] = airDate;
    _data['episode_count'] = episodeCount;
    _data['id'] = id;
    _data['name'] = name;
    _data['overview'] = overview;
    _data['poster_path'] = posterPath;
    _data['season_number'] = seasonNumber;
    return _data;
  }

  Seasons.fromJson(Map<String, dynamic> json)
      : airDate = json['air_date'],
        episodeCount = json['episode_count'],
        id = json['id'],
        name = json['name'],
        overview = json['overview'],
        posterPath = json['poster_path'],
        episodes =
            json['episodes'] == null ? null : List.from(json['episodes']).map((e) => Episode.fromJson(e)).toList(),
        seasonNumber = json['season_number'];
}

class Episode {
  int id;
  String? airDate;
  int? episodeNumber;
  String? name;
  String? overview;
  String? productionCode;
  int? seasonNumber;
  String? stillPath;
  num? voteAverage;
  int? voteCount;

  Episode(
      {this.airDate,
      this.episodeNumber,
      required this.id,
      this.name,
      this.overview,
      this.productionCode,
      this.seasonNumber,
      this.stillPath,
      this.voteAverage,
      this.voteCount});

  factory Episode.fromJson(Map<String, dynamic> map) {
    return Episode(
      airDate: map['air_date'] as String?,
      episodeNumber: map['episode_number'] as int?,
      id: map['id'] as int,
      name: map['name'] as String?,
      overview: map['overview'] as String?,
      productionCode: map['production_code'] as String?,
      seasonNumber: map['seasonNumber'] as int?,
      stillPath: map['still_path'] as String?,
      voteAverage: map['vote_average'] as num?,
      voteCount: map['vote_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'airDate': this.airDate,
      'episodeNumber': this.episodeNumber,
      'name': this.name,
      'overview': this.overview,
      'productionCode': this.productionCode,
      'seasonNumber': this.seasonNumber,
      'stillPath': this.stillPath,
      'voteAverage': this.voteAverage,
      'voteCount': this.voteCount,
    };
  }
}

class WatchProviderResponse {
  final Map<String, List<WatchProvider>> results;

  WatchProviderResponse({required this.results});

  factory WatchProviderResponse.fromJson(Map<String, dynamic> json) {
    final Map<String, List<WatchProvider>> results = {};
    for (final entry in json.entries) {
      final data = entry.value as Map;
      final list = <WatchProvider>[];
      for (var k in ['flatrate', 'buy', 'rent']) {
        if (data.containsKey(k) && data[k] is List) {
          list.addAll((data[k] as List).map((e) => WatchProvider.fromJson(e)));
        }
      }
      results.putIfAbsent(entry.key, () => list);
    }
    print(json.length);
    return WatchProviderResponse(results: results);
  }
}

class WatchProvider {
  int providerId;
  String? providerName;
  String? logoPath;
  int? displayPriority;

  WatchProvider({
    required this.providerId,
    this.providerName,
    this.logoPath,
    this.displayPriority,
  });

  factory WatchProvider.fromJson(Map<String, dynamic> map) {
    return WatchProvider(
      providerName: map['provider_name'] as String?,
      providerId: map['provider_id'] as int,
      displayPriority: map['display_priority'] as int,
      logoPath: map['logo_path'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'provider_id': this.providerId,
      'provider_name': this.providerName,
      'logo_path': this.logoPath,
      'display_priority': this.displayPriority,
    };
  }
}
