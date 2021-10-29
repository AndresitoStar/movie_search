import 'dart:convert';

import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/model/api/models/movie.dart';
import 'package:movie_search/model/api/models/person.dart';
import 'package:movie_search/model/api/models/tv.dart';
import 'package:movie_search/providers/util.dart';
import 'package:stacked/stacked.dart';

class FavouritesViewModel extends BaseViewModel {
  final MyDatabase _db;

  FavouritesViewModel(this._db);

  Stream<List<MovieApi>> get streamMovies =>
      _db.watchFavourites<MovieApi>(TMDB_API_TYPE.MOVIE.type, (json) => MovieApi.fromJson(jsonDecode(json)));
  Stream<List<TvApi>> get streamTvShow =>
      _db.watchFavourites<TvApi>(TMDB_API_TYPE.TV_SHOW.type, (json) => TvApi.fromJson(jsonDecode(json)));
  Stream<List<Person>> get streamPerson =>
      _db.watchFavourites<Person>(TMDB_API_TYPE.PERSON.type, (json) => Person.fromJson(jsonDecode(json)));

  initialize() {
    streamMovies.listen((event) => notifyListeners());
    streamTvShow.listen((event) => notifyListeners());
    streamPerson.listen((event) => notifyListeners());
    setInitialised(true);
  }
}
