import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/service/service.dart';
import 'package:movie_search/modules/person/service/service.dart';
import 'package:movie_search/providers/util.dart';
import 'package:stacked/stacked.dart';

class ItemLikeButtonViewModel extends BaseViewModel {
  final AudiovisualService _audiovisualService;
  final PersonService _personService;
  final MyDatabase _db;
  final TMDB_API_TYPE type;

  ItemLikeButtonViewModel(this._db, this.type)
      : _personService = PersonService.getInstance(),
        _audiovisualService = AudiovisualService.getInstance();

  Stream<List<int>> get stream {
    if (type == TMDB_API_TYPE.MOVIE)
      return _db.watchFavouritesMovieId();
    else if (type == TMDB_API_TYPE.TV_SHOW)
      return _db.watchFavouritesTvShowId();
    else if (type == TMDB_API_TYPE.PERSON)
      return _db.watchFavouritesPersonId();
    return null;
  }

  initialize() {
    if (type == TMDB_API_TYPE.MOVIE)
      _db.watchFavouritesMovieId().listen((event) {
        notifyListeners();
      });
    else if (type == TMDB_API_TYPE.TV_SHOW)
      _db.watchFavouritesTvShowId().listen((event) {
        notifyListeners();
      });
    else if (type == TMDB_API_TYPE.PERSON)
      _db.watchFavouritesPersonId().listen((event) {
        notifyListeners();
      });
    setInitialised(true);
  }

  Future toggleFavourite(int id) async {
    setBusy(true);
    try {
      if (type == TMDB_API_TYPE.MOVIE) {
        if (await _db.getMovieById(id) == null) await _cacheData(id);
        await _db.toggleFavouriteMovie(id);
      } else if (type == TMDB_API_TYPE.TV_SHOW) {
        if (await _db.getTvShowById(id) == null) await _cacheData(id);
        await _db.toggleFavouriteTvShow(id);
      } else if (type == TMDB_API_TYPE.PERSON) {
        if (await _db.getPersonById(id) == null) await _cacheData(id);
        await _db.toggleFavouritePerson(id);
      }
    } catch (e) {
      setError(e);
    }
    setBusy(false);
  }

  _cacheData(int id) async {
    if (type == TMDB_API_TYPE.MOVIE) {
      final Movie av = await _audiovisualService.getById(id: id, type: type.type);
      await _db.insertMovie(av);
    } else if (type == TMDB_API_TYPE.TV_SHOW) {
      final TvShow av = await _audiovisualService.getById(id: id, type: type.type);
      await _db.insertTvShow(av);
    } else if (type == TMDB_API_TYPE.PERSON) {
      final Person person = await _personService.getById(id);
      await _db.insertPerson(person);
    }
  }
}
