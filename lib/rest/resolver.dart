import 'dart:convert';
import 'dart:io';
import 'dart:math';

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
    dio.options.connectTimeout = 20000; //5s
    dio.options.receiveTimeout = 20000;

    return dio;
  }

  Dio _client;
  Map<String, dynamic> _baseParams = {
    'api_key': '3e56846ee7cfb0b7d870484a9f66218c',
    'language': 'es-ES',
  };

  static RestResolver _instance;

  static RestResolver getInstance() {
    if (_instance == null) _instance = RestResolver._();
    return _instance;
  }

  RestResolver._() {
    this._client = new Dio(); // with default Options
    _client.options.baseUrl = 'https://api.themoviedb.org/3/';
    _client.options.connectTimeout = 20000; //5s
    _client.options.receiveTimeout = 20000;
  }

  Future<SearchResponse> search(String query, {String type, @required int page}) async {
    List<AudiovisualProvider> result = [];
    int totalResults = -1;
    int totalPagesResult = -1;
    print('page: $page');

    try {
      Map<String, String> params = {
        ..._baseParams,
        'query': query,
        'page': page.toString(),
      };

      var response = await _client.get('search/${type ?? 'multi'}', queryParameters: params);
      if (response.statusCode == 200) {
        result = [];
        var body = response.data;
        totalResults = body['total_results'];
        totalPagesResult = body['total_pages'];
        if (totalResults > 0) {
          for (var data in body['results']) {
            final mediaType = data['media_type'] ?? type;
            if (mediaType == 'person')
              continue; // TODO quitar para buscar personas
            else {
              AudiovisualProvider av;
              if (mediaType == 'movie') {
                av = AudiovisualProvider.fromJsonTypeMovie(data);
              } else if (mediaType == 'tv') {
                av = AudiovisualProvider.fromJsonTypeTv(data);
              }
              if (av != null &&
                  av.sinopsis != null &&
                  av.yearOriginal != null /*&& av.image != null*/) result.add(av);
            }
          }
        }
      } else {
        print(response.statusCode);
        //TODO LANZAR EXCEPTION
      }
    } catch (e) {
      print(e);
    }

    return new SearchResponse(
        result: result, totalResult: totalResults, totalPageResult: totalPagesResult);
  }

  Future<SearchResponse> getTrending(TMDB_API_TYPE type, {int page = 1}) async {
    List<AudiovisualProvider> result = [];
    int total = 0;

    const url = 'api.themoviedb.org';

    Map<String, String> params = {..._baseParams, 'page': page.toString()};
    var uri = Uri.https(url, '/3/trending/${type.type}/week', params);
    try {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        result = [];
        final body = jsonDecode(response.body);
        total = body['total_results'];
        for (var data in body['results']) {
          AudiovisualProvider av;
          if (type == TMDB_API_TYPE.TV_SHOW) {
            av = new AudiovisualProvider.fromJsonTypeTv(data);
          } else if (type == TMDB_API_TYPE.MOVIE) {
            av = new AudiovisualProvider.fromJsonTypeMovie(data);
          }
          if (av != null) result.add(av);
        }
      }
    } catch (e) {
      print(e);
      if (e is SocketException) {
        throw e;
      }
    }
    return SearchResponse(result: result, totalResult: total);
  }

  Future<AudiovisualTableData> getById({String type, String id}) async {
    Map<String, String> params = {
      ..._baseParams,
      'append_to_response': 'images',
      'include_image_language': 'en,null'
    };

    var response = await _client.get('$type/$id', queryParameters: params);
    if (response.statusCode == 200) {
      final data = response.data;
      AudiovisualProvider av;
      String paises;
      String anno;
      String duracion;
      if (type == 'movie') {
        av = AudiovisualProvider.fromJsonTypeMovie(data);
        paises = data['production_countries'] != null && data['production_countries'].isNotEmpty
            ? data['production_countries']
                ?.map((e) => e['name'])
                ?.reduce((value, element) => '$value' + ',' + '$element')
            : null;
        anno = data['release_date'];
        duracion = '${data["runtime"]}';
      } else if (type == 'tv') {
        av = AudiovisualProvider.fromJsonTypeTv(data);
        paises = data['origin_country'] != null
            ? data['origin_country']?.reduce((value, element) => value + ',' + element)
            : null;
        anno = data['first_air_date'];
        final List episodesRuntime = data["episode_run_time"];
        if (episodesRuntime != null)
          duracion =
              episodesRuntime?.reduce((value, element) => min<num>(value, element))?.toString();
      } else if (type == 'person') {
        // TODO convertir
        // av = AudiovisualProvider.fromJsonTypeTv(data);
      }

      var fullData = AudiovisualTableData(
          id: av.id,
          externalId: av.id,
          image: av.image,
          anno: DateTime.tryParse(anno)?.year?.toString(),
          duracion: duracion,
          productora:
              data['production_companies'] != null && data['production_companies'].isNotEmpty
                  ? data['production_companies']
                      ?.map((e) => e['name'])
                      ?.reduce((value, element) => '$value' + ',' + '$element')
                  : null,
          idioma: data["original_language"],
          pais: paises,
          score: await getImdbRating(data["imdb_id"]) ?? '${data['vote_average']}',
          temp: data['seasons'] != null ? '${data['seasons'].length}' : null,
          capitulos: data['seasons'] != null
              ? data['seasons']
                  .map((e) => e['episode_count'])
                  ?.reduce((value, element) => value + element)
                  .toString()
              : null,
          // reparto: data["Actors"],
          sinopsis: av.sinopsis,
          titulo: av.title,
          category: av.type,
          isFavourite: false,
          genre: data['genres']
              ?.map((e) => e['name'])
              ?.reduce((value, element) => '$value' + ',' + '$element'));
      return fullData;
    }
    return null;
  }

  Future<String> getImdbRating(String imdbId) async {
    try {
      const url = 'www.omdbapi.com';
      var params = {'apikey': '9eb7fce9', 'i': imdbId, 'r': 'json'};
      var uri = Uri.http(url, '/', params);
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result["imdbRating"];
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Map<String, String>> getCountries() async {
    Map<String, String> result = {};

    try {
      var response = await _client.get('/configuration/countries', queryParameters: _baseParams);
      if (response.statusCode == 200) {
        var body = response.data as List<dynamic>;
        if (body.isNotEmpty) {
          result = Map.fromIterable(body,
              key: (item) => item['iso_3166_1'], value: (item) => item['english_name']);
        }
      } else {
        print(response.statusCode);
        //TODO LANZAR EXCEPTION
      }
    } catch (e) {
      print(e);
    }

    return result;
  }

  Future<Map<String, String>> getLanguages() async {
    Map<String, String> result = {};

    try {
      var response = await _client.get('/configuration/languages', queryParameters: _baseParams);
      if (response.statusCode == 200) {
        var body = response.data as List<dynamic>;
        if (body.isNotEmpty) {
          result = Map.fromIterable(body,
              key: (item) => item['iso_639_1'], value: (item) => item['english_name']);
        }
      } else {
        print(response.statusCode);
        //TODO LANZAR EXCEPTION
      }
    } catch (e) {
      print(e);
    }

    return result;
  }
}
