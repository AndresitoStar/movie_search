import 'dart:async';

import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/providers/audiovisuales_provider.dart';
import 'package:movie_search/repository/repository_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';

class AudiovisualProvider with ChangeNotifier {
  final String id;
  final String title;
  final String image;
  final String type;
  final double voteAverage;
  final String year;
  String imageUrl;
  bool isFavourite;
  bool imageLoaded = false;
  AudiovisualTableData _data;

  AudiovisualTableData get data => _data;
  final _loadingStreamController = StreamController<bool>.broadcast();

  get loadingStreamController => _loadingStreamController.stream;

  @override
  void dispose() {
    _loadingStreamController.close();
    super.dispose();
  }

  AudiovisualProvider(
      {@required this.id,
      @required this.title,
      this.year,
      this.type,
      this.voteAverage,
      @required this.image,
      @required this.imageUrl,
      this.isFavourite});

  Future<bool> toggleFavourite({@required BuildContext context}) async {
    isFavourite = !isFavourite;
    if (_data != null) {
      final _repository = MovieRepository.getInstance(context);
      _repository.db.updateAudiovisual(_data.copyWith(isFavourite: isFavourite));
    }
    notifyListeners();
    return isFavourite;
  }

  Future toggleLoadImage() async {
    imageLoaded = !imageLoaded;
    notifyListeners();
  }

  Future checkImageCached() async {
    var file = await DefaultCacheManager().getFileFromCache(imageUrl);
    var exist = await file?.file?.exists();
    imageLoaded = exist ?? false;
    notifyListeners();
  }

  Future findMyData(BuildContext context) async {
    _loadingStreamController.add(true);
    final _repository = MovieRepository.getInstance(context);
    var result = await _repository.getById(id);
    isFavourite = result?.isFavourite;
    _data = result;
    _loadingStreamController.add(false);
    notifyListeners();
  }

  Future findMyDataTrending(BuildContext context) async {
    _loadingStreamController.add(true);
    imageLoaded = true;
    final _repository = MovieRepository.getInstance(context);
    var result = await _repository.getByTrendingId(id, type);
    isFavourite = result?.isFavourite;
    _data = result;
    imageUrl = result?.image;
    _loadingStreamController.add(false);
    notifyListeners();
  }
}
