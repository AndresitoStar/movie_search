import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/model/image.dart';
import 'package:movie_search/modules/person/service/service.dart';
import 'package:movie_search/providers/util.dart';
import 'package:stacked/stacked.dart';

class PersonDetailViewModel extends FutureViewModel<Person> {
  final Person param;
  final PersonService _service;
  final MyDatabase _db;

  List<MediaImage> _images = [];

  List<MediaImage> get images => [..._images];

  bool get withImageList => _images.isNotEmpty;

  PersonDetailViewModel(this.param, this._db)
      : scrollController = ScrollController(),
        _service = PersonService.getInstance();

  bool _highQualityImage = false;
  String baseImageUrl = URL_IMAGE_MEDIUM;
  final ScrollController scrollController;

  bool get isHighQualityImage => _highQualityImage;

  bool get withImage => param.profilePath != null;

  String get image => param.profilePath;

  bool get isFavourite => data != null ? data.isFavourite : false;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Future<Person> futureToRun() async {
    final results = await Future.wait([
      _checkImageCachedQuality(),
      _cacheData(),
      _fetchImages(),
    ]);
    baseImageUrl = results[0];
    setInitialised(true);
    return results[1];
  }

  String age() {
    if (dataReady && data.birthday != null) {
      DateTime birth = DateTime.parse(data.birthday);
      DateTime death = data.deathday != null ? DateTime.parse(data.deathday) : DateTime.now();

      final age = death.difference(birth).inDays / 365.25;
      return age.floor().toStringAsFixed(0);
    }
    return null;
  }

  Future<Person> _cacheData() async {
    final _dbAv = await _db.getPersonById(param.id);
    if (_dbAv != null) {
      return _dbAv;
    }
    final av = await _service.getById(param.id);
    await _db.insertPerson(av);
    return av;
  }

  Future<String> _checkImageCachedQuality() async {
    if (await _checkImageCachedExist('$URL_IMAGE_BIG${param.profilePath}')) {
      _highQualityImage = true;
      return URL_IMAGE_BIG;
    }
    return URL_IMAGE_MEDIUM;
  }

  Future<bool> _checkImageCachedExist(String url) async {
    try {
      var file = await DefaultCacheManager().getFileFromCache(url);
      return file?.file?.exists() ?? false;
    } catch (e) {
      return false;
    }
  }

  Future _fetchImages() async {
    try {
      final images =
          await _service.getImages(TMDB_API_TYPE.PERSON.type, param.id);
      if (images != null) _images = images;
    } catch (e) {}
  }

  Future toggleHighQualityImage() async {
    _highQualityImage = true;
    baseImageUrl = URL_IMAGE_BIG;
    notifyListeners();
  }
}
