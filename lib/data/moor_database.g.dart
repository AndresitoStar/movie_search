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
  $FavouriteTableTable _favouriteTable;
  $FavouriteTableTable get favouriteTable =>
      _favouriteTable ??= $FavouriteTableTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [genreTable, favouriteTable];
}
