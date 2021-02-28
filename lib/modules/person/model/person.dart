class PersonListResponse {
  final List<Person> result;
  final int totalResult;
  final int totalPageResult;

  PersonListResponse({this.result, this.totalResult, this.totalPageResult});
}

class Person {
  String birthday;
  String knownForDepartment;
  String deathday;
  int id;
  String name;
  int gender;
  String biography;
  double popularity;
  String placeOfBirth;
  String profilePath;
  bool adult;
  String imdbId;
  String character;

  String get genderFormated => gender?.toString();

  Person(
      {this.birthday,
      this.knownForDepartment,
      this.deathday,
      this.id,
      this.name,
      this.gender,
      this.biography,
      this.popularity,
      this.placeOfBirth,
      this.profilePath,
      this.character,
      this.adult,
      this.imdbId});

  Person.fromJson(Map<String, dynamic> json) {
    birthday = json['birthday'];
    knownForDepartment = json['known_for_department'];
    deathday = json['deathday'];
    id = json['id'];
    name = json['name'];
    character = json['character'];
    gender = json['gender'];
    biography = json['biography'];
    popularity = json['popularity'];
    placeOfBirth = json['place_of_birth'];
    profilePath = json['profile_path'];
    adult = json['adult'];
    imdbId = json['imdb_id'];
  }
}
