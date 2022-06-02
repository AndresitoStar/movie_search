import 'package:movie_search/modules/person/model/social.dart';
import 'package:movie_search/modules/person/service/service.dart';
import 'package:stacked/stacked.dart';

class SocialViewModel extends FutureViewModel {
  final PersonService _service;
  final String type;
  final num typeId;

  Social? social;

  SocialViewModel(this.type, this.typeId) : _service = PersonService.getInstance();

  @override
  Future futureToRun() async {
    setBusy(true);
    try {
      social = await _service.getSocial(type, typeId);
      setInitialised(true);
      clearErrors();
      setBusy(false);
    } catch (e) {
      print(e);
      setError(e);
    }
  }
}
