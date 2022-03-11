import 'package:movie_search/modules/audiovisual/model/image.dart';
import 'package:movie_search/modules/audiovisual/service/service.dart';
import 'package:movie_search/rest/resolver.dart';
import 'package:stacked/stacked.dart';

class ItemImagesViewModel extends FutureViewModel {
  final num id;
  final String type;

  ItemImagesViewModel(this.id, this.type);

  Map<MediaImageType, List<MediaImage>> _images = {};

  Map<MediaImageType, List<MediaImage>> get images => {..._images};

  @override
  Future futureToRun() async {
    setBusy(true);
    _images.addAll(await AudiovisualService.getInstance().getImagesGroup(type, id));
    setInitialised(true);
    setBusy(false);
  }
}
