import 'dart:convert';

import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/model/api/models/movie.dart';
import 'package:movie_search/model/api/models/person.dart';
import 'package:movie_search/model/api/models/tv.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/providers/util.dart';
import 'package:stacked/stacked.dart';

class FavouritesViewModel extends BaseViewModel {
  final MyDatabase _db;

  FavouritesViewModel(this._db);

  Stream<List<BaseSearchResult>> get stream => _db.watchAllFavourites().map((event) => event.map((e) {
        Map<String, dynamic> json = jsonDecode(e.json);
        if (e.type == TMDB_API_TYPE.PERSON.type) {
          return BaseSearchResult.fromPerson(Person.fromJson(json));
        } else if (e.type == TMDB_API_TYPE.MOVIE.type) {
          return BaseSearchResult.fromMovie(Movie.fromJson(json));
        } else if (e.type == TMDB_API_TYPE.TV_SHOW.type) {
          return BaseSearchResult.fromTv(TvShow.fromJson(json));
        }
        return null;
      }).toList());

  initialize() {
    stream.listen((event) => notifyListeners());
    setInitialised(true);
  }
}
