import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:movie_search/data/firebase_database.dart';
import 'package:movie_search/main.dart';
import 'package:movie_search/model/api/models/favourite.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/providers/util.dart';
import 'package:stacked/stacked.dart';

class FavouritesViewModel extends BaseViewModel {
  Set<int> _listFavouriteId = {};
  List<BaseFavouriteItem> _listFavourite = [];
  Map<String, List<BaseSearchResult?>> _map = {};

  Set<int> get listFavouriteId => {..._listFavouriteId};

  List<BaseSearchResult?> get favoriteList => _map.values.fold<List<BaseSearchResult?>>([], (a, b) => a..addAll(b));

  Future toggleFavourite({
    required bool isLiked,
    required String type,
    required String userUuid,
    required BaseSearchResult data,
    Function(dynamic e)? onError,
  }) async {
    setBusyForObject(data.id, true);
    try {
      if (isLiked) {
        await MyFirebaseService.instance.removeFavourite(id: data.id.toInt(), type: type, userUuid: userUuid);
        globalNavigatorKey.currentContext?.showSnackBar('${data.title} ha sido eliminado de $type');
      } else {
        await MyFirebaseService.instance
            .insertFavourite(id: data.id.toInt(), type: type, userUuid: userUuid, jsonData: data.toJson());
        globalNavigatorKey.currentContext?.showSnackBar('${data.title} ha sido agregado a $type');
      }
    } catch (e) {
      rethrow;
    } finally {
      setBusyForObject(data.id, false);
    }
  }

  initialize(String? userUuid) async {
    setBusy(true);
    if (userUuid != null) {
      DatabaseReference ref = FirebaseDatabase.instance.ref('${MyFirebaseService.instance.bookmarksPath}/$userUuid');
      ref.onValue.listen((event) {
        try {
          if (event.snapshot.value == null) return;
          _listFavouriteId.clear();
          _map.clear();
          final bookmarks = event.snapshot.value as Map;
          for (final typeEntry in bookmarks.entries) {
            final Map itemsMap = typeEntry.value as Map;
            _listFavouriteId.addAll(itemsMap.keys.map((e) => int.parse(e)).toSet());
            final list = itemsMap.values.map((e) {
              final mediaType = e['type'];
              return BaseSearchResult.fromMap((e as Map<Object?, Object?>).cast<String, dynamic>());
            }).toList();
            _map.putIfAbsent(typeEntry.key.toString(), () => list);
          }
          notifyListeners();
        } catch (e) {
          print(e);
        }
      });
    }
    setBusy(false);
  }

  logout() async {
    _map.clear();
    notifyListeners();
  }
}
