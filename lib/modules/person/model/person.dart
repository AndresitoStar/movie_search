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
  List<String> alsoKnownAs;
  int gender;
  String biography;
  double popularity;
  String placeOfBirth;
  String profilePath;
  bool adult;
  String imdbId;

  String get genderFormated => gender?.toString();

  Person(
      {this.birthday,
      this.knownForDepartment,
      this.deathday,
      this.id,
      this.name,
      this.alsoKnownAs,
      this.gender,
      this.biography,
      this.popularity,
      this.placeOfBirth,
      this.profilePath,
      this.adult,
      this.imdbId});

  Person.fromJson(Map<String, dynamic> json) {
    birthday = json['birthday'];
    knownForDepartment = json['known_for_department'];
    deathday = json['deathday'];
    id = json['id'];
    name = json['name'];
    alsoKnownAs = json['also_known_as'].cast<String>();
    gender = json['gender'];
    biography = json['biography'];
    popularity = json['popularity'];
    placeOfBirth = json['place_of_birth'];
    profilePath = json['profile_path'];
    adult = json['adult'];
    imdbId = json['imdb_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['birthday'] = this.birthday;
    data['known_for_department'] = this.knownForDepartment;
    data['deathday'] = this.deathday;
    data['id'] = this.id;
    data['name'] = this.name;
    data['also_known_as'] = this.alsoKnownAs;
    data['gender'] = this.gender;
    data['biography'] = this.biography;
    data['popularity'] = this.popularity;
    data['place_of_birth'] = this.placeOfBirth;
    data['profile_path'] = this.profilePath;
    data['adult'] = this.adult;
    data['imdb_id'] = this.imdbId;
    return data;
  }
}
