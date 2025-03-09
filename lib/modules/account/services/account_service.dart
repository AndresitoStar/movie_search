import 'package:movie_search/rest/resolver.dart';

class AccountService extends BaseService {
  static AccountService? _instance;

  static AccountService getInstance() {
    if (_instance == null) _instance = AccountService._();
    return _instance!;
  }

  AccountService._() : super();

  Future<String> createRequestToken(String type, num typeId) async => sendGET<String>(
        'authentication/token/new',
        (data) => data['request_token'],
      );
}
