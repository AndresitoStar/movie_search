import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/repository/repository_movie.dart';

class AudiovisualProvider with ChangeNotifier {
  final String id;
  final String title;
  final String image;
  final String type;
  final double voteAverage;
  final String year;
  String imageUrl;
  bool isFavourite;
  bool isTrending = false;
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

  AudiovisualProvider._(this._data,
      {@required this.id,
      @required this.title,
      this.year,
      this.type,
      this.voteAverage,
      @required this.image,
      @required this.imageUrl,
      this.isFavourite});

  AudiovisualProvider(
      {@required this.id,
      @required this.title,
      this.year,
      this.type,
      this.isTrending = false,
      this.voteAverage,
      @required this.image,
      @required this.imageUrl,
      this.isFavourite});

  AudiovisualProvider.fromData(AudiovisualTableData data)
      : this._(data,
            title: data.titulo,
            id: data.id,
            year: data.anno,
            voteAverage: double.tryParse(data.score),
//            type: data.type,
            image: data.image,
            imageUrl: data.image,
            isFavourite: data.isFavourite);

  Future<bool> toggleFavourite({@required BuildContext context}) async {
    _loadingStreamController.add(true);
    isFavourite = !isFavourite;
    if (isTrending)
      await findMyDataTrending(context);
    else
      await findMyData(context);
    if (_data != null) {
      final _repository = MovieRepository.getInstance(context);
      await _repository.db.toggleFavouriteAudiovisual(_data);
    }
    if (isTrending)
      await findMyDataTrending(context);
    else
      await findMyData(context);
    notifyListeners();
    _loadingStreamController.add(false);
    return !isFavourite;
  }

  toggleDateReg(BuildContext context) {
    if (_data != null) {
      final _repository = MovieRepository.getInstance(context);
      _repository.db.toggleDateReg(_data);
    }
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
    final _repository = MovieRepository.getInstance(context);
    var result = await _repository.getById(id);
//    isFavourite = result?.isFavourite;
    _data = result;
    notifyListeners();
  }

  Future findMyDataTrending(BuildContext context) async {
    imageLoaded = true;
    final _repository = MovieRepository.getInstance(context);
    var result = await _repository.getByTrendingId(id, type, defaultImage: imageUrl);
//    isFavourite = result?.isFavourite;
    _data = result;
    imageUrl = result?.image;
    notifyListeners();
  }
}
