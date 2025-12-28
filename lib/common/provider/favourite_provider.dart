import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search/common/domain/search_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favourite_provider.g.dart';

@Riverpod(keepAlive: true)
class FavouriteList extends _$FavouriteList {
  final Map<String, List<BaseSearchResult>> _map = {};

  @override
  Future<Map<String, List<BaseSearchResult>>> build() async {
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
  }

  void remove(num id) {
    for (var key in _map.keys) {
      _map[key]!.removeWhere((element) => element.id == id);
    }
    state = AsyncData(_map);
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
