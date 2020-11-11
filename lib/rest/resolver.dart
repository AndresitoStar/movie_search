import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/providers/util.dart';

class RestResolver {
  Dio getDioClient() {
    Dio dio = new Dio(); // with default Options
    dio.options.baseUrl = 'https://www.omdbapi.com';
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 3000;

    return dio;
  }

  Future<SearchMovieResponse> searchMovie(String query, {String type, @required int page}) async {
    List<AudiovisualProvider> result = [];

    int totalResults = -1;
    try {
      const url = 'www.omdbapi.com';
      Map<String, String> params = {
        'apikey': '9eb7fce9',
        's': query,
        'r': 'json',
        'page': page.toString()
      };
      if (type != null && type.isNotEmpty) {
        params = {
          'apikey': '9eb7fce9',
          's': query,
          'r': 'json',
          'type': type,
          'page': page.toString()
        };
      }

      var client = getDioClient();
      var response = await client.get('/', queryParameters: params);
      if (response.statusCode == 200) {
        result = [];
        var body = response.data;
        if ('True' == body['Response'] && int.parse(body['totalResults']) > 0) {
          totalResults = int.parse(body['totalResults']);
          for (var a in body['Search']) {
            if (a['Type'] == 'game') continue;
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
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }

    return new SearchMovieResponse(result: result, totalResult: totalResults);
  }

  Future<AudiovisualTableData> getByTrendingId(String id, String type) async {
    const url = 'api.themoviedb.org';

    Map<String, String> params = {'api_key': '3e56846ee7cfb0b7d870484a9f66218c'};
    var uri = Uri.https(url, '/3/$type/$id/external_ids', params);
    try {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
//        final body = jsonDecode(DummyData.TRENDING_RESPONSE);
        final imdbId = body['imdb_id'];
        return findMovieById(imdbId, externalId: id);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<SearchMovieResponse> getTrending({int page = 1}) async {
    List<AudiovisualProvider> result = [];
    int total = 0;

    const url = 'api.themoviedb.org';

    Map<String, String> params = {
      'api_key': '3e56846ee7cfb0b7d870484a9f66218c',
      'page': page.toString()
    };
    var uri = Uri.https(url, '/3/trending/movie/week', params);
    try {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        result = [];
        final body = jsonDecode(response.body);
//        final body = jsonDecode(DummyData.TRENDING_RESPONSE);
        total = body['total_results'];
        for (var a in body['results']) {
          var aa = new AudiovisualProvider(
              title: a['title'],
              id: a['id']?.toString(),
              image: 'http://image.tmdb.org/t/p/w185${a['poster_path']}',
              type: a['media_type'],
              isTrending: true,
              voteAverage: a['vote_average'],
              imageUrl: 'http://image.tmdb.org/t/p/w185${a['poster_path']}',
              isFavourite: false);
          result.add(aa);
        }
      }
    } catch (e) {
      print(e);
    }
    return SearchMovieResponse(result: result, totalResult: total);
  }

  Future<SearchMovieResponse> getTrendingSeries({int page = 1}) async {
    List<AudiovisualProvider> result = [];
    int total = 0;

    const url = 'api.themoviedb.org';

    Map<String, String> params = {
      'api_key': '3e56846ee7cfb0b7d870484a9f66218c',
      'page': page.toString()
    };
    var uri = Uri.https(url, '/3/trending/tv/week', params);
    try {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        result = [];
        final body = jsonDecode(response.body);
        total = body['total_results'];
        for (var a in body['results']) {
          var aa = new AudiovisualProvider(
              title: a['original_name'],
              id: a['id']?.toString(),
              image: 'http://image.tmdb.org/t/p/w185${a['poster_path']}',
              type: a['media_type'],
              isTrending: true,
              voteAverage: a['vote_average'],
              imageUrl: 'http://image.tmdb.org/t/p/w185${a['poster_path']}',
              isFavourite: false);
          result.add(aa);
        }
      }
    } catch (e) {
      print(e);
    }
    return SearchMovieResponse(result: result, totalResult: total);
  }

//  Future<List<GameProvider>> searchGames(String query,
//      {@required int offset}) async {
//    await countGames(query);
//    List<GameProvider> result;
//    const url = 'https://api-v3.igdb.com/games';
//    const headers = {'user-key': '26c513d89314b2f280e551a4bbb1eff0'};
//    final body =
//        'fields name,first_release_date,platforms.name;where first_release_date != null; offset $offset; search "$query";';
//    try {
//      var response = await http.post(url, headers: headers, body: body);
//      if (response.statusCode == 200) {
//        result = [];
//        var body = jsonDecode(response.body);
//        for (var a in body) {
//          if (a["first_release_date"] == null) {
//            continue;
//          }
//          final List plataformas = a["platforms"];
////          print(plataformas?.map((a) => a["name"].toString()));
//          final platform =
//              plataformas?.map((a) => a["name"].toString())?.join(', ');
//          final fechaLanzamiento = new DateTime.fromMillisecondsSinceEpoch(
//              (a["first_release_date"] as int) * 1000);
//          var game = new GameProvider(
//              title: a['name'],
//              id: a['id'].toString(),
//              year: DateFormat.y().format(fechaLanzamiento),
//              platforms: platform,
//              isFavourite: false);
//          result.add(game);
//        }
//      } else
//        print(response.statusCode);
//    } catch (e) {
//      print(e);
//    }
//    return result;
//  }

//  Future countGames(String query) async {
//    List<GameProvider> result;
//    const url = 'https://api-v3.igdb.com/games/count';
//    const headers = {'user-key': '26c513d89314b2f280e551a4bbb1eff0'};
//    final body = 'where first_release_date != null; search "$query";';
//    try {
//      var response = await http.post(url, headers: headers, body: body);
//      if (response.statusCode == 200) {
//        result = [];
//        var body = jsonDecode(response.body);
//        print('$query - $body');
//      } else
//        print(response.statusCode);
//    } catch (e) {
//      print(e);
//    }
//    return result;
//  }

  Future<AudiovisualTableData> findMovieById(String id, {String externalId}) async {
    try {
      const url = 'www.omdbapi.com';
      var params = {'apikey': '9eb7fce9', 'i': id, 'r': 'json', 'plot': 'full'};
      var uri = Uri.http(url, '/', params);
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var fullData = AudiovisualTableData(
            id: result["imdbID"],
            externalId: externalId,
            image: result["Poster"],
            anno: result["Year"],
            director: result["Director"],
            duracion: result["Runtime"],
            productora: result["Production"],
            idioma: result["Language"],
            pais: result["Country"],
            score: result["imdbRating"],
            temp: result["totalSeasons"],
            capitulos: result["Writer"],
            reparto: result["Actors"],
            sinopsis: await translate(result["Plot"]),
            titulo: result["Title"],
            category: result["Type"],
            isFavourite: false,
            genre: result["Genre"]);
        return fullData;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<AudiovisualTableData> findMovieByTitle(String title) async {
    try {
      const url = 'www.omdbapi.com';
      var params = {'apikey': '9eb7fce9', 't': title, 'r': 'json', 'plot': 'full'};
      var uri = Uri.http(url, '/', params);
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var fullData = AudiovisualTableData(
            id: result["imdbID"],
            image: result["Poster"],
            anno: result["Year"],
            director: result["Director"],
            duracion: result["Runtime"],
            productora: result["Production"],
            idioma: result["Language"],
            pais: result["Country"],
            score: result["imdbRating"],
            temp: result["totalSeasons"],
            capitulos: result["Writer"],
            reparto: result["Actors"],
            sinopsis: await translate(result["Plot"]),
            titulo: result["Title"],
            category: result["Type"],
            isFavourite: false,
            genre: result["Genre"]);
        return fullData;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future findGameById(String id) async {
    try {
      const url = 'https://api-v3.igdb.com/games';
      const headers = {'user-key': '26c513d89314b2f280e551a4bbb1eff0'};
      final body =
          'fields id,franchise.name,cover.image_id,name,rating,first_release_date,genres.name,platforms.name,summary;where id = $id;';
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(result);

        //id,franchise.name,cover.url,category,name,rating,created_at,genres.name,platforms.name,summary
        // image
        final Map cover = result[0]["cover"];
        // genre
        final List genres = result[0]["genres"];
        final genre = genres?.map((a) => a["name"])?.join(', ');
        // empresa
//        final empresas = result[0]["franchise"];
//        final empresa = empresas?.map((a) => a["name"])?.join(', ');

        // plataformas
        final List plataformas = result[0]["platforms"];
        final platform = plataformas?.map((a) => a["name"])?.join(', ');
        // rating
        final double rating = await result[0]["rating"];
        // anno
        final fechaLanzamiento = new DateTime.fromMillisecondsSinceEpoch(
            (result[0]["first_release_date"] as int) * 1000);
        var fullData = GameTableData(
            id: result[0]["id"].toString(),
            image: cover != null ? cover["image_id"] : null,
//            empresa: empresa,
            plataformas: platform,
            fechaLanzamiento: fechaLanzamiento,
            score: rating?.round()?.toString(),
            sinopsis: await translate(result[0]["summary"]),
            titulo: result[0]["name"],
            isFavourite: false,
            genre: genre ?? '-');
        return fullData;
      }
    } catch (e) {
      print('findGameById -> $e');
    }
    return null;
  }

  Future translate(String text) async {
    const url = 'translate.googleapis.com';
    var params = {'client': 'gtx', 'sl': 'auto', 'tl': 'es', 'dt': 't', 'q': text};
    var uri = Uri.https(url, '/translate_a/single', params);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      String resultText = '';
      for (var s in result[0]) {
        resultText += s[0];
      }
      return resultText;
    }
    return null;
  }
}
