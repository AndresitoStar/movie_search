import 'package:movie_search/data/moor_database.dart';

import 'base.dart';

class Movie extends ModelBase {
  @override
  fromJsonP(Map<String, dynamic> data) {
    this.title = data['title'];
    this.titleOriginal = data['original_title'];
    this.id = '${data['id']}';
    this.yearOriginal = data['release_date'];
    this.voteAverage = data['vote_average'];
    this.sinopsis = data['overview'];
    this.image = data['poster_path'];
  }

  @override
  String get type => 'movie';

}
