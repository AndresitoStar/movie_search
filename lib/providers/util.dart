import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchResponse {
  final List<ModelBase> result;
  final int totalResult;
  final int totalPageResult;

  SearchResponse({this.result, this.totalResult, this.totalPageResult});
}

const String URL_IMAGE_SMALL = 'http://image.tmdb.org/t/p/w92';
const String URL_IMAGE_MEDIUM = 'http://image.tmdb.org/t/p/w342';
const String URL_IMAGE_BIG = 'http://image.tmdb.org/t/p/w780';

enum FAVOURITE_THINGS { FILMS, SERIES, GAMES }

enum GRID_CONTENT { TRENDING_MOVIE, TRENDING_TV, FAVOURITE }

extension asdasd on GRID_CONTENT {
  String get title {
    switch (this) {
      case GRID_CONTENT.TRENDING_MOVIE:
        return 'Películas';
      case GRID_CONTENT.TRENDING_TV:
        return 'Series';
      case GRID_CONTENT.FAVOURITE:
        return 'Favoritos';
      default:
        return '';
    }
  }
}

enum TMDB_API_TYPE {
  MOVIE,
  TV_SHOW, /* PERSON */
}

extension tmdb_type on TMDB_API_TYPE {
  String get type {
    switch (this) {
      case TMDB_API_TYPE.MOVIE:
        return 'movie';
      case TMDB_API_TYPE.TV_SHOW:
        return 'tv';
      // case TMDB_API_TYPE.PERSON:
      //   return 'person';
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
      // case TMDB_API_TYPE.PERSON:
      //   return 'Persona';
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
