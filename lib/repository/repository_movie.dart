import 'package:flutter/cupertino.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/rest/resolver.dart';
import 'package:provider/provider.dart';

class MovieRepository {
  static MovieRepository _instance;

  final MyDatabase db;
  final RestResolver _resolver = RestResolver();

  static MovieRepository getInstance(BuildContext context) {
    if (_instance == null)
      _instance = MovieRepository(Provider.of<MyDatabase>(context, listen: false));
    return _instance;
  }

  MovieRepository(this.db);

//  MovieRepository(BuildContext context) {
//    db = Provider.of<MyDatabase>(context, listen: false);
//  }

  Future<SearchMovieResponse> search(String query, {String type, int page}) async {
    return _resolver.searchMovie(query, type: type, page: page);
  }

  Future countFavouriteMovies(String type) async {
    return db.countFavouriteMovies(type);
  }

  Future getFavourites(String type) async {
    return db.getFavouritesAudiovisual(type);
  }

  Future getFavRandomWallpaper(String type) async {
    return db.getFavRandomWallpaper(type);
  }

  Future<SearchMovieResponse> getTrending({int page = 1}) async {
    return _resolver.getTrending(page: page);
  }

  Future<SearchMovieResponse> getTrendingSeries({int page = 1}) async {
    return _resolver.getTrendingSeries(page: page);
  }

  Future<List<AudiovisualProvider>> getAllSaved() async {
    var list = await db.getAllMovies();
    return list
        .map((a) => AudiovisualProvider(
              id: a.id,
              title: a.titulo,
              image: a.image,
              imageUrl: a.image,
            ))
        .toList();
  }

  Future<AudiovisualTableData> getById(String id) async {
    final localData = await db.getAudiovisualById(id);
    if (localData != null) {
      return localData;
    }
    final result = await _resolver.findMovieById(id);
    db.insertAudiovisual(result);
    return result;
  }

  Future<AudiovisualTableData> getByTrendingId(String trendingId, String type,
      {String defaultImage}) async {
    final localData = await db.getAudiovisualByExternalId(trendingId);
    if (localData != null) {
      return localData;
    }
    final result = await _resolver.getByTrendingId(trendingId, type);
    if (result != null) {
      if (result.image == null || result.image.isEmpty || !result.image.startsWith('http')) {
        db.insertAudiovisual(result.copyWith(image: defaultImage));
      } else
        db.insertAudiovisual(result);
    }
    return result;
  }
}
