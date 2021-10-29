import 'package:movie_search/model/api/models/tv.dart';
import 'package:movie_search/modules/audiovisual/service/service.dart';
import 'package:stacked/stacked.dart';

class ItemSeasonViewModel extends FutureViewModel {
  final AudiovisualService _service;
  Seasons season;
  final TvShow tvApi;

  ItemSeasonViewModel(this.season, this.tvApi) : _service = AudiovisualService.getInstance();

  @override
  Future futureToRun() async {
    setBusy(true);
    season = await _service.getSeason(tvApi.id, season.seasonNumber);
    notifyListeners();
    setInitialised(true);
    setBusy(false);
  }
}
