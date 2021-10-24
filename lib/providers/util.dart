import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/ui/icons.dart';
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
}

// const String URL_IMAGE_SMALL = 'https://image.tmdb.org/t/p/w342';
const String URL_IMAGE_SMALL = 'https://image.tmdb.org/t/p/w92';
const String URL_IMAGE_SMALL_BACKDROP = 'https://image.tmdb.org/t/p/w780';
const String URL_IMAGE_MEDIUM = 'https://image.tmdb.org/t/p/w342';
const String URL_IMAGE_MEDIUM_BACKDROP = 'https://image.tmdb.org/t/p/w1280';
const String URL_IMAGE_BIG = 'https://image.tmdb.org/t/p/original';

extension snackbar_extension on BuildContext {
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  void showSnackbar(String message) => ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          content: Text(message),
        ),
      );
}

extension DateFormatter on DateTime {
  String get format => DateFormat('dd MMMM yyyy', Locale('es', 'ES').toString()).format(this);
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

  IconData get icon {
    switch (this) {
      case TMDB_API_TYPE.MOVIE:
        return MyIcons.movie;
      case TMDB_API_TYPE.TV_SHOW:
        return MyIcons.tv;
      case TMDB_API_TYPE.PERSON:
        return MyIcons.castMale;
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
    if (_instance == null || _instance._streamForHighQuality.isClosed) _instance = SharedPreferencesHelper._();
    return _instance;
  }

  SharedPreferencesHelper._() {
    _streamForHighQuality = BehaviorSubject<bool>();
    isHighQuality().then((value) => _streamForHighQuality.add(value));

    _streamForSearchHistory = BehaviorSubject<List<String>>();
    getSearchHistory().then((value) => _streamForSearchHistory.add(value.reversed.toList()));

    _streamForFavorite = BehaviorSubject<List<int>>();
    getFavouriteList().then((value) => _streamForFavorite.add(value));
  }

  StreamController<bool> _streamForHighQuality;
  StreamController<List<String>> _streamForSearchHistory;
  StreamController<List<int>> _streamForFavorite;

  Stream<bool> get streamForHighQuality => _streamForHighQuality.stream;

  Stream<List<String>> get streamForSearchHistory => _streamForSearchHistory.stream;

  Stream<List<int>> get streamForFavorite => _streamForFavorite.stream;

  Function(bool) get changeHighQuality => _streamForHighQuality.sink.add;

  updateSearchHistory(String query) {
    getSearchHistory().then((value) {
      value.add(query);
      _streamForSearchHistory.sink.add(value.reversed.toList());
      setSearchHistory(value);
    });
  }

  toggleFavorite(int id) {
    getFavouriteList().then((list) {
      if (list.contains(id))
        list.remove(id);
      else
        list.add(id);
      _streamForFavorite.sink.add(list);
      setFavouriteList(list);
    });
  }

  dispose() {
    _streamForHighQuality?.close();
    _streamForSearchHistory?.close();
    _streamForFavorite?.close();
  }

  static Future _setBoolean(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(key, value);
  }

  static Future _setString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }

  static Future _setList(String key, List value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList(key, value.map((e) => '$e').toList());
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

  static Future<String> _getString(String key) async {
    WidgetsFlutterBinding.ensureInitialized();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      return prefs.getString(key);
    } catch (e) {}
    return null;
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

  static Future<bool> isHighQuality() async {
    return _getBoolean('IMAGE_QUALITY');
  }

  static void setHighQuality(bool value) async {
    _setBoolean('IMAGE_QUALITY', value);
  }

  static Future<List<String>> getSearchHistory() async {
    return _getList<String>('SEARCH_HISTORY');
  }

  static void setSearchHistory(List<String> value) async {
    _setList('SEARCH_HISTORY', value);
  }

  static Future<List<int>> getFavouriteList() async {
    final list = await _getList<String>('FAVORITE');
    return list.map((e) => int.tryParse(e)).toList();
  }

  static void setFavouriteList(List<int> value) async {
    _setList('FAVORITE', value);
  }

  static Future<String> getFlexSchemaColor() async {
    return _getString('SCHEME_COLOR');
  }

  static void setFlexSchemaColor(String value) async {
    _setString('SCHEME_COLOR', value);
  }

  static Future<String> getBrightness() async {
    return _getString('Brightness');
  }

  static void setBrightness(String value) async {
    _setString('Brightness', value);
  }
}
