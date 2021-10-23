import 'dart:convert';

import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/service/service.dart';
import 'package:movie_search/modules/person/service/service.dart';
import 'package:movie_search/providers/util.dart';
import 'package:stacked/stacked.dart';

class ItemLikeButtonViewModel extends BaseViewModel {
  final AudiovisualService _audiovisualService;
  final PersonService _personService;
  final MyDatabase _db;
  final TMDB_API_TYPE type;

  ItemLikeButtonViewModel(this._db, this.type)
      : _personService = PersonService.getInstance(),
        _audiovisualService = AudiovisualService.getInstance();

  Stream<List<int>> get stream => _db.watchFavouritesId(type.type);

  initialize() {
    // if (type == TMDB_API_TYPE.MOVIE || type == TMDB_API_TYPE.TV_SHOW)
    //   SharedPreferencesHelper.getInstance().streamForFavorite.listen((event) {
    //     notifyListeners();
    //   });
    // else if (type == TMDB_API_TYPE.PERSON)
    //   _db.watchFavouritesPersonId().listen((event) {
    //     notifyListeners();
    //   });
    _db.watchFavouritesId(type.type).listen((event) {
      notifyListeners();
    });
    setInitialised(true);
  }

  Future toggleFavourite(int id, bool isLiked) async {
    setBusy(true);
    try {
      if (isLiked) {
        await _db.removeFavourite(id);
      } else {
        final data = await _cacheData(id);
        await _db.insertFavourite(id, type.type, jsonEncode(data));
      }
    } catch (e) {
      setError(e);
    }
    setBusy(false);
  }

  Future<dynamic> _cacheData(int id) async {
    if (type == TMDB_API_TYPE.MOVIE || type == TMDB_API_TYPE.TV_SHOW) {
      return _audiovisualService.getById(id: id, type: type.type);
    } else if (type == TMDB_API_TYPE.PERSON) {
      return _personService.getById(id);
    }
  }
}
