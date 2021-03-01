import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/providers/util.dart';

class Credit {
  int id;
  List<Person> cast;

  Credit({this.id, this.cast});

  Credit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['cast'] != null) {
      cast = List<Person>();
      json['cast'].forEach((v) {
        cast.add(ResponseApiParser.personFromJsonApi(v));
      });
    }
  }

}