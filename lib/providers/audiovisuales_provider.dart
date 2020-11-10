import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/providers/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../providers/audiovisual_single_provider.dart';
import '../repository/repository_movie.dart';

class AudiovisualListProvider with ChangeNotifier {
  final String category;
  final String genre;
  final String type;
  bool _hasMore;
  int _totalSearchResult;
  int _actualPage = 1;
  String _actualSearchQuery;
  String _actualSearchType;
  int _favsMoviesCount = 0;
  int _favsSeriesCount = 0;
  String _favsSeriesImage;
  String _favsMovieImage;
  bool _loading = false;

  final _types = {FAVOURITE_THINGS.FILMS: 'movie', FAVOURITE_THINGS.SERIES: 'series'};

  get types => _types;

  int get moviesFavsCount => _favsMoviesCount;

  int get seriesFavsCount => _favsSeriesCount;

  String get favsSeriesImage => '$_favsSeriesImage';

  String get favsMovieImage => '$_favsMovieImage';

  AudiovisualListProvider({this.type, this.category, this.genre});

  List<AudiovisualProvider> _items = [];

  List<AudiovisualProvider> get items {
    return [..._items];
  }

  List<AudiovisualProvider> _favs = [];

  List<AudiovisualProvider> get favs {
    return [..._favs];
  }

  List<AudiovisualProvider> _trendings;

  List<AudiovisualProvider> get trendings => _trendings != null ? [..._trendings] : null;

  List<AudiovisualProvider> _trendingSeries;

  List<AudiovisualProvider> get trendingSeries =>
      _trendingSeries != null ? [..._trendingSeries] : null;

  List<AudiovisualProvider> _forDashboard;

  List<AudiovisualProvider> get forDashboard => _forDashboard != null ? [..._forDashboard] : null;

  bool get hasMore => _hasMore;

  bool get loading => _loading;

  AudiovisualProvider findById(String id) {
    return _items.firstWhere((av) => av.id == id);
  }

  clearList() {
    _items.clear();
    notifyListeners();
  }

