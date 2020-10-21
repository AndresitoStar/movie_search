import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/repository/repository_games.dart';
import 'package:movie_search/repository/repository_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class GameProvider with ChangeNotifier {
  final String id;
  final String title;
  final String platforms;
  final String year;
  final String imageUrl;
  bool isFavourite;
  bool imageLoaded = false;

  GameProvider({this.id, this.title, this.platforms, this.year, this.imageUrl,
    this.isFavourite});

  Future<bool> toggleFavourite({@required BuildContext context, GameTableData game}) async {
    isFavourite = !isFavourite;
    final _repository = GamesRepository(context);
    _repository.db.updateGame(game.copyWith(isFavourite: isFavourite));
    notifyListeners();
    return isFavourite;
  }

  Future toggleLoadImage() async {
    imageLoaded = !imageLoaded;
    notifyListeners();
  }

  Future checkImageCached(String url) async{
    var file = await DefaultCacheManager().getFileFromCache(url);
    var exist = await file?.file?.exists();
    imageLoaded = exist ?? false;
    notifyListeners();
  }

  Future findMyData(BuildContext context) async {
    final _repository = GamesRepository(context);
    return await _repository.getById(id);
  }
}
