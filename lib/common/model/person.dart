import 'package:movie_search/common/domain/search_result.dart';
import 'package:movie_search/common/model/search_response.dart';

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
      alsoKnownAs = json['also_known_as'] != null
          ? (json['also_known_as'] as List).cast<String>()
          : null,
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['also_known_as'] = alsoKnownAs;
    data['biography'] = biography;
    data['birthday'] = birthday;
    data['deathday'] = deathday;
    data['gender'] = gender;
    data['character'] = character;
    data['homepage'] = homepage;
    data['id'] = id;
    data['imdb_id'] = imdbId;
    data['known_for_department'] = knownForDepartment;
    data['name'] = name;
    data['place_of_birth'] = placeOfBirth;
    data['popularity'] = popularity;
    data['profile_path'] = profilePath;
    return data;
  }
}

class Credit {
  int? id;
  List<Person>? cast;

  Credit({this.id, this.cast});

  Credit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['cast'] != null) {
      cast = <Person>[];
      json['cast'].forEach((v) {
        cast!.add(Person.fromJson(v));
      });
    }
  }

  // TODO solo coger los 10 primeros
  // TODO ademas, coger el director y productor

  List<BaseSearchResult> toBaseSearchResultList() {
    if (cast == null) return [];
    return cast!.map((e) => BaseSearchResult.fromPerson(e)).toList();
  }

  // to SearchResponse method
  SearchResponse toSearchResponse() {
    return SearchResponse(
      page: 1,
      result: cast!.map((e) => BaseSearchResult.fromPerson(e)).toList(),
      totalPageResult: 1,
      totalResult: cast?.length ?? 0,
    );
  }
}

class CombinedCredits {
  int? id;
  List<BaseSearchResult>? cast;
  List<BaseSearchResult>? crew;

  CombinedCredits({this.id, this.cast});

  CombinedCredits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['cast'] != null) {
      cast = <BaseSearchResult>[];
      crew = <BaseSearchResult>[];
      json['cast'].forEach((v) {
        if (v['media_type'] case final String mediaType?) {
          final baseResult = BaseSearchResult.fromJson(mediaType, v);
          cast!.add(baseResult);
        } else {
          print(
            'Warning: media_type is missing for cast item with id ${v['id']}',
          );
        }
      });
      json['crew'].forEach((v) {
        if (v['media_type'] case final String mediaType?) {
          final baseResult = BaseSearchResult.fromJson(mediaType, v);
          crew!.add(baseResult);
        } else {
          print(
            'Warning: media_type is missing for crew item with id ${v['id']}',
          );
        }
      });
    }
  }

  List<BaseSearchResult> toBaseSearchResultList() {
    return [...?cast, ...?crew];
  }

  // // to SearchResponse method
  // SearchResponse toSearchResponse() {
  //   return SearchResponse(
  //     page: 1,
  //     result: cast!.map((e) => BaseSearchResult.fromPerson(e)).toList(),
  //     totalPageResult: 1,
  //     totalResult: cast?.length ?? 0,
  //   );
  // }
}
