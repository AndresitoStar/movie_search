import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/rest/resolver.dart';
import 'package:flutter/cupertino.dart';
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

  Future<List<AudiovisualProvider>> getTrending() async {
    return _resolver.getTrending();
  }

  Future<List<AudiovisualProvider>> getTrendingSeries() async {
    return _resolver.getTrendingSeries();
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
//    final result = await findMyData2();
    final result = await _resolver.findMovieById(id);
    db.insertAudiovisual(result);
    return result;
  }

  Future<AudiovisualTableData> getByTrendingId(String trendingId) async {
    final localData = await db.getAudiovisualByExternalId(trendingId);
    if (localData != null) {
      return localData;
    }
    final result = await _resolver.getByTrendingId(trendingId);
    if(result != null) {
      db.insertAudiovisual(result);
    }
    return result;
  }

  Future findMyData2() async {
    var result = {
      "Title": "The Notebook",
      "Year": "2004",
      "Rated": "PG-13",
      "Released": "25 Jun 2004",
      "Runtime": "123 min",
      "Genre": "Drama, Romance",
      "Director": "Nick Cassavetes",
      "Writer": "Jeremy Leven (screenplay), Jan Sardi (adaptation), Nicholas Sparks (novel)",
      "Actors": "Tim Ivey, Gena Rowlands, Starletta DuPois, James Garner",
      "Plot":
          "In a nursing home, resident Duke reads a romance story for an old woman who has senile dementia with memory loss. In the late 1930s, wealthy seventeen year-old Allie Hamilton is spending summer vacation in Seabrook. Local worker Noah Calhoun meets Allie at a carnival and they soon fall in love with each other. One day, Noah brings Allie to an ancient house that he dreams of buying and restoring and they attempt to make love but get interrupted by their friend. Allie's parents do not approve of their romance since Noah belongs to another social class, and they move to New York with her. Noah writes 365 letters (A Year) to Allie, but her mother Anne Hamilton does not deliver them to her daughter. Three years later, the United States joins the World War II and Noah and his best friend Fin enlist in the army, and Allie works as an army nurse. She meets injured soldier Lon Hammond in the hospital. After the war, they meet each other again going on dates and then, Lon, who is wealthy and handsome, proposes. Meanwhile Noah buys and restores the old house and many people want to buy it. When Allie accidentally sees the photo of Noah and his house in a newspaper, she feels divided between her first love and her commitment with Lon. Meanwhile Duke stops reading to the old lady since his children are visiting him in the nursing home.",
      "Language": "English",
      "Country": "USA",
      "Awards": "12 wins & 10 nominations.",
      "Poster":
          "https://m.media-amazon.com/images/M/MV5BMTk3OTM5Njg5M15BMl5BanBnXkFtZTYwMzA0ODI3._V1_SX300.jpg",
      "Ratings": [
        {"Source": "Internet Movie Database", "Value": "7.8/10"},
        {"Source": "Rotten Tomatoes", "Value": "53%"},
        {"Source": "Metacritic", "Value": "53/100"}
      ],
      "Metascore": "53",
      "imdbRating": "7.8",
      "imdbVotes": "492,343",
      "imdbID": "tt0332280",
      "Type": "movie",
      "DVD": "08 Feb 2005",
      "BoxOffice": "81,000,000",
      "Production": "New Line Cinema",
      "Website": "N/A",
      "Response": "True"
    };
    var fullData = AudiovisualTableData(
        id: result["imdbID"],
        image: result["Poster"],
        anno: result["Year"],
        capitulos: result["Episodes"],
        director: result["Director"],
        duracion: result["Runtime"],
        productora: result["Production"],
        idioma: result["Language"],
        pais: result["Country"],
        score: result["imdbRating"],
        reparto: result["Actors"],
        sinopsis: result["Plot"],
        titulo: result["Title"],
        isFavourite: false,
        genre: result["Genre"]);
    return fullData;
  }
}
