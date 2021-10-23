// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class GenreTableData extends DataClass implements Insertable<GenreTableData> {
  final String id;
  final String name;
  final String type;
  GenreTableData({@required this.id, @required this.name, @required this.type});
  factory GenreTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return GenreTableData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      type: stringType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    return map;
  }

  GenreTableCompanion toCompanion(bool nullToAbsent) {
    return GenreTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
    );
  }

  factory GenreTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return GenreTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
    };
  }

  GenreTableData copyWith({String id, String name, String type}) =>
      GenreTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
      );
  @override
  String toString() {
    return (StringBuffer('GenreTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(name.hashCode, type.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is GenreTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type);
}

class GenreTableCompanion extends UpdateCompanion<GenreTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  const GenreTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
  });
  GenreTableCompanion.insert({
    @required String id,
    @required String name,
    @required String type,
  })  : id = Value(id),
        name = Value(name),
        type = Value(type);
  static Insertable<GenreTableData> custom({
    Expression<String> id,
    Expression<String> name,
    Expression<String> type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
    });
  }

  GenreTableCompanion copyWith(
      {Value<String> id, Value<String> name, Value<String> type}) {
    return GenreTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GenreTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $GenreTableTable extends GenreTable
    with TableInfo<$GenreTableTable, GenreTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $GenreTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedTextColumn _type;
  @override
  GeneratedTextColumn get type => _type ??= _constructType();
  GeneratedTextColumn _constructType() {
    return GeneratedTextColumn(
      'type',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, type];
  @override
  $GenreTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'genre_table';
  @override
  final String actualTableName = 'genre_table';
  @override
  VerificationContext validateIntegrity(Insertable<GenreTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type'], _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  GenreTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return GenreTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $GenreTableTable createAlias(String alias) {
    return $GenreTableTable(_db, alias);
  }
}

class Person extends DataClass implements Insertable<Person> {
  final int id;
  final String birthday;
  final String knownForDepartment;
  final String deathday;
  final String name;
  final int gender;
  final String biography;
  final double popularity;
  final String placeOfBirth;
  final String profilePath;
  final String imdbId;
  final String character;
  final DateTime fecha_reg;
  final String externalId;
  final bool isFavourite;
  Person(
      {@required this.id,
      this.birthday,
      this.knownForDepartment,
      this.deathday,
      this.name,
      this.gender,
      this.biography,
      this.popularity,
      this.placeOfBirth,
      this.profilePath,
      this.imdbId,
      this.character,
      this.fecha_reg,
      this.externalId,
      @required this.isFavourite});
  factory Person.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Person(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      birthday: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}birthday']),
      knownForDepartment: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}known_for_department']),
      deathday: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}deathday']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      gender: intType.mapFromDatabaseResponse(data['${effectivePrefix}gender']),
      biography: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}biography']),
      popularity: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}popularity']),
      placeOfBirth: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}place_of_birth']),
      profilePath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}profile_path']),
      imdbId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}imdb_id']),
      character: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}character']),
      fecha_reg: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}fecha_reg']),
      externalId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}external_id']),
      isFavourite: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_favourite']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || birthday != null) {
      map['birthday'] = Variable<String>(birthday);
    }
    if (!nullToAbsent || knownForDepartment != null) {
      map['known_for_department'] = Variable<String>(knownForDepartment);
    }
    if (!nullToAbsent || deathday != null) {
      map['deathday'] = Variable<String>(deathday);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<int>(gender);
    }
    if (!nullToAbsent || biography != null) {
      map['biography'] = Variable<String>(biography);
    }
    if (!nullToAbsent || popularity != null) {
      map['popularity'] = Variable<double>(popularity);
    }
    if (!nullToAbsent || placeOfBirth != null) {
      map['place_of_birth'] = Variable<String>(placeOfBirth);
    }
    if (!nullToAbsent || profilePath != null) {
      map['profile_path'] = Variable<String>(profilePath);
    }
    if (!nullToAbsent || imdbId != null) {
      map['imdb_id'] = Variable<String>(imdbId);
    }
    if (!nullToAbsent || character != null) {
      map['character'] = Variable<String>(character);
    }
    if (!nullToAbsent || fecha_reg != null) {
      map['fecha_reg'] = Variable<DateTime>(fecha_reg);
    }
    if (!nullToAbsent || externalId != null) {
      map['external_id'] = Variable<String>(externalId);
    }
    if (!nullToAbsent || isFavourite != null) {
      map['is_favourite'] = Variable<bool>(isFavourite);
    }
    return map;
  }

  PersonTableCompanion toCompanion(bool nullToAbsent) {
    return PersonTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      birthday: birthday == null && nullToAbsent
          ? const Value.absent()
          : Value(birthday),
      knownForDepartment: knownForDepartment == null && nullToAbsent
          ? const Value.absent()
          : Value(knownForDepartment),
      deathday: deathday == null && nullToAbsent
          ? const Value.absent()
          : Value(deathday),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      biography: biography == null && nullToAbsent
          ? const Value.absent()
          : Value(biography),
      popularity: popularity == null && nullToAbsent
          ? const Value.absent()
          : Value(popularity),
      placeOfBirth: placeOfBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(placeOfBirth),
      profilePath: profilePath == null && nullToAbsent
          ? const Value.absent()
          : Value(profilePath),
      imdbId:
          imdbId == null && nullToAbsent ? const Value.absent() : Value(imdbId),
      character: character == null && nullToAbsent
          ? const Value.absent()
          : Value(character),
      fecha_reg: fecha_reg == null && nullToAbsent
          ? const Value.absent()
          : Value(fecha_reg),
      externalId: externalId == null && nullToAbsent
          ? const Value.absent()
          : Value(externalId),
      isFavourite: isFavourite == null && nullToAbsent
          ? const Value.absent()
          : Value(isFavourite),
    );
  }

  factory Person.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Person(
      id: serializer.fromJson<int>(json['id']),
      birthday: serializer.fromJson<String>(json['birthday']),
      knownForDepartment:
          serializer.fromJson<String>(json['knownForDepartment']),
      deathday: serializer.fromJson<String>(json['deathday']),
      name: serializer.fromJson<String>(json['name']),
      gender: serializer.fromJson<int>(json['gender']),
      biography: serializer.fromJson<String>(json['biography']),
      popularity: serializer.fromJson<double>(json['popularity']),
      placeOfBirth: serializer.fromJson<String>(json['placeOfBirth']),
      profilePath: serializer.fromJson<String>(json['profilePath']),
      imdbId: serializer.fromJson<String>(json['imdbId']),
      character: serializer.fromJson<String>(json['character']),
      fecha_reg: serializer.fromJson<DateTime>(json['fecha_reg']),
      externalId: serializer.fromJson<String>(json['externalId']),
      isFavourite: serializer.fromJson<bool>(json['isFavourite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'birthday': serializer.toJson<String>(birthday),
      'knownForDepartment': serializer.toJson<String>(knownForDepartment),
      'deathday': serializer.toJson<String>(deathday),
      'name': serializer.toJson<String>(name),
      'gender': serializer.toJson<int>(gender),
      'biography': serializer.toJson<String>(biography),
      'popularity': serializer.toJson<double>(popularity),
      'placeOfBirth': serializer.toJson<String>(placeOfBirth),
      'profilePath': serializer.toJson<String>(profilePath),
      'imdbId': serializer.toJson<String>(imdbId),
      'character': serializer.toJson<String>(character),
      'fecha_reg': serializer.toJson<DateTime>(fecha_reg),
      'externalId': serializer.toJson<String>(externalId),
      'isFavourite': serializer.toJson<bool>(isFavourite),
    };
  }

  Person copyWith(
          {int id,
          String birthday,
          String knownForDepartment,
          String deathday,
          String name,
          int gender,
          String biography,
          double popularity,
          String placeOfBirth,
          String profilePath,
          String imdbId,
          String character,
          DateTime fecha_reg,
          String externalId,
          bool isFavourite}) =>
      Person(
        id: id ?? this.id,
        birthday: birthday ?? this.birthday,
        knownForDepartment: knownForDepartment ?? this.knownForDepartment,
        deathday: deathday ?? this.deathday,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        biography: biography ?? this.biography,
        popularity: popularity ?? this.popularity,
        placeOfBirth: placeOfBirth ?? this.placeOfBirth,
        profilePath: profilePath ?? this.profilePath,
        imdbId: imdbId ?? this.imdbId,
        character: character ?? this.character,
        fecha_reg: fecha_reg ?? this.fecha_reg,
        externalId: externalId ?? this.externalId,
        isFavourite: isFavourite ?? this.isFavourite,
      );
  @override
  String toString() {
    return (StringBuffer('Person(')
          ..write('id: $id, ')
          ..write('birthday: $birthday, ')
          ..write('knownForDepartment: $knownForDepartment, ')
          ..write('deathday: $deathday, ')
          ..write('name: $name, ')
          ..write('gender: $gender, ')
          ..write('biography: $biography, ')
          ..write('popularity: $popularity, ')
          ..write('placeOfBirth: $placeOfBirth, ')
          ..write('profilePath: $profilePath, ')
          ..write('imdbId: $imdbId, ')
          ..write('character: $character, ')
          ..write('fecha_reg: $fecha_reg, ')
          ..write('externalId: $externalId, ')
          ..write('isFavourite: $isFavourite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          birthday.hashCode,
          $mrjc(
              knownForDepartment.hashCode,
              $mrjc(
                  deathday.hashCode,
                  $mrjc(
                      name.hashCode,
                      $mrjc(
                          gender.hashCode,
                          $mrjc(
                              biography.hashCode,
                              $mrjc(
                                  popularity.hashCode,
                                  $mrjc(
                                      placeOfBirth.hashCode,
                                      $mrjc(
                                          profilePath.hashCode,
                                          $mrjc(
                                              imdbId.hashCode,
                                              $mrjc(
                                                  character.hashCode,
                                                  $mrjc(
                                                      fecha_reg.hashCode,
                                                      $mrjc(
                                                          externalId.hashCode,
                                                          isFavourite
                                                              .hashCode)))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Person &&
          other.id == this.id &&
          other.birthday == this.birthday &&
          other.knownForDepartment == this.knownForDepartment &&
          other.deathday == this.deathday &&
          other.name == this.name &&
          other.gender == this.gender &&
          other.biography == this.biography &&
          other.popularity == this.popularity &&
          other.placeOfBirth == this.placeOfBirth &&
          other.profilePath == this.profilePath &&
          other.imdbId == this.imdbId &&
          other.character == this.character &&
          other.fecha_reg == this.fecha_reg &&
          other.externalId == this.externalId &&
          other.isFavourite == this.isFavourite);
}

class PersonTableCompanion extends UpdateCompanion<Person> {
  final Value<int> id;
  final Value<String> birthday;
  final Value<String> knownForDepartment;
  final Value<String> deathday;
  final Value<String> name;
  final Value<int> gender;
  final Value<String> biography;
  final Value<double> popularity;
  final Value<String> placeOfBirth;
  final Value<String> profilePath;
  final Value<String> imdbId;
  final Value<String> character;
  final Value<DateTime> fecha_reg;
  final Value<String> externalId;
  final Value<bool> isFavourite;
  const PersonTableCompanion({
    this.id = const Value.absent(),
    this.birthday = const Value.absent(),
    this.knownForDepartment = const Value.absent(),
    this.deathday = const Value.absent(),
    this.name = const Value.absent(),
    this.gender = const Value.absent(),
    this.biography = const Value.absent(),
    this.popularity = const Value.absent(),
    this.placeOfBirth = const Value.absent(),
    this.profilePath = const Value.absent(),
    this.imdbId = const Value.absent(),
    this.character = const Value.absent(),
    this.fecha_reg = const Value.absent(),
    this.externalId = const Value.absent(),
    this.isFavourite = const Value.absent(),
  });
  PersonTableCompanion.insert({
    this.id = const Value.absent(),
    this.birthday = const Value.absent(),
    this.knownForDepartment = const Value.absent(),
    this.deathday = const Value.absent(),
    this.name = const Value.absent(),
    this.gender = const Value.absent(),
    this.biography = const Value.absent(),
    this.popularity = const Value.absent(),
    this.placeOfBirth = const Value.absent(),
    this.profilePath = const Value.absent(),
    this.imdbId = const Value.absent(),
    this.character = const Value.absent(),
    this.fecha_reg = const Value.absent(),
    this.externalId = const Value.absent(),
    this.isFavourite = const Value.absent(),
  });
  static Insertable<Person> custom({
    Expression<int> id,
    Expression<String> birthday,
    Expression<String> knownForDepartment,
    Expression<String> deathday,
    Expression<String> name,
    Expression<int> gender,
    Expression<String> biography,
    Expression<double> popularity,
    Expression<String> placeOfBirth,
    Expression<String> profilePath,
    Expression<String> imdbId,
    Expression<String> character,
    Expression<DateTime> fecha_reg,
    Expression<String> externalId,
    Expression<bool> isFavourite,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (birthday != null) 'birthday': birthday,
      if (knownForDepartment != null)
        'known_for_department': knownForDepartment,
      if (deathday != null) 'deathday': deathday,
      if (name != null) 'name': name,
      if (gender != null) 'gender': gender,
      if (biography != null) 'biography': biography,
      if (popularity != null) 'popularity': popularity,
      if (placeOfBirth != null) 'place_of_birth': placeOfBirth,
      if (profilePath != null) 'profile_path': profilePath,
      if (imdbId != null) 'imdb_id': imdbId,
      if (character != null) 'character': character,
      if (fecha_reg != null) 'fecha_reg': fecha_reg,
      if (externalId != null) 'external_id': externalId,
      if (isFavourite != null) 'is_favourite': isFavourite,
    });
  }

  PersonTableCompanion copyWith(
      {Value<int> id,
      Value<String> birthday,
      Value<String> knownForDepartment,
      Value<String> deathday,
      Value<String> name,
      Value<int> gender,
      Value<String> biography,
      Value<double> popularity,
      Value<String> placeOfBirth,
      Value<String> profilePath,
      Value<String> imdbId,
      Value<String> character,
      Value<DateTime> fecha_reg,
      Value<String> externalId,
      Value<bool> isFavourite}) {
    return PersonTableCompanion(
      id: id ?? this.id,
      birthday: birthday ?? this.birthday,
      knownForDepartment: knownForDepartment ?? this.knownForDepartment,
      deathday: deathday ?? this.deathday,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      biography: biography ?? this.biography,
      popularity: popularity ?? this.popularity,
      placeOfBirth: placeOfBirth ?? this.placeOfBirth,
      profilePath: profilePath ?? this.profilePath,
      imdbId: imdbId ?? this.imdbId,
      character: character ?? this.character,
      fecha_reg: fecha_reg ?? this.fecha_reg,
      externalId: externalId ?? this.externalId,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (birthday.present) {
      map['birthday'] = Variable<String>(birthday.value);
    }
    if (knownForDepartment.present) {
      map['known_for_department'] = Variable<String>(knownForDepartment.value);
    }
    if (deathday.present) {
      map['deathday'] = Variable<String>(deathday.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (gender.present) {
      map['gender'] = Variable<int>(gender.value);
    }
    if (biography.present) {
      map['biography'] = Variable<String>(biography.value);
    }
    if (popularity.present) {
      map['popularity'] = Variable<double>(popularity.value);
    }
    if (placeOfBirth.present) {
      map['place_of_birth'] = Variable<String>(placeOfBirth.value);
    }
    if (profilePath.present) {
      map['profile_path'] = Variable<String>(profilePath.value);
    }
    if (imdbId.present) {
      map['imdb_id'] = Variable<String>(imdbId.value);
    }
    if (character.present) {
      map['character'] = Variable<String>(character.value);
    }
    if (fecha_reg.present) {
      map['fecha_reg'] = Variable<DateTime>(fecha_reg.value);
    }
    if (externalId.present) {
      map['external_id'] = Variable<String>(externalId.value);
    }
    if (isFavourite.present) {
      map['is_favourite'] = Variable<bool>(isFavourite.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonTableCompanion(')
          ..write('id: $id, ')
          ..write('birthday: $birthday, ')
          ..write('knownForDepartment: $knownForDepartment, ')
          ..write('deathday: $deathday, ')
          ..write('name: $name, ')
          ..write('gender: $gender, ')
          ..write('biography: $biography, ')
          ..write('popularity: $popularity, ')
          ..write('placeOfBirth: $placeOfBirth, ')
          ..write('profilePath: $profilePath, ')
          ..write('imdbId: $imdbId, ')
          ..write('character: $character, ')
          ..write('fecha_reg: $fecha_reg, ')
          ..write('externalId: $externalId, ')
          ..write('isFavourite: $isFavourite')
          ..write(')'))
        .toString();
  }
}

class $PersonTableTable extends PersonTable
    with TableInfo<$PersonTableTable, Person> {
  final GeneratedDatabase _db;
  final String _alias;
  $PersonTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _birthdayMeta = const VerificationMeta('birthday');
  GeneratedTextColumn _birthday;
  @override
  GeneratedTextColumn get birthday => _birthday ??= _constructBirthday();
  GeneratedTextColumn _constructBirthday() {
    return GeneratedTextColumn(
      'birthday',
      $tableName,
      true,
    );
  }

  final VerificationMeta _knownForDepartmentMeta =
      const VerificationMeta('knownForDepartment');
  GeneratedTextColumn _knownForDepartment;
  @override
  GeneratedTextColumn get knownForDepartment =>
      _knownForDepartment ??= _constructKnownForDepartment();
  GeneratedTextColumn _constructKnownForDepartment() {
    return GeneratedTextColumn(
      'known_for_department',
      $tableName,
      true,
    );
  }

  final VerificationMeta _deathdayMeta = const VerificationMeta('deathday');
  GeneratedTextColumn _deathday;
  @override
  GeneratedTextColumn get deathday => _deathday ??= _constructDeathday();
  GeneratedTextColumn _constructDeathday() {
    return GeneratedTextColumn(
      'deathday',
      $tableName,
      true,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _genderMeta = const VerificationMeta('gender');
  GeneratedIntColumn _gender;
  @override
  GeneratedIntColumn get gender => _gender ??= _constructGender();
  GeneratedIntColumn _constructGender() {
    return GeneratedIntColumn(
      'gender',
      $tableName,
      true,
    );
  }

  final VerificationMeta _biographyMeta = const VerificationMeta('biography');
  GeneratedTextColumn _biography;
  @override
  GeneratedTextColumn get biography => _biography ??= _constructBiography();
  GeneratedTextColumn _constructBiography() {
    return GeneratedTextColumn(
      'biography',
      $tableName,
      true,
    );
  }

  final VerificationMeta _popularityMeta = const VerificationMeta('popularity');
  GeneratedRealColumn _popularity;
  @override
  GeneratedRealColumn get popularity => _popularity ??= _constructPopularity();
  GeneratedRealColumn _constructPopularity() {
    return GeneratedRealColumn(
      'popularity',
      $tableName,
      true,
    );
  }

  final VerificationMeta _placeOfBirthMeta =
      const VerificationMeta('placeOfBirth');
  GeneratedTextColumn _placeOfBirth;
  @override
  GeneratedTextColumn get placeOfBirth =>
      _placeOfBirth ??= _constructPlaceOfBirth();
  GeneratedTextColumn _constructPlaceOfBirth() {
    return GeneratedTextColumn(
      'place_of_birth',
      $tableName,
      true,
    );
  }

  final VerificationMeta _profilePathMeta =
      const VerificationMeta('profilePath');
  GeneratedTextColumn _profilePath;
  @override
  GeneratedTextColumn get profilePath =>
      _profilePath ??= _constructProfilePath();
  GeneratedTextColumn _constructProfilePath() {
    return GeneratedTextColumn(
      'profile_path',
      $tableName,
      true,
    );
  }

  final VerificationMeta _imdbIdMeta = const VerificationMeta('imdbId');
  GeneratedTextColumn _imdbId;
  @override
  GeneratedTextColumn get imdbId => _imdbId ??= _constructImdbId();
  GeneratedTextColumn _constructImdbId() {
    return GeneratedTextColumn(
      'imdb_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _characterMeta = const VerificationMeta('character');
  GeneratedTextColumn _character;
  @override
  GeneratedTextColumn get character => _character ??= _constructCharacter();
  GeneratedTextColumn _constructCharacter() {
    return GeneratedTextColumn(
      'character',
      $tableName,
      true,
    );
  }

  final VerificationMeta _fecha_regMeta = const VerificationMeta('fecha_reg');
  GeneratedDateTimeColumn _fecha_reg;
  @override
  GeneratedDateTimeColumn get fecha_reg => _fecha_reg ??= _constructFechaReg();
  GeneratedDateTimeColumn _constructFechaReg() {
    return GeneratedDateTimeColumn(
      'fecha_reg',
      $tableName,
      true,
    );
  }

  final VerificationMeta _externalIdMeta = const VerificationMeta('externalId');
  GeneratedTextColumn _externalId;
  @override
  GeneratedTextColumn get externalId => _externalId ??= _constructExternalId();
  GeneratedTextColumn _constructExternalId() {
    return GeneratedTextColumn(
      'external_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _isFavouriteMeta =
      const VerificationMeta('isFavourite');
  GeneratedBoolColumn _isFavourite;
  @override
  GeneratedBoolColumn get isFavourite =>
      _isFavourite ??= _constructIsFavourite();
  GeneratedBoolColumn _constructIsFavourite() {
    return GeneratedBoolColumn(
      'is_favourite',
      $tableName,
      false,
    )..clientDefault = () => false;
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        birthday,
        knownForDepartment,
        deathday,
        name,
        gender,
        biography,
        popularity,
        placeOfBirth,
        profilePath,
        imdbId,
        character,
        fecha_reg,
        externalId,
        isFavourite
      ];
  @override
  $PersonTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'person_table';
  @override
  final String actualTableName = 'person_table';
  @override
  VerificationContext validateIntegrity(Insertable<Person> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('birthday')) {
      context.handle(_birthdayMeta,
          birthday.isAcceptableOrUnknown(data['birthday'], _birthdayMeta));
    }
    if (data.containsKey('known_for_department')) {
      context.handle(
          _knownForDepartmentMeta,
          knownForDepartment.isAcceptableOrUnknown(
              data['known_for_department'], _knownForDepartmentMeta));
    }
    if (data.containsKey('deathday')) {
      context.handle(_deathdayMeta,
          deathday.isAcceptableOrUnknown(data['deathday'], _deathdayMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender'], _genderMeta));
    }
    if (data.containsKey('biography')) {
      context.handle(_biographyMeta,
          biography.isAcceptableOrUnknown(data['biography'], _biographyMeta));
    }
    if (data.containsKey('popularity')) {
      context.handle(
          _popularityMeta,
          popularity.isAcceptableOrUnknown(
              data['popularity'], _popularityMeta));
    }
    if (data.containsKey('place_of_birth')) {
      context.handle(
          _placeOfBirthMeta,
          placeOfBirth.isAcceptableOrUnknown(
              data['place_of_birth'], _placeOfBirthMeta));
    }
    if (data.containsKey('profile_path')) {
      context.handle(
          _profilePathMeta,
          profilePath.isAcceptableOrUnknown(
              data['profile_path'], _profilePathMeta));
    }
    if (data.containsKey('imdb_id')) {
      context.handle(_imdbIdMeta,
          imdbId.isAcceptableOrUnknown(data['imdb_id'], _imdbIdMeta));
    }
    if (data.containsKey('character')) {
      context.handle(_characterMeta,
          character.isAcceptableOrUnknown(data['character'], _characterMeta));
    }
    if (data.containsKey('fecha_reg')) {
      context.handle(_fecha_regMeta,
          fecha_reg.isAcceptableOrUnknown(data['fecha_reg'], _fecha_regMeta));
    }
    if (data.containsKey('external_id')) {
      context.handle(
          _externalIdMeta,
          externalId.isAcceptableOrUnknown(
              data['external_id'], _externalIdMeta));
    }
    if (data.containsKey('is_favourite')) {
      context.handle(
          _isFavouriteMeta,
          isFavourite.isAcceptableOrUnknown(
              data['is_favourite'], _isFavouriteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Person map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Person.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PersonTableTable createAlias(String alias) {
    return $PersonTableTable(_db, alias);
  }
}

class Favourite extends DataClass implements Insertable<Favourite> {
  final int id;
  final String type;
  final String json;
  Favourite({@required this.id, @required this.type, @required this.json});
  factory Favourite.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Favourite(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      type: stringType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
      json: stringType.mapFromDatabaseResponse(data['${effectivePrefix}json']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || json != null) {
      map['json'] = Variable<String>(json);
    }
    return map;
  }

  FavouriteTableCompanion toCompanion(bool nullToAbsent) {
    return FavouriteTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      json: json == null && nullToAbsent ? const Value.absent() : Value(json),
    );
  }

  factory Favourite.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Favourite(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      json: serializer.fromJson<String>(json['json']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
      'json': serializer.toJson<String>(json),
    };
  }

  Favourite copyWith({int id, String type, String json}) => Favourite(
        id: id ?? this.id,
        type: type ?? this.type,
        json: json ?? this.json,
      );
  @override
  String toString() {
    return (StringBuffer('Favourite(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('json: $json')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(type.hashCode, json.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Favourite &&
          other.id == this.id &&
          other.type == this.type &&
          other.json == this.json);
}

class FavouriteTableCompanion extends UpdateCompanion<Favourite> {
  final Value<int> id;
  final Value<String> type;
  final Value<String> json;
  const FavouriteTableCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.json = const Value.absent(),
  });
  FavouriteTableCompanion.insert({
    @required int id,
    @required String type,
    @required String json,
  })  : id = Value(id),
        type = Value(type),
        json = Value(json);
  static Insertable<Favourite> custom({
    Expression<int> id,
    Expression<String> type,
    Expression<String> json,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (json != null) 'json': json,
    });
  }

  FavouriteTableCompanion copyWith(
      {Value<int> id, Value<String> type, Value<String> json}) {
    return FavouriteTableCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      json: json ?? this.json,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (json.present) {
      map['json'] = Variable<String>(json.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavouriteTableCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('json: $json')
          ..write(')'))
        .toString();
  }
}

class $FavouriteTableTable extends FavouriteTable
    with TableInfo<$FavouriteTableTable, Favourite> {
  final GeneratedDatabase _db;
  final String _alias;
  $FavouriteTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedTextColumn _type;
  @override
  GeneratedTextColumn get type => _type ??= _constructType();
  GeneratedTextColumn _constructType() {
    return GeneratedTextColumn(
      'type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _jsonMeta = const VerificationMeta('json');
  GeneratedTextColumn _json;
  @override
  GeneratedTextColumn get json => _json ??= _constructJson();
  GeneratedTextColumn _constructJson() {
    return GeneratedTextColumn(
      'json',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, type, json];
  @override
  $FavouriteTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'favourite_table';
  @override
  final String actualTableName = 'favourite_table';
  @override
  VerificationContext validateIntegrity(Insertable<Favourite> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type'], _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('json')) {
      context.handle(
          _jsonMeta, json.isAcceptableOrUnknown(data['json'], _jsonMeta));
    } else if (isInserting) {
      context.missing(_jsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Favourite map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Favourite.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $FavouriteTableTable createAlias(String alias) {
    return $FavouriteTableTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $GenreTableTable _genreTable;
  $GenreTableTable get genreTable => _genreTable ??= $GenreTableTable(this);
  $PersonTableTable _personTable;
  $PersonTableTable get personTable => _personTable ??= $PersonTableTable(this);
  $FavouriteTableTable _favouriteTable;
  $FavouriteTableTable get favouriteTable =>
      _favouriteTable ??= $FavouriteTableTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [genreTable, personTable, favouriteTable];
}
