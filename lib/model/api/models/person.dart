class Person {
  num id;
  bool? adult;
  List<String>? alsoKnownAs;
  String? biography;
  String? birthday;
  String? deathday;
  num? gender;
  String? homepage;
  String? imdbId;
  String? character;
  String? knownForDepartment;
  String? name;
  String? placeOfBirth;
  num? popularity;
  String? profilePath;

  Person({
    required this.id,
    this.adult,
    this.alsoKnownAs,
    this.biography,
    this.birthday,
    this.deathday,
    this.gender,
    this.homepage,
    this.imdbId,
    this.knownForDepartment,
    this.character,
    this.name,
    this.placeOfBirth,
    this.popularity,
    this.profilePath,
  });

  Person.fromJson(Map<String, dynamic> json)
      : adult = json['adult'],
        alsoKnownAs = json['also_known_as'] != null ? (json['also_known_as'] as List).cast<String>() : null,
        biography = json['biography'],
        birthday = json['birthday'],
        deathday = json['deathday'],
        gender = json['gender'],
        homepage = json['homepage'],
        character = json['character'],
        id = json['id'],
        imdbId = json['imdb_id'],
        knownForDepartment = json['known_for_department'],
        name = json['name'],
        placeOfBirth = json['place_of_birth'],
        popularity = json['popularity'],
        profilePath = json['profile_path'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = this.adult;
    data['also_known_as'] = this.alsoKnownAs;
    data['biography'] = this.biography;
    data['birthday'] = this.birthday;
    data['deathday'] = this.deathday;
    data['gender'] = this.gender;
    data['character'] = this.character;
    data['homepage'] = this.homepage;
    data['id'] = this.id;
    data['imdb_id'] = this.imdbId;
    data['known_for_department'] = this.knownForDepartment;
    data['name'] = this.name;
    data['place_of_birth'] = this.placeOfBirth;
    data['popularity'] = this.popularity;
    data['profile_path'] = this.profilePath;
    return data;
  }
}
