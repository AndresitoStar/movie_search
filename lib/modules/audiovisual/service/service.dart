import 'dart:math';

import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/model/movie.dart';
import 'package:movie_search/modules/audiovisual/model/serie.dart';
import 'package:movie_search/rest/resolver.dart';

class AudiovisualService extends BaseService {
  static AudiovisualService _instance;

  static AudiovisualService getInstance() {
    if (_instance == null) _instance = AudiovisualService._();
    return _instance;
  }

  AudiovisualService._() : super();
  
  Future<ModelBase> getById<T extends ModelBase>(
      {String type, String id}) async {
    Map<String, String> params = {
      ...baseParams,
      'append_to_response': 'images',
      'include_image_language': 'en,null'
    };

    var response = await clientTMDB.get('$type/$id', queryParameters: params);
    if (response.statusCode == 200) {
      final data = response.data;
      ModelBase av;
      try {
        av = ModelBase.fromJson(T, data);
      } catch (e) {
        if (type == 'movie') {
          av = Movie()..fromJsonP(data);
        } else if (type == 'tv') {
          av = TvShow()..fromJsonP(data);
        }
      }

      String paises;
      String anno;
      String duracion;
      if (type == 'movie') {
        paises = data['production_countries'] != null &&
                data['production_countries'].isNotEmpty
            ? data['production_countries']
                ?.map((e) => e['name'])
                ?.reduce((value, element) => '$value' + ',' + '$element')
            : null;
        anno = data['release_date'];
        duracion = '${data["runtime"]}';
      } else if (type == 'tv') {
        paises = data['origin_country'] != null
            ? data['origin_country']
                ?.reduce((value, element) => value + ',' + element)
            : null;
        anno = data['first_air_date'];
        final List episodesRuntime = data["episode_run_time"];
        if (episodesRuntime != null)
          duracion = episodesRuntime
              ?.reduce((value, element) => min<num>(value, element))
              ?.toString();
      } else if (type == 'person') {
        // TODO converti
      }

      var fullData = AudiovisualTableData(
          id: av.id,
          externalId: av.id,
          image: av.image,
          anno: DateTime.tryParse(anno)?.year?.toString(),
          duracion: duracion,
          productora: data['production_companies'] != null &&
                  data['production_companies'].isNotEmpty
              ? data['production_companies']
                  ?.map((e) => e['name'])
                  ?.reduce((value, element) => '$value' + ',' + '$element')
              : null,
          idioma: data["original_language"],
          pais: paises,
          score: await _getImdbRating(data["imdb_id"]) ??
              '${data['vote_average']}',
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
          category: type,
          isFavourite: false,
          genre: data['genres']
              ?.map((e) => e['name'])
              ?.reduce((value, element) => '$value' + ',' + '$element'));
      av.fromData(fullData);
      return av;
    }
    return null;
  }

  Future<String> _getImdbRating(String imdbId) async {
    try {
      var params = {'apikey': '9eb7fce9', 'i': imdbId, 'r': 'json'};
      var response = await clientOMDB.get('/', queryParameters: params);
      if (response.statusCode == 200) {
        var result = response.data;
        return result["imdbRating"];
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
