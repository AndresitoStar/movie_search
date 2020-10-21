import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/providers/game_single_provider.dart';
import 'package:movie_search/rest/resolver.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GamesRepository {
  MyDatabase db;
  final RestResolver _resolver = RestResolver();

  GamesRepository(BuildContext context) {
    db = Provider.of<MyDatabase>(context, listen: false);
  }

  Future<List<GameProvider>> search(String query, {@required int offset}) async {
    return await _resolver.searchGames(query, offset: offset);
  }

  Future countFavouriteGames() async {
    return db.countFavouriteGames();
  }

  Future getFavourites() async {
    return db.getFavouritesGames();
  }

  Future getById(String id) async {
    final localData = await db.getGameById(id);
    if (localData != null) {
      return localData;
    }
//    final result = await findMyData2();
    final result = await _resolver.findGameById(id);

    db.insertGame(result);
    return result;
  }

  Future findMyData2() async {
    var result = [
      {
        "id": 39047,
        "cover": {
          "id": 29882,
          "url":
              "//images.igdb.com/igdb/image/upload/t_thumb/krumqjudcobk4cqb85u4.jpg"
        },
        "created_at": 1498089600,
        "genres": [
          {"id": 12, "name": "Role-playing (RPG)"},
          {"id": 31, "name": "Adventure"}
        ],
        "name":
            "Assassin's Creed: Origins - Dawn of the Creed Legendary Edition",
        "platforms": [
          {"id": 6, "name": "PC (Microsoft Windows)"},
          {"id": 48, "name": "PlayStation 4"},
          {"id": 49, "name": "Xbox One"}
        ],
        "summary":
            "Be among the firsts to dive into the Assassin’s Creed Origins universe with this never seen before Collector’s Edition. Featuring a 73cm high-end resin statue of Bayek, a protector of Egypt whose personal story will lead to the creation of the Assassin’s Brotherhood, and his eagle Senu, this exceptional Collector’s Edition is ready to be shipped exclusively on the Ubisoft Store with only 999 units Worldwide."
      }
    ];
    return result;
  }
}
