import 'package:movie_search/data/moor_database.dart';

import 'base.dart';

class TvShow extends ModelBase {

  @override
  fromJsonP(Map<String, dynamic> data) {
    this.title = data['name'];
    this.titleOriginal = data['original_name'];
    this.id = '${data['id']}';
    this.yearOriginal = data['first_air_date'];
    this.voteAverage = data['vote_average'];
    this.sinopsis = data['overview'];
    this.image = data['poster_path'];
  }

  @override
  String get type => 'tv';

}
