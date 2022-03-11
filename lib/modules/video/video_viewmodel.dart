import 'package:movie_search/model/api/models/video.dart';
import 'package:movie_search/modules/video/service.dart';
import 'package:stacked/stacked.dart';

class VideoViewModel extends FutureViewModel {
  final String type;
  final num id;

  final VideoService _service;
  final List<Video> _videos = [];

  List<Video> get videos => [..._videos];

  bool get hasVideos => _videos.isNotEmpty;

  VideoViewModel(this.type, this.id) : this._service = VideoService();

  @override
  Future futureToRun() async {
    setBusy(true);
    try {
      final list = await _service.getVideos(type, id);
      _videos.addAll(list);
      setInitialised(true);
    } catch (e) {
      setError(e);
    }
    setBusy(false);
  }
}
