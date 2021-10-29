import 'package:movie_search/modules/person/model/credit.dart';
import 'package:movie_search/rest/resolver.dart';

class PersonService extends BaseService {
  static PersonService _instance;

  static PersonService getInstance() {
    if (_instance == null) _instance = PersonService._();
    return _instance;
  }

  PersonService._() : super();

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
