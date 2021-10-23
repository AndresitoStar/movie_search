import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'moor_database.g.dart';

typedef T FromJsonFunction<T>(String json);

class GenreTable extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get type => text()();
}

@DataClassName("Person")
class PersonTable extends Table {
  IntColumn get id => integer()();

  TextColumn get birthday => text().nullable()();

  TextColumn get knownForDepartment => text().nullable()();

  TextColumn get deathday => text().nullable()();

  TextColumn get name => text().nullable()();

  IntColumn get gender => integer().nullable()();

  TextColumn get biography => text().nullable()();

  RealColumn get popularity => real().nullable()();

  TextColumn get placeOfBirth => text().nullable()();

  TextColumn get profilePath => text().nullable()();

  TextColumn get imdbId => text().nullable()();

  TextColumn get character => text().nullable()();

  DateTimeColumn get fecha_reg => dateTime().nullable()();

  TextColumn get externalId => text().nullable()();

  BoolColumn get isFavourite => boolean().clientDefault(() => false)();

  Set<Column> get primaryKey => {id};
}

@DataClassName('Favourite')
class FavouriteTable extends Table {
  IntColumn get id => integer()();

  TextColumn get type => text()();

  TextColumn get json => text()();
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // if (kIsWeb) {
    //   return WebDatabase('file');
    // }
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'database.db'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [
  GenreTable,
  PersonTable,
  FavouriteTable,
])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) {
        return m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        for (final table in allTables.toList().reversed) {
          await m.deleteTable(table.actualTableName);
        }
        return m.createAll();
      },
    );
  }

  //region Person
  Future<Person> getPersonById(int id) async {
    return (select(personTable)..where((m) => m.id.equals(id))).getSingleOrNull();
  }

  Future insertPerson(Person data) {
    return batch((b) {
      b.insert(
          personTable,
          data.copyWith(
            fecha_reg: DateTime.now(),
          ),
          mode: InsertMode.insertOrReplace);
    });
  }

  Future insertFavourite(int id, String type, String jsonData) {
    return batch((b) {
      b.insert(favouriteTable, Favourite(id: id, type: type, json: jsonData), mode: InsertMode.insertOrReplace);
    });
  }

  Stream<List<int>> watchFavouritesPersonId() {
    final query = selectOnly(personTable)
      ..addColumns([personTable.id])
      ..where(personTable.isFavourite.equals(true));
    return query.map((r) => r.read(personTable.id)).watch();
  }

  Stream<List<int>> watchFavouritesId(String type) {
    final query = selectOnly(favouriteTable)..addColumns([favouriteTable.id]);
    return query.map((r) => r.read(favouriteTable.id)).watch();
  }

  Future toggleFavouritePerson(int id) async {
    final data = await getPersonById(id);
    return update(personTable).replace(data.copyWith(isFavourite: !data.isFavourite));
  }

  Future removeFavourite(int id) async {
    return delete(favouriteTable)
      ..where((tbl) => tbl.id.equals(id))
      ..go();
  }

  Stream<List<Person>> watchFavouritesPerson() {
    final query = select(personTable)..where((m) => m.isFavourite);
    return query.watch();
  }

  Stream<List<T>> watchFavourites<T>(String type, FromJsonFunction<T> fromJsonFunction) {
    final query = select(favouriteTable)..where((m) => m.type.equals(type));
    return query.map((e) => fromJsonFunction(e.json)).watch();
  }

  //endregion

  //region Genres
  Future insertGenres(List<GenreTableData> genres) async {
    await delete(genreTable).go();
    return batch((b) => b.insertAll(genreTable, genres, mode: InsertMode.insertOrReplace));
  }

  Future<bool> existGenres(String type) async {
    final count = genreTable.id.count();
    final query = selectOnly(genreTable)
      ..addColumns([count])
      ..where(genreTable.type.equals(type));
    final result = await query.map((row) => row.read(count)).getSingleOrNull();
    return (result ?? 0) > 0;
  }

  Future<List<GenreTableData>> allGenres(String type) {
    final query = select(genreTable)..where((m) => m.type.equals(type));
    return query.get();
  }
//endregion

}
