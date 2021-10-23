import 'package:flutter/cupertino.dart';
import 'package:movie_search/model/api/models/movie.dart';
import 'package:movie_search/model/api/models/tv.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_recomendations_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/rest/resolver.dart';

class AudiovisualService extends BaseService {
  static AudiovisualService _instance;

  static AudiovisualService getInstance() {
    if (_instance == null) _instance = AudiovisualService._();
    return _instance;
  }

  AudiovisualService._() : super();

  final Map<int, dynamic> _cacheById = {};
  final Map<String, List<BaseSearchResult>> _cacheRecommendation = {};
  final Map<int, Collection> _cacheCollection = {};
  final Map<String, Seasons> _cacheSeason = {};
  final Map<int, List<BaseSearchResult>> _cacheCredits = {};

  Future<dynamic> getById({@required String type, @required int id}) async {
    if (_cacheById.containsKey(id)) {
      return _cacheById[id];
    }
    var result;
    Map<String, String> params = {...baseParams, 'include_image_language': 'en,null'};

    var response = await clientTMDB.get('$type/$id', queryParameters: params);
    if (response.statusCode == 200) {
      final data = response.data;
      if (type == 'person') {
        result = ResponseApiParser.personFromJsonApi(data);
      } else if (type == 'movie') {
        result = MovieApi.fromJson(data);
      } else if (type == 'tv') {
        result = TvApi.fromJson(data);
      }
    }
    _cacheById.putIfAbsent(id, () => result);
    return result;
  }

  Future<List<BaseSearchResult>> getRecommendations(
      String type, int typeId, ERecommendationType recommendationType) async {
    List<BaseSearchResult> result = [];
    final id = '$typeId$type${recommendationType.type}';
    try {
      if (_cacheRecommendation.containsKey(id)) {
        return _cacheRecommendation[id];
      }
      var response = await clientTMDB.get('$type/$typeId/${recommendationType.type}', queryParameters: baseParams);
      if (response.statusCode == 200) {
        final data = response.data;
        final list = data['results'] as List;
        if (list != null) {
          for (var i = 0; i < list.length; i++) {
            BaseSearchResult b = BaseSearchResult.fromJson(type, list[i]);
            if (b != null) result.add(b);
          }
        }
      }
    } catch (e) {}
    if (result.isNotEmpty) result.sort((a, b) => a.year == null || b.year == null ? 1 : b.year.compareTo(a.year));
    _cacheRecommendation.putIfAbsent(id, () => result);
    return result;
  }

  Future<Collection> getCollection(int id) async {
    try {
      if (_cacheCollection.containsKey(id)) {
        return _cacheCollection[id];
      }
      var response = await clientTMDB.get('collection/$id', queryParameters: baseParams);
      if (response.statusCode == 200) {
        final result = Collection.fromJson(response.data);
        _cacheCollection.putIfAbsent(id, () => result);
        return result;
      }
    } catch (e) {}
    return null;
  }

  Future<Seasons> getSeason(int id, int seasonNumber) async {
    final idCache = '$id$seasonNumber';
    try {
      if (_cacheSeason.containsKey(idCache)) {
        return _cacheSeason[idCache];
      }
      var response = await clientTMDB.get('tv/$id/season/$seasonNumber', queryParameters: baseParams);
      if (response.statusCode == 200) {
        final result = Seasons.fromJson(response.data);
        _cacheSeason.putIfAbsent(idCache, () => result);
        return result;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<BaseSearchResult>> getPersonCombinedCredits(int id) async {
    List<BaseSearchResult> result = [];
    try {
      if (_cacheCredits.containsKey(id)) {
        return _cacheCredits[id];
      }
      var response = await clientTMDB.get('person/$id/combined_credits', queryParameters: baseParams);
      if (response.statusCode == 200) {
        final json = response.data;
        if (json['cast'] != null) {
          json['cast'].forEach((v) {
            final type = v['media_type'];
            result.add(BaseSearchResult.fromJson(type, v));
          });
        }
        if (json['crew'] != null) {
          json['crew'].forEach((v) {
            final type = v['media_type'];
            result.add(BaseSearchResult.fromJson(type, v));
          });
        }
        result.sort((a, b) => a.year == null || b.year == null ? 1 : b.year.compareTo(a.year));
        _cacheCredits.putIfAbsent(id, () => result);
      }
    } catch (e) {
      print(e);
    }
    return result;
  }
}
