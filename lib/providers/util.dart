import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/model/serie.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchResponse {
  final List<BaseSearchResult> result;
  final int totalResult;
  final int totalPageResult;

  SearchResponse({this.totalResult, this.totalPageResult, this.result});
}

class PersonListResponse {
  final List<Person> result;
  final int totalResult;
  final int totalPageResult;

  PersonListResponse({this.result, this.totalResult, this.totalPageResult});
}

class ResponseApiParser {
  static Person personFromJsonApi(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      birthday: json['birthday'],
      knownForDepartment: json['known_for_department'],
      deathday: json['deathday'],
      name: json['name'],
      character: json['character'],
      gender: json['gender'],
      biography: json['biography'],
      popularity: json['vote_average'],
      placeOfBirth: json['place_of_birth'],
      profilePath: json['profile_path'],
      imdbId: json['imdb_id'],
      isFavourite: false,
    );
  }

  static Movie movieFromJsonApi(Map<String, dynamic> json) {
    try {
      String genres, productionCompanies, productionCountries, spokenLanguages;
      if (json['genres'] != null) {
        try {
          final list = <Genres>[];
          json['genres'].forEach((v) {
            list.add(Genres.fromJson(v));
          });
          genres = list.map((e) => e.name).join(',');
        } catch (e) {}
      }
      if (json['production_companies'] != null) {
        try {
          final list = <ProductionCompanies>[];
          json['production_companies'].forEach((v) {
            list.add(ProductionCompanies.fromJson(v));
          });
          productionCompanies = list.map((e) => e.name).join(', ');
        } catch (e) {}
      }
      if (json['production_countries'] != null) {
        try {
          final list = <ProductionCountries>[];
          json['production_countries'].forEach((v) {
            list.add(ProductionCountries.fromJson(v));
          });
          productionCountries = list.map((e) => e.name).join(', ');
        } catch (e) {}
      }
      if (json['spoken_languages'] != null) {
        try {
          final list = <SpokenLanguages>[];
          json['spoken_languages'].forEach((v) {
            list.add(SpokenLanguages.fromJson(v));
          });
          spokenLanguages = list.map((e) => e.name).join(', ');
        } catch (e) {}
      }
      return Movie(
        id: json['id'],
        isFavourite: false,
        genres: genres,
        productionCompanies: productionCompanies,
        productionCountries: productionCountries,
        spokenLanguages: spokenLanguages,
        backdropPath: json['backdrop_path'],
        homepage: json['homepage'],
        imdbId: json['imdb_id'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        popularity: double.tryParse('${json['vote_average']}'),
        posterPath: json['poster_path'],
        releaseDate: json['release_date'],
        runtime: json['runtime']?.toDouble(),
        status: json['status'],
        tagline: json['tagline'],
        title: json['title'],
        video: json['video'],
      );
    } catch (e) {
      print(json);
      throw (e);
    }
  }

  static TvShow tvFromJsonApi(Map<String, dynamic> json) {
    try {
      String createdBy,
          genres,
          productionCompanies,
          productionCountries,
          spokenLanguages;
      int episodesRuntime;
      if (json['created_by'] != null) {
        final list = <String>[];
        json['created_by'].forEach((v) {
          list.add(CreatedBy.fromJson(v).name);
        });
        createdBy = list.join(', ');
      }
      if (json['genres'] != null) {
        final list = <String>[];
        json['genres'].forEach((v) {
          list.add(Genres.fromJson(v).name);
        });
        genres = list?.join(', ');
      }
      if (json['production_companies'] != null) {
        final list = <String>[];
        json['production_companies'].forEach((v) {
          list.add(ProductionCompanies.fromJson(v).name);
        });
        productionCompanies = list.join(', ');
      }
      if (json['production_countries'] != null) {
        final list = <String>[];
        json['production_countries'].forEach((v) {
          list.add(ProductionCountries.fromJson(v).name);
        });
        productionCountries = list.join(', ');
      }
      if (json['spoken_languages'] != null) {
        final list = <String>[];
        json['spoken_languages'].forEach((v) {
          list.add(SpokenLanguages.fromJson(v).englishName);
        });
        spokenLanguages = list.join(', ');
      }
      if (json['episode_run_time'] != null) {
        final list = json['episode_run_time'] as List<dynamic>;
        if (list.isNotEmpty)
          episodesRuntime =
              list?.reduce((value, element) => min<num>(value, element));
      }
      return TvShow(
        createdBy: createdBy,
        genres: genres,
        productionCompanies: productionCompanies,
        productionCountries: productionCountries,
        spokenLanguages: spokenLanguages,
        episodeRunTime: episodesRuntime,
        id: json['id'],
        backdropPath: json['backdrop_path'],
        status: json['status'],
        tagline: json['tagline'],
        type: json['type'],
        firstAirDate: json['first_air_date'],
        name: json['name'],
        numberOfEpisodes: json['number_of_episodes'],
        numberOfSeasons: json['number_of_seasons'],
        originalLanguage: json['original_language'],
        originalName: json['original_name'],
        overview: json['overview'],
        popularity: double.tryParse('${json['vote_average']}'),
        posterPath: json['poster_path'],
        isFavourite: false,
      );
    } catch (e) {
      print(json);
      throw (e);
    }
  }
}

