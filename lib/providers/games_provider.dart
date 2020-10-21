import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/repository/repository_games.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'game_single_provider.dart';

class GameListProvider with ChangeNotifier {
  List<GameProvider> _items = [];
  int _offset = 0;
  final int _DEFAULT_CANT_ITEMS_PER_PAGE = 10;
  bool _hasMore = false;
  String _actualSearchQuery;
  int _favsCount;

  int get favsCount => _favsCount;

  bool get hasMore => _hasMore;

  List<GameProvider> get items => [..._items];

  List<GameProvider> _favs = [];

  List<GameProvider> get favs => [..._favs];

  GameProvider findById(String id) {
    return _items.firstWhere((av) => av.id == id);
  }

  Future search(BuildContext context, String query) async {
//    return search2(query);
    final GamesRepository _repository = GamesRepository(context);
    final result = await _repository.search(query, offset: 0);
    _actualSearchQuery = query;
    if (result != null) {
      _items = result;
      _hasMore = _DEFAULT_CANT_ITEMS_PER_PAGE == result.length;
    } else
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('No Conection!!!'),
              ));
    notifyListeners();
  }

  Future fetchMore(BuildContext context) async {
    final GamesRepository _repository = GamesRepository(context);
    final result = await _repository.search(_actualSearchQuery,
        offset: _items.length);
    if (result != null) {
      _items.addAll(result);
      _hasMore = _DEFAULT_CANT_ITEMS_PER_PAGE == result.length;
    } else {
//      _totalSearchResult = 0;
      _hasMore = false;
//      showDialog(
//          context: context,
//          builder: (context) => AlertDialog(
//            title: Text('No Conection!!!'),
//          ));
    }
    notifyListeners();
  }

  Future loadFavorites(BuildContext context) async {
    final GamesRepository _repository = GamesRepository(context);
    final List<GameTableData> dbList = await _repository.getFavourites();
    _favs = dbList
        .map((game) => GameProvider(
            title: game.titulo,
            imageUrl: game.image,
            platforms: game.plataformas,
            year: DateFormat.yMMM().format(game.fechaLanzamiento),
            id: game.id,
            isFavourite: game.isFavourite))
        .toList();
    notifyListeners();
  }

  Future calculateCountFavorites(BuildContext context) async {
    final GamesRepository _repository = GamesRepository(context);
    _favsCount = await _repository.countFavouriteGames();
    notifyListeners();
  }

  Future search2(String query, {String type}) async {
    List<GameProvider> result = [];
    var body = [
      {
        "id": 2946,
        "name": "FIFA 12",
      },
      {
        "id": 701,
        "name": "FIFA Football 2002",
      },
      {
        "id": 2153,
        "name": "FIFA 13",
      },
      {
        "id": 71398,
        "name": "FIFA Soccer 97",
      },
      {
        "id": 703,
        "name": "FIFA Football 2005",
      },
      {
        "id": 3135,
        "name": "FIFA 08",
      },
      {
        "id": 696,
        "name": "FIFA 07",
      },
      {
        "id": 126294,
        "name": "FIFA 2000",
      },
      {
        "id": 103733,
        "name": "FIFA Soccer: FIFA World Cup",
      },
      {
        "id": 22342,
        "name": "FIFA 06: Road to FIFA World Cup",
      }
    ];
    for (var a in body) {
      var game = new GameProvider(
          title: a['name'], id: a['id'].toString(), isFavourite: false);
      result.add(game);
    }
    _items = result;
    notifyListeners();
  }
}
