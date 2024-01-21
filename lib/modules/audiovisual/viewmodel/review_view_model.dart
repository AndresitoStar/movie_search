import 'package:movie_search/model/api/models/review.dart';
import 'package:movie_search/modules/audiovisual/service/service.dart';
import 'package:stacked/stacked.dart';

class ReviewViewModel extends FutureViewModel {
  final String type;
  final num id;

  ReviewResponse? _response;

  List<Review> get reviews => [...?_response?.results];

  bool get hasReviews => reviews.isNotEmpty;

  int get badgeLabel => reviews.length;

  ReviewViewModel({required this.type, required this.id});

  @override
  Future futureToRun() async {
    setBusy(true);
    try {
      _response = await AudiovisualService.getInstance().getReviews(type: type, id: id);
      setInitialised(true);
    } catch (e) {
      setError(e);
    }
    setBusy(false);
  }
}
