import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search/common/domain/search_result.dart';
import 'package:movie_search/features/user/provider/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favourite_provider.g.dart';

@Riverpod(keepAlive: true)
class FavouriteList extends _$FavouriteList {
  final Map<String, List<BaseSearchResult>> _map = {};

  @override
  Future<Map<String, List<BaseSearchResult>>> build() async {
    String? userUuid = ref.watch(userUuidProvider);
    if (userUuid != null) {
      final fetchedFavourites = await MyFirebaseService.instance.fetchFavourites(userUuid);
      _map.clear();
      _map.addAll(fetchedFavourites);
    }
    return Future.value(_map);
  }

  void add(BaseSearchResult item, String bookmarkType) {
    if (!_map.containsKey(bookmarkType)) {
      _map[bookmarkType] = [];
    }
    if (!_map[bookmarkType]!.any((element) => element.id == item.id)) {
      _map[bookmarkType]!.add(item);
      state = AsyncData(_map);
    }
    MyFirebaseService.instance.insertFavourite(
      id: item.id.toInt(),
      type: bookmarkType,
      userUuid: ref.read(userUuidProvider)!,
      jsonData: item.toJson(),
    );
  }

  void remove(num id, String bookmarkType) {
    for (var key in _map.keys) {
      _map[key]!.removeWhere((element) => element.id == id);
    }
    state = AsyncData(_map);
    MyFirebaseService.instance.removeFavourite(
      id: id.toInt(),
      type: bookmarkType,
      userUuid: ref.read(userUuidProvider)!,
    );
  }
}

@riverpod
String? bookmarks(Ref ref, num id) {
  final favList = ref.watch(favouriteListProvider);
  if (favList.asData != null) {
    for (var entry in favList.asData!.value.entries) {
      if (entry.value.any((element) => element.id == id)) {
        return entry.key;
      }
    }
  }
  return null;
}

class MyFirebaseService {
  static MyFirebaseService? _instance;

  static MyFirebaseService get instance => _instance ??= MyFirebaseService._();

  MyFirebaseService._() : super();

  String get bookmarksPath => 'bookmarks';

  Future insertFavourite({
    required int id,
    required String type,
    required String userUuid,
    required Map<String, dynamic> jsonData,
  }) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('$bookmarksPath/$userUuid/$type/$id');
    await ref.set(jsonData);
  }

  Future removeFavourite({required int id, required String type, required String userUuid}) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('$bookmarksPath/$userUuid/$type/$id');
    await ref.remove();
  }

  Future<Map<String, List<BaseSearchResult>>> fetchFavourites(String userUuid) async {
    final Map<String, List<BaseSearchResult>> result = {};
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref('$bookmarksPath/$userUuid');
      final value = await ref.get();
      if (value.value == null) return Future.value(result);
      result.clear();
      final bookmarks = value.value as Map;
      for (final typeEntry in bookmarks.entries) {
        final Map itemsMap = typeEntry.value as Map;
        final list = itemsMap.values.map((e) {
          return BaseSearchResult.fromMap((e as Map<Object?, Object?>).cast<String, dynamic>());
        }).toList();
        result.putIfAbsent(typeEntry.key.toString(), () => list);
      }
    } catch (e) {
      print(e);
    }
    return result;
  }
}
