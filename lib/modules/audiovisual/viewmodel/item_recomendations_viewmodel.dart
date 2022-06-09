import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/service/service.dart';
import 'package:stacked/stacked.dart';

enum ERecommendationType { Recommendation, Similar, Credit }

extension recommendation_type on ERecommendationType {
  String get type {
    switch (this) {
      case ERecommendationType.Recommendation:
        return 'recommendations';
      case ERecommendationType.Similar:
        return 'similar';
      case ERecommendationType.Credit:
        return 'combined_credits';
    }
  }

  String get name {
    switch (this) {
      case ERecommendationType.Recommendation:
        return 'Recomendaciones';
      case ERecommendationType.Similar:
        return 'Similares';
      case ERecommendationType.Credit:
        return 'Participaciones';
    }
  }
}

class ItemRecommendationViewModel extends FutureViewModel {
  final AudiovisualService _service;
  final String type;
  final num typeId;
  final ERecommendationType recommendationType;

  List<BaseSearchResult> _items = [];

  List<BaseSearchResult> get items => [..._items];

  ItemRecommendationViewModel(this.type, this.typeId, this.recommendationType)
      : _service = AudiovisualService.getInstance();

  @override
  Future futureToRun() async {
    setBusy(true);
    try {
      if (recommendationType == ERecommendationType.Credit)
        _items.addAll(await _service.getPersonCombinedCredits(typeId));
      else
        _items.addAll(await _service.getRecommendations(type, typeId, recommendationType));
      setInitialised(true);
      setBusy(false);
    } catch (e) {
      setError(e);
    }
  }
}
