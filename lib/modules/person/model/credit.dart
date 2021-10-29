import 'package:movie_search/model/api/models/person.dart';

class Credit {
  int id;
  List<Person> cast;

  Credit({this.id, this.cast});

  Credit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['cast'] != null) {
      cast = <Person>[];
      json['cast'].forEach((v) {
        cast.add(Person.fromJson(v));
      });
    }
  }
}