  Future search(BuildContext context, String query, {String type}) async {
//    return search2(query);
    _loading = true;
    notifyListeners();

    _actualSearchQuery = query;
    _actualSearchType = type;
    _actualPage = 1;
    final MovieRepository _repository = MovieRepository.getInstance(context);
    final result = await _repository.search(query, type: type, page: _actualPage);
    if (result != null) {
      _items = result.result;
      _totalSearchResult = result.totalResult;
      _hasMore = (10 * _actualPage) < _totalSearchResult;
    } else {
      _totalSearchResult = 0;
      _hasMore = false;
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('No Conection!!!'),
              ));
    }

    _loading = false;
    notifyListeners();
  }

  Future synchronizeTrending(BuildContext context, GRID_CONTENT gridContent) async {
    final MovieRepository _repository = MovieRepository.getInstance(context);
    if (gridContent == GRID_CONTENT.TRENDING_MOVIE && (_trendings == null || _trendings.isEmpty)) {
      _trendings = await _repository.getTrending();
      notifyListeners();
    } else if (gridContent == GRID_CONTENT.TRENDING_TV &&
        (_trendingSeries == null || _trendingSeries.isEmpty)) {
      _trendingSeries = await _repository.getTrendingSeries();
      notifyListeners();
    }
  }

  Future synchronizeDashboard(BuildContext context) async {
    final MovieRepository _repository = MovieRepository.getInstance(context);
    if (_forDashboard.isEmpty) {
      _forDashboard = await _repository.getAllSaved();
      notifyListeners();
    }
  }

  Future synchronizeDashboardAlter(BuildContext context, {bool force = false}) async {
    final MovieRepository _repository = MovieRepository.getInstance(context);
    if (_trendings == null || _trendings.isEmpty || force) {
      _trendings = await _repository.getTrending();
      notifyListeners();
    }
    if (_trendingSeries == null || _trendingSeries.isEmpty || force) {
      _trendingSeries = await _repository.getTrendingSeries();
      notifyListeners();
    }
//    if (_forDashboard.isEmpty || force) {
      _forDashboard = await _repository.getAllSaved();
      notifyListeners();
//    }
  }

  Future fetchMore(BuildContext context) async {
    final MovieRepository _repository = MovieRepository.getInstance(context);
    _actualPage++;
    final result =
        await _repository.search(_actualSearchQuery, type: _actualSearchType, page: _actualPage);
    if (result != null) {
      _items.addAll(result.result);
      _hasMore = 10 * _actualPage < _totalSearchResult;
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

  Future calculateCountFavorites(BuildContext context) async {
    final MovieRepository _repository = MovieRepository.getInstance(context);
    _favsMoviesCount = await _repository.countFavouriteMovies(_types[FAVOURITE_THINGS.FILMS]);
    _favsSeriesCount = await _repository.countFavouriteMovies(_types[FAVOURITE_THINGS.SERIES]);

    _favsMovieImage = await _repository.getFavRandomWallpaper(types[FAVOURITE_THINGS.FILMS]);
    _favsSeriesImage = await _repository.getFavRandomWallpaper(types[FAVOURITE_THINGS.SERIES]);
    notifyListeners();
  }

  Future loadFavorites(BuildContext context, {FAVOURITE_THINGS type, String typeDc}) async {
    final MovieRepository _repository = MovieRepository.getInstance(context);
    final List<AudiovisualTableData> dbList =
        await _repository.getFavourites(type != null ? types[type] : typeDc);
    _favs = dbList
        .map((av) => AudiovisualProvider(
            type: types[type],
            title: av.titulo,
            imageUrl: av.image,
            id: av.id,
            image: av.image,
            isFavourite: av.isFavourite,
            year: av.anno))
        .toList();
    notifyListeners();
  }

  Future search2(String query, {String type}) async {
    List<AudiovisualProvider> result = [];
    var body = {
      "Search": [
        {
          "Title": "The Notebook",
          "Year": "2004",
          "imdbID": "tt0332280",
          "Type": "movie",
          "Poster":
              "https://m.media-amazon.com/images/M/MV5BMTk3OTM5Njg5M15BMl5BanBnXkFtZTYwMzA0ODI3._V1_SX300.jpg"
        },
        {
          "Title": "The Notebook",
          "Year": "2013",
          "imdbID": "tt2324384",
          "Type": "movie",
          "Poster":
              "https://m.media-amazon.com/images/M/MV5BMjU1MjYzOTc4NF5BMl5BanBnXkFtZTgwMjEyNTA0MjE@._V1_SX300.jpg"
        },
        {
          "Title": "Sara's Notebook",
          "Year": "2018",
          "imdbID": "tt6599742",
          "Type": "movie",
          "Poster":
              "https://m.media-amazon.com/images/M/MV5BNzlkNDc0MTQtYzU3NS00ZTdlLTlkOWMtZTI4OWUxYTNiZDM4XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg"
        },
        {
          "Title": "Notebook",
          "Year": "2019",
          "imdbID": "tt9105014",
          "Type": "movie",
          "Poster":
              "https://m.media-amazon.com/images/M/MV5BMTE2N2M3NjEtODhiNy00ZGIwLWI0NzUtYWViN2NhNjhiNjc1XkEyXkFqcGdeQXVyNjE1OTQ0NjA@._V1_SX300.jpg"
        },
        {
          "Title": "Notebook on Cities and Clothes",
          "Year": "1989",
          "imdbID": "tt0096852",
          "Type": "movie",
          "Poster":
              "https://m.media-amazon.com/images/M/MV5BMTY4MzQ0NDQ2Ml5BMl5BanBnXkFtZTYwNDA3MTg5._V1_SX300.jpg"
        },
        {
          "Title": "Notebook",
          "Year": "2006",
          "imdbID": "tt0924260",
          "Type": "movie",
          "Poster":
              "https://m.media-amazon.com/images/M/MV5BODcwMzYxMDQtZGVlOS00OGI5LWE1ODAtNmJjZjIyOGFmMWU5XkEyXkFqcGdeQXVyMjkxNzQ1NDI@._V1_SX300.jpg"
        },
        {
          "Title": "A Wanderer's Notebook",
          "Year": "1962",
          "imdbID": "tt0056081",
          "Type": "movie",
          "Poster":
              "https://m.media-amazon.com/images/M/MV5BNTAwZjdkM2EtNzE5Zi00YTJjLWI1NjUtZWFjYTg4YzI4MWMyXkEyXkFqcGdeQXVyNjc0MzE1MDI@._V1_SX300.jpg"
        },
        {
          "Title": "Notebook",
          "Year": "1963",
          "imdbID": "tt0305908",
          "Type": "movie",
          "Poster":
              "https://m.media-amazon.com/images/M/MV5BZjJiMDgxMzItOTUyZC00NWE5LWFkNmMtMTNhY2JiOWNmOGRlL2ltYWdlXkEyXkFqcGdeQXVyMjYxMzY2NDk@._V1_SX300.jpg"
        },
        {
          "Title": "From the Notebook of...",
          "Year": "2000",
          "imdbID": "tt0297901",
          "Type": "movie",
          "Poster":
              "https://m.media-amazon.com/images/M/MV5BOGU4ZGMxM2MtZTc3OS00Y2FmLWE5ZDAtYWJjZGM0YjE0OTk2XkEyXkFqcGdeQXVyNzg5OTk2OA@@._V1_SX300.jpg"
        },
        {
          "Title": "The Director's Notebook: The Cinematic Sleight of Hand of Christopher Nolan",
          "Year": "2007",
          "imdbID": "tt1035445",
          "Type": "movie",
          "Poster": "N/A"
        }
      ],
      "totalResults": "63",
      "Response": "True"
    };
    if ('True' == body['Response'] && int.parse(body['totalResults']) > 0) {
      for (var a in body['Search']) {
        var aa = new AudiovisualProvider(
            title: a['Title'],
            id: a['imdbID'],
            year: a['Year'],
            type: a['Type'],
            image: a['Poster'],
            imageUrl: a['Poster'],
            isFavourite: false);
        result.add(aa);
      }
    }
    _items = result;
    notifyListeners();
  }
}
