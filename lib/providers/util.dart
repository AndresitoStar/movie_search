import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'audiovisual_single_provider.dart';

class SearchResponse {
  final List<AudiovisualProvider> result;
  final int totalResult;

  SearchResponse({this.result, this.totalResult});
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
  }

  StreamController<bool> _streamForRecent;

  Stream<bool> get streamForRecent => _streamForRecent.stream;

  Function(bool) get changeActiveRecent => _streamForRecent.sink.add;

  dispose() => _streamForRecent?.close();

  static Future _setBoolean(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(key, value);
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
}
