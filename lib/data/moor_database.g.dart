// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class LanguageTableData extends DataClass
    implements Insertable<LanguageTableData> {
  final String iso;
  final String name;
  LanguageTableData({@required this.iso, @required this.name});
  factory LanguageTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return LanguageTableData(
      iso: stringType.mapFromDatabaseResponse(data['${effectivePrefix}iso']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || iso != null) {
      map['iso'] = Variable<String>(iso);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    return map;
  }

  LanguageTableCompanion toCompanion(bool nullToAbsent) {
    return LanguageTableCompanion(
      iso: iso == null && nullToAbsent ? const Value.absent() : Value(iso),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  factory LanguageTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return LanguageTableData(
      iso: serializer.fromJson<String>(json['iso']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'iso': serializer.toJson<String>(iso),
      'name': serializer.toJson<String>(name),
    };
  }

  LanguageTableData copyWith({String iso, String name}) => LanguageTableData(
        iso: iso ?? this.iso,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('LanguageTableData(')
          ..write('iso: $iso, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(iso.hashCode, name.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is LanguageTableData &&
          other.iso == this.iso &&
          other.name == this.name);
}

class LanguageTableCompanion extends UpdateCompanion<LanguageTableData> {
  final Value<String> iso;
  final Value<String> name;
  const LanguageTableCompanion({
    this.iso = const Value.absent(),
    this.name = const Value.absent(),
  });
  LanguageTableCompanion.insert({
    @required String iso,
    @required String name,
  })  : iso = Value(iso),
        name = Value(name);
  static Insertable<LanguageTableData> custom({
    Expression<String> iso,
    Expression<String> name,
  }) {
    return RawValuesInsertable({
      if (iso != null) 'iso': iso,
      if (name != null) 'name': name,
    });
  }

  LanguageTableCompanion copyWith({Value<String> iso, Value<String> name}) {
    return LanguageTableCompanion(
      iso: iso ?? this.iso,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (iso.present) {
      map['iso'] = Variable<String>(iso.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LanguageTableCompanion(')
          ..write('iso: $iso, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $LanguageTableTable extends LanguageTable
    with TableInfo<$LanguageTableTable, LanguageTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $LanguageTableTable(this._db, [this._alias]);
  final VerificationMeta _isoMeta = const VerificationMeta('iso');
  GeneratedTextColumn _iso;
  @override
  GeneratedTextColumn get iso => _iso ??= _constructIso();
  GeneratedTextColumn _constructIso() {
    return GeneratedTextColumn(
      'iso',
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

  @override
  List<GeneratedColumn> get $columns => [iso, name];
  @override
  $LanguageTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'language_table';
  @override
  final String actualTableName = 'language_table';
  @override
  VerificationContext validateIntegrity(Insertable<LanguageTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('iso')) {
      context.handle(
          _isoMeta, iso.isAcceptableOrUnknown(data['iso'], _isoMeta));
    } else if (isInserting) {
      context.missing(_isoMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  LanguageTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return LanguageTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $LanguageTableTable createAlias(String alias) {
    return $LanguageTableTable(_db, alias);
  }
}

class CountryTableData extends DataClass
    implements Insertable<CountryTableData> {
  final String iso;
  final String name;
  CountryTableData({@required this.iso, @required this.name});
  factory CountryTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return CountryTableData(
      iso: stringType.mapFromDatabaseResponse(data['${effectivePrefix}iso']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || iso != null) {
      map['iso'] = Variable<String>(iso);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    return map;
  }

  CountryTableCompanion toCompanion(bool nullToAbsent) {
    return CountryTableCompanion(
      iso: iso == null && nullToAbsent ? const Value.absent() : Value(iso),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  factory CountryTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return CountryTableData(
      iso: serializer.fromJson<String>(json['iso']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'iso': serializer.toJson<String>(iso),
      'name': serializer.toJson<String>(name),
    };
  }

  CountryTableData copyWith({String iso, String name}) => CountryTableData(
        iso: iso ?? this.iso,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('CountryTableData(')
          ..write('iso: $iso, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(iso.hashCode, name.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is CountryTableData &&
          other.iso == this.iso &&
          other.name == this.name);
}

class CountryTableCompanion extends UpdateCompanion<CountryTableData> {
  final Value<String> iso;
  final Value<String> name;
  const CountryTableCompanion({
    this.iso = const Value.absent(),
    this.name = const Value.absent(),
  });
  CountryTableCompanion.insert({
    @required String iso,
    @required String name,
  })  : iso = Value(iso),
        name = Value(name);
  static Insertable<CountryTableData> custom({
    Expression<String> iso,
    Expression<String> name,
  }) {
    return RawValuesInsertable({
      if (iso != null) 'iso': iso,
      if (name != null) 'name': name,
    });
  }

  CountryTableCompanion copyWith({Value<String> iso, Value<String> name}) {
    return CountryTableCompanion(
      iso: iso ?? this.iso,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (iso.present) {
      map['iso'] = Variable<String>(iso.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CountryTableCompanion(')
          ..write('iso: $iso, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $CountryTableTable extends CountryTable
    with TableInfo<$CountryTableTable, CountryTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $CountryTableTable(this._db, [this._alias]);
  final VerificationMeta _isoMeta = const VerificationMeta('iso');
  GeneratedTextColumn _iso;
  @override
  GeneratedTextColumn get iso => _iso ??= _constructIso();
  GeneratedTextColumn _constructIso() {
    return GeneratedTextColumn(
      'iso',
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

  @override
  List<GeneratedColumn> get $columns => [iso, name];
  @override
  $CountryTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'country_table';
  @override
  final String actualTableName = 'country_table';
  @override
  VerificationContext validateIntegrity(Insertable<CountryTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('iso')) {
      context.handle(
          _isoMeta, iso.isAcceptableOrUnknown(data['iso'], _isoMeta));
    } else if (isInserting) {
      context.missing(_isoMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  CountryTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return CountryTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $CountryTableTable createAlias(String alias) {
    return $CountryTableTable(_db, alias);
  }
}

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

class TvShow extends DataClass implements Insertable<TvShow> {
  final int id;
  final String backdropPath;
  final String createdBy;
  final int episodeRunTime;
  final String firstAirDate;
  final String genres;
  final String languages;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final String productionCountries;
  final String productionCompanies;
  final String spokenLanguages;
  final String status;
  final String tagline;
  final String type;
  final DateTime fecha_reg;
  final String externalId;
  final bool isFavourite;
  TvShow(
      {@required this.id,
      this.backdropPath,
      this.createdBy,
      this.episodeRunTime,
      this.firstAirDate,
      this.genres,
      this.languages,
      this.name,
      this.numberOfEpisodes,
      this.numberOfSeasons,
      this.originCountry,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.popularity,
      this.posterPath,
      this.productionCountries,
      this.productionCompanies,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.type,
      this.fecha_reg,
      this.externalId,
      @required this.isFavourite});
  factory TvShow.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return TvShow(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      backdropPath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}backdrop_path']),
      createdBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_by']),
      episodeRunTime: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}episode_run_time']),
      firstAirDate: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}first_air_date']),
      genres:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}genres']),
      languages: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}languages']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      numberOfEpisodes: intType.mapFromDatabaseResponse(
          data['${effectivePrefix}number_of_episodes']),
      numberOfSeasons: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}number_of_seasons']),
      originCountry: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}origin_country']),
      originalLanguage: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}original_language']),
      originalName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}original_name']),
      overview: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}overview']),
      popularity: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}popularity']),
      posterPath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}poster_path']),
      productionCountries: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}production_countries']),
      productionCompanies: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}production_companies']),
      spokenLanguages: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}spoken_languages']),
      status:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}status']),
      tagline:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}tagline']),
      type: stringType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
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
    if (!nullToAbsent || backdropPath != null) {
      map['backdrop_path'] = Variable<String>(backdropPath);
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || episodeRunTime != null) {
      map['episode_run_time'] = Variable<int>(episodeRunTime);
    }
    if (!nullToAbsent || firstAirDate != null) {
      map['first_air_date'] = Variable<String>(firstAirDate);
    }
    if (!nullToAbsent || genres != null) {
      map['genres'] = Variable<String>(genres);
    }
    if (!nullToAbsent || languages != null) {
      map['languages'] = Variable<String>(languages);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || numberOfEpisodes != null) {
      map['number_of_episodes'] = Variable<int>(numberOfEpisodes);
    }
    if (!nullToAbsent || numberOfSeasons != null) {
      map['number_of_seasons'] = Variable<int>(numberOfSeasons);
    }
    if (!nullToAbsent || originCountry != null) {
      map['origin_country'] = Variable<String>(originCountry);
    }
    if (!nullToAbsent || originalLanguage != null) {
      map['original_language'] = Variable<String>(originalLanguage);
    }
    if (!nullToAbsent || originalName != null) {
      map['original_name'] = Variable<String>(originalName);
    }
    if (!nullToAbsent || overview != null) {
      map['overview'] = Variable<String>(overview);
    }
    if (!nullToAbsent || popularity != null) {
      map['popularity'] = Variable<double>(popularity);
    }
    if (!nullToAbsent || posterPath != null) {
      map['poster_path'] = Variable<String>(posterPath);
    }
    if (!nullToAbsent || productionCountries != null) {
      map['production_countries'] = Variable<String>(productionCountries);
    }
    if (!nullToAbsent || productionCompanies != null) {
      map['production_companies'] = Variable<String>(productionCompanies);
    }
    if (!nullToAbsent || spokenLanguages != null) {
      map['spoken_languages'] = Variable<String>(spokenLanguages);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    if (!nullToAbsent || tagline != null) {
      map['tagline'] = Variable<String>(tagline);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
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

  TvShowTableCompanion toCompanion(bool nullToAbsent) {
    return TvShowTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      backdropPath: backdropPath == null && nullToAbsent
          ? const Value.absent()
          : Value(backdropPath),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      episodeRunTime: episodeRunTime == null && nullToAbsent
          ? const Value.absent()
          : Value(episodeRunTime),
      firstAirDate: firstAirDate == null && nullToAbsent
          ? const Value.absent()
          : Value(firstAirDate),
      genres:
          genres == null && nullToAbsent ? const Value.absent() : Value(genres),
      languages: languages == null && nullToAbsent
          ? const Value.absent()
          : Value(languages),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      numberOfEpisodes: numberOfEpisodes == null && nullToAbsent
          ? const Value.absent()
          : Value(numberOfEpisodes),
      numberOfSeasons: numberOfSeasons == null && nullToAbsent
          ? const Value.absent()
          : Value(numberOfSeasons),
      originCountry: originCountry == null && nullToAbsent
          ? const Value.absent()
          : Value(originCountry),
      originalLanguage: originalLanguage == null && nullToAbsent
          ? const Value.absent()
          : Value(originalLanguage),
      originalName: originalName == null && nullToAbsent
          ? const Value.absent()
          : Value(originalName),
      overview: overview == null && nullToAbsent
          ? const Value.absent()
          : Value(overview),
      popularity: popularity == null && nullToAbsent
          ? const Value.absent()
          : Value(popularity),
      posterPath: posterPath == null && nullToAbsent
          ? const Value.absent()
          : Value(posterPath),
      productionCountries: productionCountries == null && nullToAbsent
          ? const Value.absent()
          : Value(productionCountries),
      productionCompanies: productionCompanies == null && nullToAbsent
          ? const Value.absent()
          : Value(productionCompanies),
      spokenLanguages: spokenLanguages == null && nullToAbsent
          ? const Value.absent()
          : Value(spokenLanguages),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      tagline: tagline == null && nullToAbsent
          ? const Value.absent()
          : Value(tagline),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
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

  factory TvShow.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TvShow(
      id: serializer.fromJson<int>(json['id']),
      backdropPath: serializer.fromJson<String>(json['backdropPath']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      episodeRunTime: serializer.fromJson<int>(json['episodeRunTime']),
      firstAirDate: serializer.fromJson<String>(json['firstAirDate']),
      genres: serializer.fromJson<String>(json['genres']),
      languages: serializer.fromJson<String>(json['languages']),
      name: serializer.fromJson<String>(json['name']),
      numberOfEpisodes: serializer.fromJson<int>(json['numberOfEpisodes']),
      numberOfSeasons: serializer.fromJson<int>(json['numberOfSeasons']),
      originCountry: serializer.fromJson<String>(json['originCountry']),
      originalLanguage: serializer.fromJson<String>(json['originalLanguage']),
      originalName: serializer.fromJson<String>(json['originalName']),
      overview: serializer.fromJson<String>(json['overview']),
      popularity: serializer.fromJson<double>(json['popularity']),
      posterPath: serializer.fromJson<String>(json['posterPath']),
      productionCountries:
          serializer.fromJson<String>(json['productionCountries']),
      productionCompanies:
          serializer.fromJson<String>(json['productionCompanies']),
      spokenLanguages: serializer.fromJson<String>(json['spokenLanguages']),
      status: serializer.fromJson<String>(json['status']),
      tagline: serializer.fromJson<String>(json['tagline']),
      type: serializer.fromJson<String>(json['type']),
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
      'backdropPath': serializer.toJson<String>(backdropPath),
      'createdBy': serializer.toJson<String>(createdBy),
      'episodeRunTime': serializer.toJson<int>(episodeRunTime),
      'firstAirDate': serializer.toJson<String>(firstAirDate),
      'genres': serializer.toJson<String>(genres),
      'languages': serializer.toJson<String>(languages),
      'name': serializer.toJson<String>(name),
      'numberOfEpisodes': serializer.toJson<int>(numberOfEpisodes),
      'numberOfSeasons': serializer.toJson<int>(numberOfSeasons),
      'originCountry': serializer.toJson<String>(originCountry),
      'originalLanguage': serializer.toJson<String>(originalLanguage),
      'originalName': serializer.toJson<String>(originalName),
      'overview': serializer.toJson<String>(overview),
      'popularity': serializer.toJson<double>(popularity),
      'posterPath': serializer.toJson<String>(posterPath),
      'productionCountries': serializer.toJson<String>(productionCountries),
      'productionCompanies': serializer.toJson<String>(productionCompanies),
      'spokenLanguages': serializer.toJson<String>(spokenLanguages),
      'status': serializer.toJson<String>(status),
      'tagline': serializer.toJson<String>(tagline),
      'type': serializer.toJson<String>(type),
      'fecha_reg': serializer.toJson<DateTime>(fecha_reg),
      'externalId': serializer.toJson<String>(externalId),
      'isFavourite': serializer.toJson<bool>(isFavourite),
    };
  }

  TvShow copyWith(
          {int id,
          String backdropPath,
          String createdBy,
          int episodeRunTime,
          String firstAirDate,
          String genres,
          String languages,
          String name,
          int numberOfEpisodes,
          int numberOfSeasons,
          String originCountry,
          String originalLanguage,
          String originalName,
          String overview,
          double popularity,
          String posterPath,
          String productionCountries,
          String productionCompanies,
          String spokenLanguages,
          String status,
          String tagline,
          String type,
          DateTime fecha_reg,
          String externalId,
          bool isFavourite}) =>
      TvShow(
        id: id ?? this.id,
        backdropPath: backdropPath ?? this.backdropPath,
        createdBy: createdBy ?? this.createdBy,
        episodeRunTime: episodeRunTime ?? this.episodeRunTime,
        firstAirDate: firstAirDate ?? this.firstAirDate,
        genres: genres ?? this.genres,
        languages: languages ?? this.languages,
        name: name ?? this.name,
        numberOfEpisodes: numberOfEpisodes ?? this.numberOfEpisodes,
        numberOfSeasons: numberOfSeasons ?? this.numberOfSeasons,
        originCountry: originCountry ?? this.originCountry,
        originalLanguage: originalLanguage ?? this.originalLanguage,
        originalName: originalName ?? this.originalName,
        overview: overview ?? this.overview,
        popularity: popularity ?? this.popularity,
        posterPath: posterPath ?? this.posterPath,
        productionCountries: productionCountries ?? this.productionCountries,
        productionCompanies: productionCompanies ?? this.productionCompanies,
        spokenLanguages: spokenLanguages ?? this.spokenLanguages,
        status: status ?? this.status,
        tagline: tagline ?? this.tagline,
        type: type ?? this.type,
        fecha_reg: fecha_reg ?? this.fecha_reg,
        externalId: externalId ?? this.externalId,
        isFavourite: isFavourite ?? this.isFavourite,
      );
  @override
  String toString() {
    return (StringBuffer('TvShow(')
          ..write('id: $id, ')
          ..write('backdropPath: $backdropPath, ')
          ..write('createdBy: $createdBy, ')
          ..write('episodeRunTime: $episodeRunTime, ')
          ..write('firstAirDate: $firstAirDate, ')
          ..write('genres: $genres, ')
          ..write('languages: $languages, ')
          ..write('name: $name, ')
          ..write('numberOfEpisodes: $numberOfEpisodes, ')
          ..write('numberOfSeasons: $numberOfSeasons, ')
          ..write('originCountry: $originCountry, ')
          ..write('originalLanguage: $originalLanguage, ')
          ..write('originalName: $originalName, ')
          ..write('overview: $overview, ')
          ..write('popularity: $popularity, ')
          ..write('posterPath: $posterPath, ')
          ..write('productionCountries: $productionCountries, ')
          ..write('productionCompanies: $productionCompanies, ')
          ..write('spokenLanguages: $spokenLanguages, ')
          ..write('status: $status, ')
          ..write('tagline: $tagline, ')
          ..write('type: $type, ')
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
          backdropPath.hashCode,
          $mrjc(
              createdBy.hashCode,
              $mrjc(
                  episodeRunTime.hashCode,
                  $mrjc(
                      firstAirDate.hashCode,
                      $mrjc(
                          genres.hashCode,
                          $mrjc(
                              languages.hashCode,
                              $mrjc(
                                  name.hashCode,
                                  $mrjc(
                                      numberOfEpisodes.hashCode,
                                      $mrjc(
                                          numberOfSeasons.hashCode,
                                          $mrjc(
                                              originCountry.hashCode,
                                              $mrjc(
                                                  originalLanguage.hashCode,
                                                  $mrjc(
                                                      originalName.hashCode,
                                                      $mrjc(
                                                          overview.hashCode,
                                                          $mrjc(
                                                              popularity
                                                                  .hashCode,
                                                              $mrjc(
                                                                  posterPath
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      productionCountries
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          productionCompanies
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              spokenLanguages.hashCode,
                                                                              $mrjc(status.hashCode, $mrjc(tagline.hashCode, $mrjc(type.hashCode, $mrjc(fecha_reg.hashCode, $mrjc(externalId.hashCode, isFavourite.hashCode)))))))))))))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is TvShow &&
          other.id == this.id &&
          other.backdropPath == this.backdropPath &&
          other.createdBy == this.createdBy &&
          other.episodeRunTime == this.episodeRunTime &&
          other.firstAirDate == this.firstAirDate &&
          other.genres == this.genres &&
          other.languages == this.languages &&
          other.name == this.name &&
          other.numberOfEpisodes == this.numberOfEpisodes &&
          other.numberOfSeasons == this.numberOfSeasons &&
          other.originCountry == this.originCountry &&
          other.originalLanguage == this.originalLanguage &&
          other.originalName == this.originalName &&
          other.overview == this.overview &&
          other.popularity == this.popularity &&
          other.posterPath == this.posterPath &&
          other.productionCountries == this.productionCountries &&
          other.productionCompanies == this.productionCompanies &&
          other.spokenLanguages == this.spokenLanguages &&
          other.status == this.status &&
          other.tagline == this.tagline &&
          other.type == this.type &&
          other.fecha_reg == this.fecha_reg &&
          other.externalId == this.externalId &&
          other.isFavourite == this.isFavourite);
}

class TvShowTableCompanion extends UpdateCompanion<TvShow> {
  final Value<int> id;
  final Value<String> backdropPath;
  final Value<String> createdBy;
  final Value<int> episodeRunTime;
  final Value<String> firstAirDate;
  final Value<String> genres;
  final Value<String> languages;
  final Value<String> name;
  final Value<int> numberOfEpisodes;
  final Value<int> numberOfSeasons;
  final Value<String> originCountry;
  final Value<String> originalLanguage;
  final Value<String> originalName;
  final Value<String> overview;
  final Value<double> popularity;
  final Value<String> posterPath;
  final Value<String> productionCountries;
  final Value<String> productionCompanies;
  final Value<String> spokenLanguages;
  final Value<String> status;
  final Value<String> tagline;
  final Value<String> type;
  final Value<DateTime> fecha_reg;
  final Value<String> externalId;
  final Value<bool> isFavourite;
  const TvShowTableCompanion({
    this.id = const Value.absent(),
    this.backdropPath = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.episodeRunTime = const Value.absent(),
    this.firstAirDate = const Value.absent(),
    this.genres = const Value.absent(),
    this.languages = const Value.absent(),
    this.name = const Value.absent(),
    this.numberOfEpisodes = const Value.absent(),
    this.numberOfSeasons = const Value.absent(),
    this.originCountry = const Value.absent(),
    this.originalLanguage = const Value.absent(),
    this.originalName = const Value.absent(),
    this.overview = const Value.absent(),
    this.popularity = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.productionCountries = const Value.absent(),
    this.productionCompanies = const Value.absent(),
    this.spokenLanguages = const Value.absent(),
    this.status = const Value.absent(),
    this.tagline = const Value.absent(),
    this.type = const Value.absent(),
    this.fecha_reg = const Value.absent(),
    this.externalId = const Value.absent(),
    this.isFavourite = const Value.absent(),
  });
  TvShowTableCompanion.insert({
    this.id = const Value.absent(),
    this.backdropPath = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.episodeRunTime = const Value.absent(),
    this.firstAirDate = const Value.absent(),
    this.genres = const Value.absent(),
    this.languages = const Value.absent(),
    this.name = const Value.absent(),
    this.numberOfEpisodes = const Value.absent(),
    this.numberOfSeasons = const Value.absent(),
    this.originCountry = const Value.absent(),
    this.originalLanguage = const Value.absent(),
    this.originalName = const Value.absent(),
    this.overview = const Value.absent(),
    this.popularity = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.productionCountries = const Value.absent(),
    this.productionCompanies = const Value.absent(),
    this.spokenLanguages = const Value.absent(),
    this.status = const Value.absent(),
    this.tagline = const Value.absent(),
    this.type = const Value.absent(),
    this.fecha_reg = const Value.absent(),
    this.externalId = const Value.absent(),
    this.isFavourite = const Value.absent(),
  });
  static Insertable<TvShow> custom({
    Expression<int> id,
    Expression<String> backdropPath,
    Expression<String> createdBy,
    Expression<int> episodeRunTime,
    Expression<String> firstAirDate,
    Expression<String> genres,
    Expression<String> languages,
    Expression<String> name,
    Expression<int> numberOfEpisodes,
    Expression<int> numberOfSeasons,
    Expression<String> originCountry,
    Expression<String> originalLanguage,
    Expression<String> originalName,
    Expression<String> overview,
    Expression<double> popularity,
    Expression<String> posterPath,
    Expression<String> productionCountries,
    Expression<String> productionCompanies,
    Expression<String> spokenLanguages,
    Expression<String> status,
    Expression<String> tagline,
    Expression<String> type,
    Expression<DateTime> fecha_reg,
    Expression<String> externalId,
    Expression<bool> isFavourite,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (backdropPath != null) 'backdrop_path': backdropPath,
      if (createdBy != null) 'created_by': createdBy,
      if (episodeRunTime != null) 'episode_run_time': episodeRunTime,
      if (firstAirDate != null) 'first_air_date': firstAirDate,
      if (genres != null) 'genres': genres,
      if (languages != null) 'languages': languages,
      if (name != null) 'name': name,
      if (numberOfEpisodes != null) 'number_of_episodes': numberOfEpisodes,
      if (numberOfSeasons != null) 'number_of_seasons': numberOfSeasons,
      if (originCountry != null) 'origin_country': originCountry,
      if (originalLanguage != null) 'original_language': originalLanguage,
      if (originalName != null) 'original_name': originalName,
      if (overview != null) 'overview': overview,
      if (popularity != null) 'popularity': popularity,
      if (posterPath != null) 'poster_path': posterPath,
      if (productionCountries != null)
        'production_countries': productionCountries,
      if (productionCompanies != null)
        'production_companies': productionCompanies,
      if (spokenLanguages != null) 'spoken_languages': spokenLanguages,
      if (status != null) 'status': status,
      if (tagline != null) 'tagline': tagline,
      if (type != null) 'type': type,
      if (fecha_reg != null) 'fecha_reg': fecha_reg,
      if (externalId != null) 'external_id': externalId,
      if (isFavourite != null) 'is_favourite': isFavourite,
    });
  }

  TvShowTableCompanion copyWith(
      {Value<int> id,
      Value<String> backdropPath,
      Value<String> createdBy,
      Value<int> episodeRunTime,
      Value<String> firstAirDate,
      Value<String> genres,
      Value<String> languages,
      Value<String> name,
      Value<int> numberOfEpisodes,
      Value<int> numberOfSeasons,
      Value<String> originCountry,
      Value<String> originalLanguage,
      Value<String> originalName,
      Value<String> overview,
      Value<double> popularity,
      Value<String> posterPath,
      Value<String> productionCountries,
      Value<String> productionCompanies,
      Value<String> spokenLanguages,
      Value<String> status,
      Value<String> tagline,
      Value<String> type,
      Value<DateTime> fecha_reg,
      Value<String> externalId,
      Value<bool> isFavourite}) {
    return TvShowTableCompanion(
      id: id ?? this.id,
      backdropPath: backdropPath ?? this.backdropPath,
      createdBy: createdBy ?? this.createdBy,
      episodeRunTime: episodeRunTime ?? this.episodeRunTime,
      firstAirDate: firstAirDate ?? this.firstAirDate,
      genres: genres ?? this.genres,
      languages: languages ?? this.languages,
      name: name ?? this.name,
      numberOfEpisodes: numberOfEpisodes ?? this.numberOfEpisodes,
      numberOfSeasons: numberOfSeasons ?? this.numberOfSeasons,
      originCountry: originCountry ?? this.originCountry,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalName: originalName ?? this.originalName,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      productionCountries: productionCountries ?? this.productionCountries,
      productionCompanies: productionCompanies ?? this.productionCompanies,
      spokenLanguages: spokenLanguages ?? this.spokenLanguages,
      status: status ?? this.status,
      tagline: tagline ?? this.tagline,
      type: type ?? this.type,
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
    if (backdropPath.present) {
      map['backdrop_path'] = Variable<String>(backdropPath.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (episodeRunTime.present) {
      map['episode_run_time'] = Variable<int>(episodeRunTime.value);
    }
    if (firstAirDate.present) {
      map['first_air_date'] = Variable<String>(firstAirDate.value);
    }
    if (genres.present) {
      map['genres'] = Variable<String>(genres.value);
    }
    if (languages.present) {
      map['languages'] = Variable<String>(languages.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (numberOfEpisodes.present) {
      map['number_of_episodes'] = Variable<int>(numberOfEpisodes.value);
    }
    if (numberOfSeasons.present) {
      map['number_of_seasons'] = Variable<int>(numberOfSeasons.value);
    }
    if (originCountry.present) {
      map['origin_country'] = Variable<String>(originCountry.value);
    }
    if (originalLanguage.present) {
      map['original_language'] = Variable<String>(originalLanguage.value);
    }
    if (originalName.present) {
      map['original_name'] = Variable<String>(originalName.value);
    }
    if (overview.present) {
      map['overview'] = Variable<String>(overview.value);
    }
    if (popularity.present) {
      map['popularity'] = Variable<double>(popularity.value);
    }
    if (posterPath.present) {
      map['poster_path'] = Variable<String>(posterPath.value);
    }
    if (productionCountries.present) {
      map['production_countries'] = Variable<String>(productionCountries.value);
    }
    if (productionCompanies.present) {
      map['production_companies'] = Variable<String>(productionCompanies.value);
    }
    if (spokenLanguages.present) {
      map['spoken_languages'] = Variable<String>(spokenLanguages.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (tagline.present) {
      map['tagline'] = Variable<String>(tagline.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
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
    return (StringBuffer('TvShowTableCompanion(')
          ..write('id: $id, ')
          ..write('backdropPath: $backdropPath, ')
          ..write('createdBy: $createdBy, ')
          ..write('episodeRunTime: $episodeRunTime, ')
          ..write('firstAirDate: $firstAirDate, ')
          ..write('genres: $genres, ')
          ..write('languages: $languages, ')
          ..write('name: $name, ')
          ..write('numberOfEpisodes: $numberOfEpisodes, ')
          ..write('numberOfSeasons: $numberOfSeasons, ')
          ..write('originCountry: $originCountry, ')
          ..write('originalLanguage: $originalLanguage, ')
          ..write('originalName: $originalName, ')
          ..write('overview: $overview, ')
          ..write('popularity: $popularity, ')
          ..write('posterPath: $posterPath, ')
          ..write('productionCountries: $productionCountries, ')
          ..write('productionCompanies: $productionCompanies, ')
          ..write('spokenLanguages: $spokenLanguages, ')
          ..write('status: $status, ')
          ..write('tagline: $tagline, ')
          ..write('type: $type, ')
          ..write('fecha_reg: $fecha_reg, ')
          ..write('externalId: $externalId, ')
          ..write('isFavourite: $isFavourite')
          ..write(')'))
        .toString();
  }
}

class $TvShowTableTable extends TvShowTable
    with TableInfo<$TvShowTableTable, TvShow> {
  final GeneratedDatabase _db;
  final String _alias;
  $TvShowTableTable(this._db, [this._alias]);
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

  final VerificationMeta _backdropPathMeta =
      const VerificationMeta('backdropPath');
  GeneratedTextColumn _backdropPath;
  @override
  GeneratedTextColumn get backdropPath =>
      _backdropPath ??= _constructBackdropPath();
  GeneratedTextColumn _constructBackdropPath() {
    return GeneratedTextColumn(
      'backdrop_path',
      $tableName,
      true,
    );
  }

  final VerificationMeta _createdByMeta = const VerificationMeta('createdBy');
  GeneratedTextColumn _createdBy;
  @override
  GeneratedTextColumn get createdBy => _createdBy ??= _constructCreatedBy();
  GeneratedTextColumn _constructCreatedBy() {
    return GeneratedTextColumn(
      'created_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _episodeRunTimeMeta =
      const VerificationMeta('episodeRunTime');
  GeneratedIntColumn _episodeRunTime;
  @override
  GeneratedIntColumn get episodeRunTime =>
      _episodeRunTime ??= _constructEpisodeRunTime();
  GeneratedIntColumn _constructEpisodeRunTime() {
    return GeneratedIntColumn(
      'episode_run_time',
      $tableName,
      true,
    );
  }

  final VerificationMeta _firstAirDateMeta =
      const VerificationMeta('firstAirDate');
  GeneratedTextColumn _firstAirDate;
  @override
  GeneratedTextColumn get firstAirDate =>
      _firstAirDate ??= _constructFirstAirDate();
  GeneratedTextColumn _constructFirstAirDate() {
    return GeneratedTextColumn(
      'first_air_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _genresMeta = const VerificationMeta('genres');
  GeneratedTextColumn _genres;
  @override
  GeneratedTextColumn get genres => _genres ??= _constructGenres();
  GeneratedTextColumn _constructGenres() {
    return GeneratedTextColumn(
      'genres',
      $tableName,
      true,
    );
  }

  final VerificationMeta _languagesMeta = const VerificationMeta('languages');
  GeneratedTextColumn _languages;
  @override
  GeneratedTextColumn get languages => _languages ??= _constructLanguages();
  GeneratedTextColumn _constructLanguages() {
    return GeneratedTextColumn(
      'languages',
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

  final VerificationMeta _numberOfEpisodesMeta =
      const VerificationMeta('numberOfEpisodes');
  GeneratedIntColumn _numberOfEpisodes;
  @override
  GeneratedIntColumn get numberOfEpisodes =>
      _numberOfEpisodes ??= _constructNumberOfEpisodes();
  GeneratedIntColumn _constructNumberOfEpisodes() {
    return GeneratedIntColumn(
      'number_of_episodes',
      $tableName,
      true,
    );
  }

  final VerificationMeta _numberOfSeasonsMeta =
      const VerificationMeta('numberOfSeasons');
  GeneratedIntColumn _numberOfSeasons;
  @override
  GeneratedIntColumn get numberOfSeasons =>
      _numberOfSeasons ??= _constructNumberOfSeasons();
  GeneratedIntColumn _constructNumberOfSeasons() {
    return GeneratedIntColumn(
      'number_of_seasons',
      $tableName,
      true,
    );
  }

  final VerificationMeta _originCountryMeta =
      const VerificationMeta('originCountry');
  GeneratedTextColumn _originCountry;
  @override
  GeneratedTextColumn get originCountry =>
      _originCountry ??= _constructOriginCountry();
  GeneratedTextColumn _constructOriginCountry() {
    return GeneratedTextColumn(
      'origin_country',
      $tableName,
      true,
    );
  }

  final VerificationMeta _originalLanguageMeta =
      const VerificationMeta('originalLanguage');
  GeneratedTextColumn _originalLanguage;
  @override
  GeneratedTextColumn get originalLanguage =>
      _originalLanguage ??= _constructOriginalLanguage();
  GeneratedTextColumn _constructOriginalLanguage() {
    return GeneratedTextColumn(
      'original_language',
      $tableName,
      true,
    );
  }

  final VerificationMeta _originalNameMeta =
      const VerificationMeta('originalName');
  GeneratedTextColumn _originalName;
  @override
  GeneratedTextColumn get originalName =>
      _originalName ??= _constructOriginalName();
  GeneratedTextColumn _constructOriginalName() {
    return GeneratedTextColumn(
      'original_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _overviewMeta = const VerificationMeta('overview');
  GeneratedTextColumn _overview;
  @override
  GeneratedTextColumn get overview => _overview ??= _constructOverview();
  GeneratedTextColumn _constructOverview() {
    return GeneratedTextColumn(
      'overview',
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

  final VerificationMeta _posterPathMeta = const VerificationMeta('posterPath');
  GeneratedTextColumn _posterPath;
  @override
  GeneratedTextColumn get posterPath => _posterPath ??= _constructPosterPath();
  GeneratedTextColumn _constructPosterPath() {
    return GeneratedTextColumn(
      'poster_path',
      $tableName,
      true,
    );
  }

  final VerificationMeta _productionCountriesMeta =
      const VerificationMeta('productionCountries');
  GeneratedTextColumn _productionCountries;
  @override
  GeneratedTextColumn get productionCountries =>
      _productionCountries ??= _constructProductionCountries();
  GeneratedTextColumn _constructProductionCountries() {
    return GeneratedTextColumn(
      'production_countries',
      $tableName,
      true,
    );
  }

  final VerificationMeta _productionCompaniesMeta =
      const VerificationMeta('productionCompanies');
  GeneratedTextColumn _productionCompanies;
  @override
  GeneratedTextColumn get productionCompanies =>
      _productionCompanies ??= _constructProductionCompanies();
  GeneratedTextColumn _constructProductionCompanies() {
    return GeneratedTextColumn(
      'production_companies',
      $tableName,
      true,
    );
  }

  final VerificationMeta _spokenLanguagesMeta =
      const VerificationMeta('spokenLanguages');
  GeneratedTextColumn _spokenLanguages;
  @override
  GeneratedTextColumn get spokenLanguages =>
      _spokenLanguages ??= _constructSpokenLanguages();
  GeneratedTextColumn _constructSpokenLanguages() {
    return GeneratedTextColumn(
      'spoken_languages',
      $tableName,
      true,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedTextColumn _status;
  @override
  GeneratedTextColumn get status => _status ??= _constructStatus();
  GeneratedTextColumn _constructStatus() {
    return GeneratedTextColumn(
      'status',
      $tableName,
      true,
    );
  }

  final VerificationMeta _taglineMeta = const VerificationMeta('tagline');
  GeneratedTextColumn _tagline;
  @override
  GeneratedTextColumn get tagline => _tagline ??= _constructTagline();
  GeneratedTextColumn _constructTagline() {
    return GeneratedTextColumn(
      'tagline',
      $tableName,
      true,
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
        backdropPath,
        createdBy,
        episodeRunTime,
        firstAirDate,
        genres,
        languages,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        productionCountries,
        productionCompanies,
        spokenLanguages,
        status,
        tagline,
        type,
        fecha_reg,
        externalId,
        isFavourite
      ];
  @override
  $TvShowTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tv_show_table';
  @override
  final String actualTableName = 'tv_show_table';
  @override
  VerificationContext validateIntegrity(Insertable<TvShow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('backdrop_path')) {
      context.handle(
          _backdropPathMeta,
          backdropPath.isAcceptableOrUnknown(
              data['backdrop_path'], _backdropPathMeta));
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by'], _createdByMeta));
    }
    if (data.containsKey('episode_run_time')) {
      context.handle(
          _episodeRunTimeMeta,
          episodeRunTime.isAcceptableOrUnknown(
              data['episode_run_time'], _episodeRunTimeMeta));
    }
    if (data.containsKey('first_air_date')) {
      context.handle(
          _firstAirDateMeta,
          firstAirDate.isAcceptableOrUnknown(
              data['first_air_date'], _firstAirDateMeta));
    }
    if (data.containsKey('genres')) {
      context.handle(_genresMeta,
          genres.isAcceptableOrUnknown(data['genres'], _genresMeta));
    }
    if (data.containsKey('languages')) {
      context.handle(_languagesMeta,
          languages.isAcceptableOrUnknown(data['languages'], _languagesMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    }
    if (data.containsKey('number_of_episodes')) {
      context.handle(
          _numberOfEpisodesMeta,
          numberOfEpisodes.isAcceptableOrUnknown(
              data['number_of_episodes'], _numberOfEpisodesMeta));
    }
    if (data.containsKey('number_of_seasons')) {
      context.handle(
          _numberOfSeasonsMeta,
          numberOfSeasons.isAcceptableOrUnknown(
              data['number_of_seasons'], _numberOfSeasonsMeta));
    }
    if (data.containsKey('origin_country')) {
      context.handle(
          _originCountryMeta,
          originCountry.isAcceptableOrUnknown(
              data['origin_country'], _originCountryMeta));
    }
    if (data.containsKey('original_language')) {
      context.handle(
          _originalLanguageMeta,
          originalLanguage.isAcceptableOrUnknown(
              data['original_language'], _originalLanguageMeta));
    }
    if (data.containsKey('original_name')) {
      context.handle(
          _originalNameMeta,
          originalName.isAcceptableOrUnknown(
              data['original_name'], _originalNameMeta));
    }
    if (data.containsKey('overview')) {
      context.handle(_overviewMeta,
          overview.isAcceptableOrUnknown(data['overview'], _overviewMeta));
    }
    if (data.containsKey('popularity')) {
      context.handle(
          _popularityMeta,
          popularity.isAcceptableOrUnknown(
              data['popularity'], _popularityMeta));
    }
    if (data.containsKey('poster_path')) {
      context.handle(
          _posterPathMeta,
          posterPath.isAcceptableOrUnknown(
              data['poster_path'], _posterPathMeta));
    }
    if (data.containsKey('production_countries')) {
      context.handle(
          _productionCountriesMeta,
          productionCountries.isAcceptableOrUnknown(
              data['production_countries'], _productionCountriesMeta));
    }
    if (data.containsKey('production_companies')) {
      context.handle(
          _productionCompaniesMeta,
          productionCompanies.isAcceptableOrUnknown(
              data['production_companies'], _productionCompaniesMeta));
    }
    if (data.containsKey('spoken_languages')) {
      context.handle(
          _spokenLanguagesMeta,
          spokenLanguages.isAcceptableOrUnknown(
              data['spoken_languages'], _spokenLanguagesMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status'], _statusMeta));
    }
    if (data.containsKey('tagline')) {
      context.handle(_taglineMeta,
          tagline.isAcceptableOrUnknown(data['tagline'], _taglineMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type'], _typeMeta));
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
  TvShow map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TvShow.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TvShowTableTable createAlias(String alias) {
    return $TvShowTableTable(_db, alias);
  }
}

class Movie extends DataClass implements Insertable<Movie> {
  final int id;
  final String backdropPath;
  final String genres;
  final String homepage;
  final String imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String productionCompanies;
  final String productionCountries;
  final String releaseDate;
  final double runtime;
  final String spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final DateTime fecha_reg;
  final String externalId;
  final bool isFavourite;
  Movie(
      {@required this.id,
      this.backdropPath,
      this.genres,
      this.homepage,
      this.imdbId,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.productionCompanies,
      this.productionCountries,
      this.releaseDate,
      this.runtime,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.title,
      this.video,
      this.fecha_reg,
      this.externalId,
      @required this.isFavourite});
  factory Movie.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final boolType = db.typeSystem.forDartType<bool>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Movie(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      backdropPath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}backdrop_path']),
      genres:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}genres']),
      homepage: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}homepage']),
      imdbId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}imdb_id']),
      originalLanguage: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}original_language']),
      originalTitle: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}original_title']),
      overview: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}overview']),
      popularity: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}popularity']),
      posterPath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}poster_path']),
      productionCompanies: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}production_companies']),
      productionCountries: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}production_countries']),
      releaseDate: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}release_date']),
      runtime:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}runtime']),
      spokenLanguages: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}spoken_languages']),
      status:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}status']),
      tagline:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}tagline']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      video: boolType.mapFromDatabaseResponse(data['${effectivePrefix}video']),
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
    if (!nullToAbsent || backdropPath != null) {
      map['backdrop_path'] = Variable<String>(backdropPath);
    }
    if (!nullToAbsent || genres != null) {
      map['genres'] = Variable<String>(genres);
    }
    if (!nullToAbsent || homepage != null) {
      map['homepage'] = Variable<String>(homepage);
    }
    if (!nullToAbsent || imdbId != null) {
      map['imdb_id'] = Variable<String>(imdbId);
    }
    if (!nullToAbsent || originalLanguage != null) {
      map['original_language'] = Variable<String>(originalLanguage);
    }
    if (!nullToAbsent || originalTitle != null) {
      map['original_title'] = Variable<String>(originalTitle);
    }
    if (!nullToAbsent || overview != null) {
      map['overview'] = Variable<String>(overview);
    }
    if (!nullToAbsent || popularity != null) {
      map['popularity'] = Variable<double>(popularity);
    }
    if (!nullToAbsent || posterPath != null) {
      map['poster_path'] = Variable<String>(posterPath);
    }
    if (!nullToAbsent || productionCompanies != null) {
      map['production_companies'] = Variable<String>(productionCompanies);
    }
    if (!nullToAbsent || productionCountries != null) {
      map['production_countries'] = Variable<String>(productionCountries);
    }
    if (!nullToAbsent || releaseDate != null) {
      map['release_date'] = Variable<String>(releaseDate);
    }
    if (!nullToAbsent || runtime != null) {
      map['runtime'] = Variable<double>(runtime);
    }
    if (!nullToAbsent || spokenLanguages != null) {
      map['spoken_languages'] = Variable<String>(spokenLanguages);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    if (!nullToAbsent || tagline != null) {
      map['tagline'] = Variable<String>(tagline);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || video != null) {
      map['video'] = Variable<bool>(video);
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

  MovieTableCompanion toCompanion(bool nullToAbsent) {
    return MovieTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      backdropPath: backdropPath == null && nullToAbsent
          ? const Value.absent()
          : Value(backdropPath),
      genres:
          genres == null && nullToAbsent ? const Value.absent() : Value(genres),
      homepage: homepage == null && nullToAbsent
          ? const Value.absent()
          : Value(homepage),
      imdbId:
          imdbId == null && nullToAbsent ? const Value.absent() : Value(imdbId),
      originalLanguage: originalLanguage == null && nullToAbsent
          ? const Value.absent()
          : Value(originalLanguage),
      originalTitle: originalTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(originalTitle),
      overview: overview == null && nullToAbsent
          ? const Value.absent()
          : Value(overview),
      popularity: popularity == null && nullToAbsent
          ? const Value.absent()
          : Value(popularity),
      posterPath: posterPath == null && nullToAbsent
          ? const Value.absent()
          : Value(posterPath),
      productionCompanies: productionCompanies == null && nullToAbsent
          ? const Value.absent()
          : Value(productionCompanies),
      productionCountries: productionCountries == null && nullToAbsent
          ? const Value.absent()
          : Value(productionCountries),
      releaseDate: releaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(releaseDate),
      runtime: runtime == null && nullToAbsent
          ? const Value.absent()
          : Value(runtime),
      spokenLanguages: spokenLanguages == null && nullToAbsent
          ? const Value.absent()
          : Value(spokenLanguages),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      tagline: tagline == null && nullToAbsent
          ? const Value.absent()
          : Value(tagline),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      video:
          video == null && nullToAbsent ? const Value.absent() : Value(video),
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

  factory Movie.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Movie(
      id: serializer.fromJson<int>(json['id']),
      backdropPath: serializer.fromJson<String>(json['backdropPath']),
      genres: serializer.fromJson<String>(json['genres']),
      homepage: serializer.fromJson<String>(json['homepage']),
      imdbId: serializer.fromJson<String>(json['imdbId']),
      originalLanguage: serializer.fromJson<String>(json['originalLanguage']),
      originalTitle: serializer.fromJson<String>(json['originalTitle']),
      overview: serializer.fromJson<String>(json['overview']),
      popularity: serializer.fromJson<double>(json['popularity']),
      posterPath: serializer.fromJson<String>(json['posterPath']),
      productionCompanies:
          serializer.fromJson<String>(json['productionCompanies']),
      productionCountries:
          serializer.fromJson<String>(json['productionCountries']),
      releaseDate: serializer.fromJson<String>(json['releaseDate']),
      runtime: serializer.fromJson<double>(json['runtime']),
      spokenLanguages: serializer.fromJson<String>(json['spokenLanguages']),
      status: serializer.fromJson<String>(json['status']),
      tagline: serializer.fromJson<String>(json['tagline']),
      title: serializer.fromJson<String>(json['title']),
      video: serializer.fromJson<bool>(json['video']),
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
      'backdropPath': serializer.toJson<String>(backdropPath),
      'genres': serializer.toJson<String>(genres),
      'homepage': serializer.toJson<String>(homepage),
      'imdbId': serializer.toJson<String>(imdbId),
      'originalLanguage': serializer.toJson<String>(originalLanguage),
      'originalTitle': serializer.toJson<String>(originalTitle),
      'overview': serializer.toJson<String>(overview),
      'popularity': serializer.toJson<double>(popularity),
      'posterPath': serializer.toJson<String>(posterPath),
      'productionCompanies': serializer.toJson<String>(productionCompanies),
      'productionCountries': serializer.toJson<String>(productionCountries),
      'releaseDate': serializer.toJson<String>(releaseDate),
      'runtime': serializer.toJson<double>(runtime),
      'spokenLanguages': serializer.toJson<String>(spokenLanguages),
      'status': serializer.toJson<String>(status),
      'tagline': serializer.toJson<String>(tagline),
      'title': serializer.toJson<String>(title),
      'video': serializer.toJson<bool>(video),
      'fecha_reg': serializer.toJson<DateTime>(fecha_reg),
      'externalId': serializer.toJson<String>(externalId),
      'isFavourite': serializer.toJson<bool>(isFavourite),
    };
  }

  Movie copyWith(
          {int id,
          String backdropPath,
          String genres,
          String homepage,
          String imdbId,
          String originalLanguage,
          String originalTitle,
          String overview,
          double popularity,
          String posterPath,
          String productionCompanies,
          String productionCountries,
          String releaseDate,
          double runtime,
          String spokenLanguages,
          String status,
          String tagline,
          String title,
          bool video,
          DateTime fecha_reg,
          String externalId,
          bool isFavourite}) =>
      Movie(
        id: id ?? this.id,
        backdropPath: backdropPath ?? this.backdropPath,
        genres: genres ?? this.genres,
        homepage: homepage ?? this.homepage,
        imdbId: imdbId ?? this.imdbId,
        originalLanguage: originalLanguage ?? this.originalLanguage,
        originalTitle: originalTitle ?? this.originalTitle,
        overview: overview ?? this.overview,
        popularity: popularity ?? this.popularity,
        posterPath: posterPath ?? this.posterPath,
        productionCompanies: productionCompanies ?? this.productionCompanies,
        productionCountries: productionCountries ?? this.productionCountries,
        releaseDate: releaseDate ?? this.releaseDate,
        runtime: runtime ?? this.runtime,
        spokenLanguages: spokenLanguages ?? this.spokenLanguages,
        status: status ?? this.status,
        tagline: tagline ?? this.tagline,
        title: title ?? this.title,
        video: video ?? this.video,
        fecha_reg: fecha_reg ?? this.fecha_reg,
        externalId: externalId ?? this.externalId,
        isFavourite: isFavourite ?? this.isFavourite,
      );
  @override
  String toString() {
    return (StringBuffer('Movie(')
          ..write('id: $id, ')
          ..write('backdropPath: $backdropPath, ')
          ..write('genres: $genres, ')
          ..write('homepage: $homepage, ')
          ..write('imdbId: $imdbId, ')
          ..write('originalLanguage: $originalLanguage, ')
          ..write('originalTitle: $originalTitle, ')
          ..write('overview: $overview, ')
          ..write('popularity: $popularity, ')
          ..write('posterPath: $posterPath, ')
          ..write('productionCompanies: $productionCompanies, ')
          ..write('productionCountries: $productionCountries, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('runtime: $runtime, ')
          ..write('spokenLanguages: $spokenLanguages, ')
          ..write('status: $status, ')
          ..write('tagline: $tagline, ')
          ..write('title: $title, ')
          ..write('video: $video, ')
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
          backdropPath.hashCode,
          $mrjc(
              genres.hashCode,
              $mrjc(
                  homepage.hashCode,
                  $mrjc(
                      imdbId.hashCode,
                      $mrjc(
                          originalLanguage.hashCode,
                          $mrjc(
                              originalTitle.hashCode,
                              $mrjc(
                                  overview.hashCode,
                                  $mrjc(
                                      popularity.hashCode,
                                      $mrjc(
                                          posterPath.hashCode,
                                          $mrjc(
                                              productionCompanies.hashCode,
                                              $mrjc(
                                                  productionCountries.hashCode,
                                                  $mrjc(
                                                      releaseDate.hashCode,
                                                      $mrjc(
                                                          runtime.hashCode,
                                                          $mrjc(
                                                              spokenLanguages
                                                                  .hashCode,
                                                              $mrjc(
                                                                  status
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      tagline
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          title
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              video.hashCode,
                                                                              $mrjc(fecha_reg.hashCode, $mrjc(externalId.hashCode, isFavourite.hashCode))))))))))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Movie &&
          other.id == this.id &&
          other.backdropPath == this.backdropPath &&
          other.genres == this.genres &&
          other.homepage == this.homepage &&
          other.imdbId == this.imdbId &&
          other.originalLanguage == this.originalLanguage &&
          other.originalTitle == this.originalTitle &&
          other.overview == this.overview &&
          other.popularity == this.popularity &&
          other.posterPath == this.posterPath &&
          other.productionCompanies == this.productionCompanies &&
          other.productionCountries == this.productionCountries &&
          other.releaseDate == this.releaseDate &&
          other.runtime == this.runtime &&
          other.spokenLanguages == this.spokenLanguages &&
          other.status == this.status &&
          other.tagline == this.tagline &&
          other.title == this.title &&
          other.video == this.video &&
          other.fecha_reg == this.fecha_reg &&
          other.externalId == this.externalId &&
          other.isFavourite == this.isFavourite);
}

class MovieTableCompanion extends UpdateCompanion<Movie> {
  final Value<int> id;
  final Value<String> backdropPath;
  final Value<String> genres;
  final Value<String> homepage;
  final Value<String> imdbId;
  final Value<String> originalLanguage;
  final Value<String> originalTitle;
  final Value<String> overview;
  final Value<double> popularity;
  final Value<String> posterPath;
  final Value<String> productionCompanies;
  final Value<String> productionCountries;
  final Value<String> releaseDate;
  final Value<double> runtime;
  final Value<String> spokenLanguages;
  final Value<String> status;
  final Value<String> tagline;
  final Value<String> title;
  final Value<bool> video;
  final Value<DateTime> fecha_reg;
  final Value<String> externalId;
  final Value<bool> isFavourite;
  const MovieTableCompanion({
    this.id = const Value.absent(),
    this.backdropPath = const Value.absent(),
    this.genres = const Value.absent(),
    this.homepage = const Value.absent(),
    this.imdbId = const Value.absent(),
    this.originalLanguage = const Value.absent(),
    this.originalTitle = const Value.absent(),
    this.overview = const Value.absent(),
    this.popularity = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.productionCompanies = const Value.absent(),
    this.productionCountries = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.runtime = const Value.absent(),
    this.spokenLanguages = const Value.absent(),
    this.status = const Value.absent(),
    this.tagline = const Value.absent(),
    this.title = const Value.absent(),
    this.video = const Value.absent(),
    this.fecha_reg = const Value.absent(),
    this.externalId = const Value.absent(),
    this.isFavourite = const Value.absent(),
  });
  MovieTableCompanion.insert({
    this.id = const Value.absent(),
    this.backdropPath = const Value.absent(),
    this.genres = const Value.absent(),
    this.homepage = const Value.absent(),
    this.imdbId = const Value.absent(),
    this.originalLanguage = const Value.absent(),
    this.originalTitle = const Value.absent(),
    this.overview = const Value.absent(),
    this.popularity = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.productionCompanies = const Value.absent(),
    this.productionCountries = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.runtime = const Value.absent(),
    this.spokenLanguages = const Value.absent(),
    this.status = const Value.absent(),
    this.tagline = const Value.absent(),
    this.title = const Value.absent(),
    this.video = const Value.absent(),
    this.fecha_reg = const Value.absent(),
    this.externalId = const Value.absent(),
    this.isFavourite = const Value.absent(),
  });
  static Insertable<Movie> custom({
    Expression<int> id,
    Expression<String> backdropPath,
    Expression<String> genres,
    Expression<String> homepage,
    Expression<String> imdbId,
    Expression<String> originalLanguage,
    Expression<String> originalTitle,
    Expression<String> overview,
    Expression<double> popularity,
    Expression<String> posterPath,
    Expression<String> productionCompanies,
    Expression<String> productionCountries,
    Expression<String> releaseDate,
    Expression<double> runtime,
    Expression<String> spokenLanguages,
    Expression<String> status,
    Expression<String> tagline,
    Expression<String> title,
    Expression<bool> video,
    Expression<DateTime> fecha_reg,
    Expression<String> externalId,
    Expression<bool> isFavourite,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (backdropPath != null) 'backdrop_path': backdropPath,
      if (genres != null) 'genres': genres,
      if (homepage != null) 'homepage': homepage,
      if (imdbId != null) 'imdb_id': imdbId,
      if (originalLanguage != null) 'original_language': originalLanguage,
      if (originalTitle != null) 'original_title': originalTitle,
      if (overview != null) 'overview': overview,
      if (popularity != null) 'popularity': popularity,
      if (posterPath != null) 'poster_path': posterPath,
      if (productionCompanies != null)
        'production_companies': productionCompanies,
      if (productionCountries != null)
        'production_countries': productionCountries,
      if (releaseDate != null) 'release_date': releaseDate,
      if (runtime != null) 'runtime': runtime,
      if (spokenLanguages != null) 'spoken_languages': spokenLanguages,
      if (status != null) 'status': status,
      if (tagline != null) 'tagline': tagline,
      if (title != null) 'title': title,
      if (video != null) 'video': video,
      if (fecha_reg != null) 'fecha_reg': fecha_reg,
      if (externalId != null) 'external_id': externalId,
      if (isFavourite != null) 'is_favourite': isFavourite,
    });
  }

  MovieTableCompanion copyWith(
      {Value<int> id,
      Value<String> backdropPath,
      Value<String> genres,
      Value<String> homepage,
      Value<String> imdbId,
      Value<String> originalLanguage,
      Value<String> originalTitle,
      Value<String> overview,
      Value<double> popularity,
      Value<String> posterPath,
      Value<String> productionCompanies,
      Value<String> productionCountries,
      Value<String> releaseDate,
      Value<double> runtime,
      Value<String> spokenLanguages,
      Value<String> status,
      Value<String> tagline,
      Value<String> title,
      Value<bool> video,
      Value<DateTime> fecha_reg,
      Value<String> externalId,
      Value<bool> isFavourite}) {
    return MovieTableCompanion(
      id: id ?? this.id,
      backdropPath: backdropPath ?? this.backdropPath,
      genres: genres ?? this.genres,
      homepage: homepage ?? this.homepage,
      imdbId: imdbId ?? this.imdbId,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      productionCompanies: productionCompanies ?? this.productionCompanies,
      productionCountries: productionCountries ?? this.productionCountries,
      releaseDate: releaseDate ?? this.releaseDate,
      runtime: runtime ?? this.runtime,
      spokenLanguages: spokenLanguages ?? this.spokenLanguages,
      status: status ?? this.status,
      tagline: tagline ?? this.tagline,
      title: title ?? this.title,
      video: video ?? this.video,
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
    if (backdropPath.present) {
      map['backdrop_path'] = Variable<String>(backdropPath.value);
    }
    if (genres.present) {
      map['genres'] = Variable<String>(genres.value);
    }
    if (homepage.present) {
      map['homepage'] = Variable<String>(homepage.value);
    }
    if (imdbId.present) {
      map['imdb_id'] = Variable<String>(imdbId.value);
    }
    if (originalLanguage.present) {
      map['original_language'] = Variable<String>(originalLanguage.value);
    }
    if (originalTitle.present) {
      map['original_title'] = Variable<String>(originalTitle.value);
    }
    if (overview.present) {
      map['overview'] = Variable<String>(overview.value);
    }
    if (popularity.present) {
      map['popularity'] = Variable<double>(popularity.value);
    }
    if (posterPath.present) {
      map['poster_path'] = Variable<String>(posterPath.value);
    }
    if (productionCompanies.present) {
      map['production_companies'] = Variable<String>(productionCompanies.value);
    }
    if (productionCountries.present) {
      map['production_countries'] = Variable<String>(productionCountries.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<String>(releaseDate.value);
    }
    if (runtime.present) {
      map['runtime'] = Variable<double>(runtime.value);
    }
    if (spokenLanguages.present) {
      map['spoken_languages'] = Variable<String>(spokenLanguages.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (tagline.present) {
      map['tagline'] = Variable<String>(tagline.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (video.present) {
      map['video'] = Variable<bool>(video.value);
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
    return (StringBuffer('MovieTableCompanion(')
          ..write('id: $id, ')
          ..write('backdropPath: $backdropPath, ')
          ..write('genres: $genres, ')
          ..write('homepage: $homepage, ')
          ..write('imdbId: $imdbId, ')
          ..write('originalLanguage: $originalLanguage, ')
          ..write('originalTitle: $originalTitle, ')
          ..write('overview: $overview, ')
          ..write('popularity: $popularity, ')
          ..write('posterPath: $posterPath, ')
          ..write('productionCompanies: $productionCompanies, ')
          ..write('productionCountries: $productionCountries, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('runtime: $runtime, ')
          ..write('spokenLanguages: $spokenLanguages, ')
          ..write('status: $status, ')
          ..write('tagline: $tagline, ')
          ..write('title: $title, ')
          ..write('video: $video, ')
          ..write('fecha_reg: $fecha_reg, ')
          ..write('externalId: $externalId, ')
          ..write('isFavourite: $isFavourite')
          ..write(')'))
        .toString();
  }
}

class $MovieTableTable extends MovieTable
    with TableInfo<$MovieTableTable, Movie> {
  final GeneratedDatabase _db;
  final String _alias;
  $MovieTableTable(this._db, [this._alias]);
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

  final VerificationMeta _backdropPathMeta =
      const VerificationMeta('backdropPath');
  GeneratedTextColumn _backdropPath;
  @override
  GeneratedTextColumn get backdropPath =>
      _backdropPath ??= _constructBackdropPath();
  GeneratedTextColumn _constructBackdropPath() {
    return GeneratedTextColumn(
      'backdrop_path',
      $tableName,
      true,
    );
  }

  final VerificationMeta _genresMeta = const VerificationMeta('genres');
  GeneratedTextColumn _genres;
  @override
  GeneratedTextColumn get genres => _genres ??= _constructGenres();
  GeneratedTextColumn _constructGenres() {
    return GeneratedTextColumn(
      'genres',
      $tableName,
      true,
    );
  }

  final VerificationMeta _homepageMeta = const VerificationMeta('homepage');
  GeneratedTextColumn _homepage;
  @override
  GeneratedTextColumn get homepage => _homepage ??= _constructHomepage();
  GeneratedTextColumn _constructHomepage() {
    return GeneratedTextColumn(
      'homepage',
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

  final VerificationMeta _originalLanguageMeta =
      const VerificationMeta('originalLanguage');
  GeneratedTextColumn _originalLanguage;
  @override
  GeneratedTextColumn get originalLanguage =>
      _originalLanguage ??= _constructOriginalLanguage();
  GeneratedTextColumn _constructOriginalLanguage() {
    return GeneratedTextColumn(
      'original_language',
      $tableName,
      true,
    );
  }

  final VerificationMeta _originalTitleMeta =
      const VerificationMeta('originalTitle');
  GeneratedTextColumn _originalTitle;
  @override
  GeneratedTextColumn get originalTitle =>
      _originalTitle ??= _constructOriginalTitle();
  GeneratedTextColumn _constructOriginalTitle() {
    return GeneratedTextColumn(
      'original_title',
      $tableName,
      true,
    );
  }

  final VerificationMeta _overviewMeta = const VerificationMeta('overview');
  GeneratedTextColumn _overview;
  @override
  GeneratedTextColumn get overview => _overview ??= _constructOverview();
  GeneratedTextColumn _constructOverview() {
    return GeneratedTextColumn(
      'overview',
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

  final VerificationMeta _posterPathMeta = const VerificationMeta('posterPath');
  GeneratedTextColumn _posterPath;
  @override
  GeneratedTextColumn get posterPath => _posterPath ??= _constructPosterPath();
  GeneratedTextColumn _constructPosterPath() {
    return GeneratedTextColumn(
      'poster_path',
      $tableName,
      true,
    );
  }

  final VerificationMeta _productionCompaniesMeta =
      const VerificationMeta('productionCompanies');
  GeneratedTextColumn _productionCompanies;
  @override
  GeneratedTextColumn get productionCompanies =>
      _productionCompanies ??= _constructProductionCompanies();
  GeneratedTextColumn _constructProductionCompanies() {
    return GeneratedTextColumn(
      'production_companies',
      $tableName,
      true,
    );
  }

  final VerificationMeta _productionCountriesMeta =
      const VerificationMeta('productionCountries');
  GeneratedTextColumn _productionCountries;
  @override
  GeneratedTextColumn get productionCountries =>
      _productionCountries ??= _constructProductionCountries();
  GeneratedTextColumn _constructProductionCountries() {
    return GeneratedTextColumn(
      'production_countries',
      $tableName,
      true,
    );
  }

  final VerificationMeta _releaseDateMeta =
      const VerificationMeta('releaseDate');
  GeneratedTextColumn _releaseDate;
  @override
  GeneratedTextColumn get releaseDate =>
      _releaseDate ??= _constructReleaseDate();
  GeneratedTextColumn _constructReleaseDate() {
    return GeneratedTextColumn(
      'release_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _runtimeMeta = const VerificationMeta('runtime');
  GeneratedRealColumn _runtime;
  @override
  GeneratedRealColumn get runtime => _runtime ??= _constructRuntime();
  GeneratedRealColumn _constructRuntime() {
    return GeneratedRealColumn(
      'runtime',
      $tableName,
      true,
    );
  }

  final VerificationMeta _spokenLanguagesMeta =
      const VerificationMeta('spokenLanguages');
  GeneratedTextColumn _spokenLanguages;
  @override
  GeneratedTextColumn get spokenLanguages =>
      _spokenLanguages ??= _constructSpokenLanguages();
  GeneratedTextColumn _constructSpokenLanguages() {
    return GeneratedTextColumn(
      'spoken_languages',
      $tableName,
      true,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedTextColumn _status;
  @override
  GeneratedTextColumn get status => _status ??= _constructStatus();
  GeneratedTextColumn _constructStatus() {
    return GeneratedTextColumn(
      'status',
      $tableName,
      true,
    );
  }

  final VerificationMeta _taglineMeta = const VerificationMeta('tagline');
  GeneratedTextColumn _tagline;
  @override
  GeneratedTextColumn get tagline => _tagline ??= _constructTagline();
  GeneratedTextColumn _constructTagline() {
    return GeneratedTextColumn(
      'tagline',
      $tableName,
      true,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      true,
    );
  }

  final VerificationMeta _videoMeta = const VerificationMeta('video');
  GeneratedBoolColumn _video;
  @override
  GeneratedBoolColumn get video => _video ??= _constructVideo();
  GeneratedBoolColumn _constructVideo() {
    return GeneratedBoolColumn(
      'video',
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
        backdropPath,
        genres,
        homepage,
        imdbId,
        originalLanguage,
        originalTitle,
        overview,
        popularity,
        posterPath,
        productionCompanies,
        productionCountries,
        releaseDate,
        runtime,
        spokenLanguages,
        status,
        tagline,
        title,
        video,
        fecha_reg,
        externalId,
        isFavourite
      ];
  @override
  $MovieTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'movie_table';
  @override
  final String actualTableName = 'movie_table';
  @override
  VerificationContext validateIntegrity(Insertable<Movie> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('backdrop_path')) {
      context.handle(
          _backdropPathMeta,
          backdropPath.isAcceptableOrUnknown(
              data['backdrop_path'], _backdropPathMeta));
    }
    if (data.containsKey('genres')) {
      context.handle(_genresMeta,
          genres.isAcceptableOrUnknown(data['genres'], _genresMeta));
    }
    if (data.containsKey('homepage')) {
      context.handle(_homepageMeta,
          homepage.isAcceptableOrUnknown(data['homepage'], _homepageMeta));
    }
    if (data.containsKey('imdb_id')) {
      context.handle(_imdbIdMeta,
          imdbId.isAcceptableOrUnknown(data['imdb_id'], _imdbIdMeta));
    }
    if (data.containsKey('original_language')) {
      context.handle(
          _originalLanguageMeta,
          originalLanguage.isAcceptableOrUnknown(
              data['original_language'], _originalLanguageMeta));
    }
    if (data.containsKey('original_title')) {
      context.handle(
          _originalTitleMeta,
          originalTitle.isAcceptableOrUnknown(
              data['original_title'], _originalTitleMeta));
    }
    if (data.containsKey('overview')) {
      context.handle(_overviewMeta,
          overview.isAcceptableOrUnknown(data['overview'], _overviewMeta));
    }
    if (data.containsKey('popularity')) {
      context.handle(
          _popularityMeta,
          popularity.isAcceptableOrUnknown(
              data['popularity'], _popularityMeta));
    }
    if (data.containsKey('poster_path')) {
      context.handle(
          _posterPathMeta,
          posterPath.isAcceptableOrUnknown(
              data['poster_path'], _posterPathMeta));
    }
    if (data.containsKey('production_companies')) {
      context.handle(
          _productionCompaniesMeta,
          productionCompanies.isAcceptableOrUnknown(
              data['production_companies'], _productionCompaniesMeta));
    }
    if (data.containsKey('production_countries')) {
      context.handle(
          _productionCountriesMeta,
          productionCountries.isAcceptableOrUnknown(
              data['production_countries'], _productionCountriesMeta));
    }
    if (data.containsKey('release_date')) {
      context.handle(
          _releaseDateMeta,
          releaseDate.isAcceptableOrUnknown(
              data['release_date'], _releaseDateMeta));
    }
    if (data.containsKey('runtime')) {
      context.handle(_runtimeMeta,
          runtime.isAcceptableOrUnknown(data['runtime'], _runtimeMeta));
    }
    if (data.containsKey('spoken_languages')) {
      context.handle(
          _spokenLanguagesMeta,
          spokenLanguages.isAcceptableOrUnknown(
              data['spoken_languages'], _spokenLanguagesMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status'], _statusMeta));
    }
    if (data.containsKey('tagline')) {
      context.handle(_taglineMeta,
          tagline.isAcceptableOrUnknown(data['tagline'], _taglineMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    }
    if (data.containsKey('video')) {
      context.handle(
          _videoMeta, video.isAcceptableOrUnknown(data['video'], _videoMeta));
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
  Movie map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Movie.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $MovieTableTable createAlias(String alias) {
    return $MovieTableTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $LanguageTableTable _languageTable;
  $LanguageTableTable get languageTable =>
      _languageTable ??= $LanguageTableTable(this);
  $CountryTableTable _countryTable;
  $CountryTableTable get countryTable =>
      _countryTable ??= $CountryTableTable(this);
  $GenreTableTable _genreTable;
  $GenreTableTable get genreTable => _genreTable ??= $GenreTableTable(this);
  $PersonTableTable _personTable;
  $PersonTableTable get personTable => _personTable ??= $PersonTableTable(this);
  $TvShowTableTable _tvShowTable;
  $TvShowTableTable get tvShowTable => _tvShowTable ??= $TvShowTableTable(this);
  $MovieTableTable _movieTable;
  $MovieTableTable get movieTable => _movieTable ??= $MovieTableTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        languageTable,
        countryTable,
        genreTable,
        personTable,
        tvShowTable,
        movieTable
      ];
}
