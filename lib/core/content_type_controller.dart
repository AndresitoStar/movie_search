import 'package:movie_search/providers/util.dart';

class ContentTypeController {
  static ContentTypeController? _instance;

  static ContentTypeController getInstance() {
    if (_instance == null) _instance = ContentTypeController._();
    return _instance!;
  }

  ContentTypeController._() : super();

  TMDB_API_TYPE? _type;



  loadCurrentType() async {
    //TODO obtiene el type del storage si tiene, si no pone uno por defecto
  }

  updateCurrentType() async {

  }
}