import 'package:movie_search/model/api/models/tv.dart';
import 'package:movie_search/model/api/models/video.dart';
import 'package:movie_search/modules/audiovisual/service/service.dart';
import 'package:movie_search/modules/video/service.dart';
import 'package:stacked/stacked.dart';

class ItemEpisodeDetailViewModel extends FutureViewModel {
  final AudiovisualService _service;
  final VideoService _videoService;
  final TvShow tvShow;
  final Seasons season;
  Episode episode;
  final List<Video> videos = [];

  ItemEpisodeDetailViewModel({required this.season, required this.episode, required this.tvShow})
      : _service = AudiovisualService.getInstance(),
        _videoService = VideoService.getInstance();

  @override
  Future futureToRun() async {
    setBusy(true);
    try {
      await Future.wait([_loadEpisodeData(), _loadVideos()]);
      setInitialised(true);
      setBusy(false);
    } catch (e) {
      setError(e);
    }
  }

  Future _loadEpisodeData() async {
    if (season.seasonNumber != null && episode.episodeNumber != null) {
      this.episode = await _service.getEpisode(tvShow.id, season.seasonNumber!, episode.episodeNumber!);
    }
  }

  Future _loadVideos() async {
    if (season.seasonNumber != null && episode.episodeNumber != null) {
      this.videos.addAll(await _videoService.getEpisodeVideos(tvShow.id, season.seasonNumber!, episode.episodeNumber!));
    }
  }
}