const String URL_IMAGE_SMALL = 'https://image.tmdb.org/t/p/w92';
const String URL_IMAGE_MEDIUM = 'https://image.tmdb.org/t/p/w342';
const String URL_IMAGE_BIG = 'https://image.tmdb.org/t/p/w780';

extension snackbar_extension on BuildContext {
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  void showSnackbar(String message) => ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          content: Text(message),
        ),
      );
}

enum TMDB_API_TYPE { MOVIE, TV_SHOW, PERSON }

extension tmdb_type on TMDB_API_TYPE {
  String get type {
    switch (this) {
      case TMDB_API_TYPE.MOVIE:
        return 'movie';
      case TMDB_API_TYPE.TV_SHOW:
        return 'tv';
      case TMDB_API_TYPE.PERSON:
        return 'person';
      default:
        return null;
    }
  }

  String get name {
    switch (this) {
      case TMDB_API_TYPE.MOVIE:
        return 'Películas';
      case TMDB_API_TYPE.TV_SHOW:
        return 'Series';
      case TMDB_API_TYPE.PERSON:
        return 'Personas';
      default:
        return null;
    }
  }

  String get nameSingular {
    switch (this) {
      case TMDB_API_TYPE.MOVIE:
        return 'Película';
      case TMDB_API_TYPE.TV_SHOW:
        return 'Serie';
      case TMDB_API_TYPE.PERSON:
        return 'Persona';
      default:
        return null;
    }
  }
}

class Debounce {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debounce({this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class SharedPreferencesHelper {
  static SharedPreferencesHelper _instance;

  static SharedPreferencesHelper getInstance() {
    if (_instance == null || _instance._streamForRecent.isClosed)
      _instance = SharedPreferencesHelper._();
    return _instance;
  }

  SharedPreferencesHelper._() {
    _streamForRecent = BehaviorSubject<bool>();
    isActiveRecent().then((value) => _streamForRecent.add(value));

    _streamForSearchHistory = BehaviorSubject<List<String>>();
    getSearchHistory().then((value) => _streamForSearchHistory.add(value));
  }

  StreamController<bool> _streamForRecent;
  StreamController<List<String>> _streamForSearchHistory;

  Stream<bool> get streamForRecent => _streamForRecent.stream;

  Stream<List<String>> get streamForSearchHistory =>
      _streamForSearchHistory.stream;

  Function(bool) get changeActiveRecent => _streamForRecent.sink.add;

  updateSearchHistory(String query) {
    getSearchHistory().then((value) {
      value.add(query);
      _streamForSearchHistory.sink.add(value);
      setSearchHistory(value);
    });
  }

  dispose() {
    _streamForRecent?.close();
    _streamForSearchHistory?.close();
  }

  static Future _setBoolean(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(key, value);
  }

  static Future _setList(String key, List value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList(key, value.toList());
  }

  static Future<bool> _getBoolean(String key) async {
    WidgetsFlutterBinding.ensureInitialized();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result;
    try {
      result = prefs.getBool(key);
    } catch (e) {}
    return result ?? false;
  }

  static Future<List<T>> _getList<T extends Object>(String key) async {
    WidgetsFlutterBinding.ensureInitialized();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List result;
    try {
      result = prefs.getStringList(key).toSet().toList();
    } catch (e) {}
    return result ?? [];
  }

  static Future<bool> wasHereBefore() async {
    return _getBoolean('WAS_HERE_BEFORE');
  }

  static void setFirstTime() async {
    return _setBoolean('WAS_HERE_BEFORE', true);
  }

  static Future<bool> isActiveRecent() async {
    return _getBoolean('ACTIVE_RECENT');
  }

  static void setActiveRecent(bool value) async {
    _setBoolean('ACTIVE_RECENT', value);
  }

  static Future<List<String>> getSearchHistory() async {
    return _getList<String>('SEARCH_HISTORY');
  }

  static void setSearchHistory(List<String> value) async {
    _setList('SEARCH_HISTORY', value);
  }
}
