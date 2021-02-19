import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/repository/repository_movie.dart';

class AudiovisualProvider with ChangeNotifier {
  final String id;
  final String title;
  final String titleOriginal;
  String image;
  final String type;
  final num voteAverage;
  String yearOriginal;

  String get imageUrl => image;
  String sinopsis;
  bool isFavourite;
  bool isTrending = false;
  bool imageLoaded = false;
  AudiovisualTableData _data;

  String get year =>
      yearOriginal != null ? DateTime
          .tryParse(yearOriginal)
          ?.year
          ?.toString() : null;

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
        @required this.titleOriginal,
        this.yearOriginal,
        this.type,
        this.voteAverage,
        @required this.image,
        this.isFavourite = false});

  AudiovisualProvider({@required this.id,
    @required this.title,
    @required this.titleOriginal,
    this.yearOriginal,
    this.type,
    this.sinopsis,
    this.isTrending = false,
    this.voteAverage,
    @required this.image,
    this.isFavourite = false});

  AudiovisualProvider.fromJsonTypeTv(Map<String, dynamic> data)
      : this(
    title: data['name'],
    titleOriginal: data['original_name'],
    id: '${data['id']}',
    yearOriginal: data['first_air_date'],
    voteAverage: data['vote_average'],
    type: 'tv',
    sinopsis: data['overview'],
    image: data['poster_path'],
  );

  AudiovisualProvider.fromJsonTypeMovie(Map<String, dynamic> data)
      : this(
    title: data['title'],
    titleOriginal: data['original_title'],
    id: '${data['id']}',
    yearOriginal: data['release_date'],
    voteAverage: data['vote_average'],
    type: 'movie',
    sinopsis: data['overview'],
    image: data['poster_path'],
  );

  AudiovisualProvider.fromData(AudiovisualTableData data)
      : this._(data,
      title: data.titulo,
      titleOriginal: data.titulo,
      id: data.id,
      yearOriginal: data.anno,
      voteAverage: data.score != null ? double.tryParse(data.score) : null,
//            type: data.type,
      image: data.image,
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

  Future<String> checkImageCachedQuality() async {
    if (await _checkImageCachedExist('$URL_IMAGE_BIG$imageUrl')) {
      return URL_IMAGE_BIG;
    } else if (await _checkImageCachedExist('$URL_IMAGE_MEDIUM$imageUrl')) {
      return URL_IMAGE_MEDIUM;
    } return URL_IMAGE_SMALL;
  }

  Future<bool> _checkImageCachedExist(String url) async {
    try {
      var file = await DefaultCacheManager().getFileFromCache(url);
      return file?.file?.exists() ?? false;
    } catch (e) {
      return false;
    }
  }

  Future findMyData(BuildContext context) async {
    final _repository = MovieRepository.getInstance(context);
    AudiovisualTableData result;
    try {
      result = await _repository.getById(id: id, type: type);
      _data = result;
    } catch (e) {
      print(e);
      _data = AudiovisualTableData();
    }
    notifyListeners();
  }

  Future findMyDataTrending(BuildContext context) async {
    return findMyData(context);
  }
}
