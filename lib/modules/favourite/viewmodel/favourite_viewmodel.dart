import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:stacked/stacked.dart';

class FavouritesViewModel extends BaseViewModel {

  final MyDatabase _db;

  FavouritesViewModel(this._db);

  Stream<List<AudiovisualTableData>> get stream => _db.watchFavourites();

  initialize() {
    stream.listen((event) {
      notifyListeners();
    });
    setInitialised(true);
  }
}