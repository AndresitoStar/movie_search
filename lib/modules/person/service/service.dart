import 'package:movie_search/modules/person/model/credit.dart';
import 'package:movie_search/modules/person/model/social.dart';
import 'package:movie_search/rest/resolver.dart';

class PersonService extends BaseService {
  static PersonService? _instance;

  static PersonService getInstance() {
    if (_instance == null) _instance = PersonService._();
    return _instance!;
  }

  PersonService._() : super();

  final Map<String, Credit> _cacheCredits = {};

  Future<Credit> getCredits(String type, num typeId) async => sendGET<Credit>(
        '$type/$typeId/credits',
        (data) => Credit.fromJson(data),
        idCache: '$typeId$type',
        cacheMap: _cacheCredits,
      );

  final Map<String, Social> _cacheSocial = {};

  Future<Social> getSocial(String type, num typeId) async => sendGET<Social>(
        '$type/$typeId/external_ids',
        (data) => Social.fromJson(data),
        idCache: '$typeId$type',
        cacheMap: _cacheSocial,
      );
}
