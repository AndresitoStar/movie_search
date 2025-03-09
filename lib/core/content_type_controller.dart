import 'package:movie_search/providers/util.dart';

class ContentTypeController {
  static ContentTypeController? _instance;

  static ContentTypeController getInstance() {
    if (_instance == null) _instance = ContentTypeController._();
    return _instance!;
  }

  ContentTypeController._() : super();

  TMDB_API_TYPE? _type;

  TMDB_API_TYPE get currentType => _type!;

  loadCurrentType() async {
    try {
      final type = await SharedPreferencesHelper.getContentTypeSelected();
      if (type != null) _type = TMDB_API_TYPE.values.firstWhere((element) => element.toString() == type);
      else _type = TMDB_API_TYPE.MOVIE;
    } on Exception {
      _type = TMDB_API_TYPE.MOVIE;
    }
  }

  updateCurrentType(TMDB_API_TYPE type) async {
    SharedPreferencesHelper.setContentTypeSelected(type.toString());
    _type = type;
  }
}