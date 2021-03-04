import 'package:movie_search/data/moor_database.dart';
import 'package:stacked/stacked.dart';

class FavouritesViewModel extends BaseViewModel {

  final MyDatabase _db;

  FavouritesViewModel(this._db);

  Stream<List<Movie>> get streamMovies => _db.watchFavouritesMovie();
  Stream<List<TvShow>> get streamTvShow => _db.watchFavouritesTvShow();
  Stream<List<Person>> get streamPerson => _db.watchFavouritesPerson();

  initialize() {
    // streamMovies.listen((event) {
    //   notifyListeners();
    // });
    // streamTvShow.listen((event) {
    //   notifyListeners();
    // });
    // streamPerson.listen((event) {
    //   notifyListeners();
    // });
    setInitialised(true);
  }
}