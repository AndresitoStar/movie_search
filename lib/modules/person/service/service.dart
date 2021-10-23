import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/person/model/credit.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/rest/resolver.dart';

class PersonService extends BaseService {
  static PersonService _instance;

  static PersonService getInstance() {
    if (_instance == null) _instance = PersonService._();
    return _instance;
  }

  PersonService._() : super();

  Future<PersonListResponse> getPopulars({int page = 1}) async {
    List<Person> result = [];
    int total = 0;
    Map<String, String> params = {...baseParams, 'page': page.toString()};

    try {
      var response = await clientTMDB.get('person/popular', queryParameters: params);
      if (response.statusCode == 200) {
        result = [];
        final body = response.data;
        total = body['total_results'];
        for (var data in body['results']) {
          Person p = ResponseApiParser.personFromJsonApi(data);
          result.add(p);
        }
      }
    } catch (e) {}
    return PersonListResponse(result: result, totalResult: total);
  }

  final Map<int, Person> _cacheById = {};
  Future<Person> getById(int id) async {
    try {
      if (_cacheById.containsKey(id)) return _cacheById[id];
      var response = await clientTMDB.get('person/$id', queryParameters: baseParams);
      if (response.statusCode == 200) {
        final body = response.data;
        Person p = ResponseApiParser.personFromJsonApi(body);
        _cacheById.putIfAbsent(id, () => p);
        return p;
      }
    } catch (e) {}
    return null;
  }

  final Map<String, Credit> _cacheCredits = {};
  Future<Credit> getCredits(String type, int typeId) async {
    try {
      final id = '$typeId$type';
      if (_cacheCredits.containsKey(id)) return _cacheCredits[id];
      var response = await clientTMDB.get('$type/$typeId/credits', queryParameters: baseParams);
      if (response.statusCode == 200) {
        final body = response.data;
        Credit c = Credit.fromJson(body);
        _cacheCredits.putIfAbsent(id, () => c);
        return c;
      }
    } catch (e) {}
    return null;
  }
}
