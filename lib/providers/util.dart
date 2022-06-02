import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchResponse {
  final List<BaseSearchResult> result;
  final int totalResult;
  final int totalPageResult;

  SearchResponse({required this.totalResult, required this.totalPageResult, required this.result});
}

// const String URL_IMAGE_SMALL = 'https://image.tmdb.org/t/p/w342';
const String URL_IMAGE_SMALL = 'https://image.tmdb.org/t/p/w92';
const String URL_IMAGE_SMALL_BACKDROP = 'https://image.tmdb.org/t/p/w780';
const String URL_IMAGE_MEDIUM = 'https://image.tmdb.org/t/p/w342';
const String URL_IMAGE_MEDIUM_BACKDROP = 'https://image.tmdb.org/t/p/w1280';
const String URL_IMAGE_BIG = 'https://image.tmdb.org/t/p/original';

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension MediaQueryExtension on BuildContext {
  MediaQueryData get mq => MediaQuery.of(this);
}

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
    }
  }
}

class Debounce {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debounce({required this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class SharedPreferencesHelper {
  static SharedPreferencesHelper? _instance;

  static SharedPreferencesHelper getInstance() {
    if (_instance == null || _instance!._streamForHighQuality.isClosed) _instance = SharedPreferencesHelper._();
    return _instance!;
  }

  SharedPreferencesHelper._() {
    _streamForHighQuality = BehaviorSubject<bool>();
    isHighQuality().then((value) => _streamForHighQuality.add(value));

    _streamForSearchHistory = BehaviorSubject<List<String>>();
    getSearchHistory().then((value) => _streamForSearchHistory.add(value.reversed.toList()));
  }

  late StreamController<bool> _streamForHighQuality;
  late StreamController<List<String>> _streamForSearchHistory;

  Stream<bool> get streamForHighQuality => _streamForHighQuality.stream;

  Stream<List<String>> get streamForSearchHistory => _streamForSearchHistory.stream;

  Function(bool) get changeHighQuality => _streamForHighQuality.sink.add;

  updateSearchHistory(String query) {
    getSearchHistory().then((value) {
      value.add(query);
      _streamForSearchHistory.sink.add(value.reversed.toList());
      setSearchHistory(value);
    });
  }

  dispose() {
    _streamForHighQuality.close();
    _streamForSearchHistory.close();
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
    bool result = false;
    try {
      result = prefs.getBool(key) ?? false;
    } catch (e) {}
    return result;
  }

  static Future<String?> _getString(String key) async {
    WidgetsFlutterBinding.ensureInitialized();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<List<String>> _getList(String key) async {
    WidgetsFlutterBinding.ensureInitialized();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> result = [];
    try {
      final r = prefs.getStringList(key);
      if (r != null) result.addAll(r.toSet());
    } catch (e) {}
    return result;
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
    return _getList('SEARCH_HISTORY');
  }

  static void setSearchHistory(List<String> value) async {
    _setList('SEARCH_HISTORY', value);
  }

  static Future<String?> getFlexSchemaColor() async {
    return _getString('SCHEME_COLOR');
  }

  static void setFlexSchemaColor(String value) async {
    _setString('SCHEME_COLOR', value);
  }
}

extension DurationExtension on Duration {
  String formatDuration() {
    var seconds = this.inSeconds;
    final days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;
    final hours = seconds ~/ Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;
    final minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    final List<String> tokens = [];
    if (days != 0) {
      // tokens.add('${days}d');
      return days == 1 ? '$days dia' : '$days dias'; // TODO add to localizations
    }
    if (tokens.isNotEmpty || hours != 0) {
      // tokens.add('${hours}h');
      return hours == 1 ? '$hours hora' : '$hours horas'; // TODO add to localizations
    }
    if (tokens.isNotEmpty || minutes != 0) {
      // tokens.add('${minutes}m');
      return minutes == 1 ? '$minutes minuto' : '$minutes minutos'; // TODO add to localizations
    }
    // tokens.add('${seconds}s');
    return seconds == 1 ? '$seconds segundo' : '$seconds segundos';
    // return tokens.join(':');
  }
}
