import 'dart:convert';

import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/service/service.dart';
import 'package:movie_search/providers/util.dart';
import 'package:stacked/stacked.dart';

class ItemLikeButtonViewModel extends BaseViewModel {
  final AudiovisualService _audiovisualService;
  final MyDatabase _db;
  final TMDB_API_TYPE type;

  ItemLikeButtonViewModel(this._db, this.type) : _audiovisualService = AudiovisualService.getInstance();

  Stream<List<num?>> get stream => _db.watchFavouritesId(type.type);

  initialize() {
    _db.watchFavouritesId(type.type).listen((event) {
      notifyListeners();
    });
    setInitialised(true);
  }

  Future toggleFavourite(num id, bool isLiked) async {
    setBusy(true);
    try {
      if (isLiked) {
        await _db.removeFavourite(id.toInt());
      } else {
        final data = await _cacheData(id);
        await _db.insertFavourite(id.toInt(), type.type, jsonEncode(data));
      }
    } catch (e) {
      setError(e);
    }
    setBusy(false);
  }

  Future<dynamic> _cacheData(num id) async => _audiovisualService.getById(id: id, type: type.type);
}
