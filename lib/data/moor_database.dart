import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'moor_database.g.dart';

class AudiovisualTable extends Table {
  TextColumn get id => text()();

  TextColumn get titulo => text()();

  TextColumn get originalTitle => text()();

  TextColumn get imageList => text()();

  TextColumn get tagline => text()();

  TextColumn get sinopsis => text()();

  TextColumn get category => text().nullable()();

  TextColumn get image => text().nullable()();

  TextColumn get genre => text()();

  TextColumn get anno => text().nullable()();

  TextColumn get pais => text().nullable()();

  TextColumn get score => text().nullable()();

  TextColumn get idioma => text().nullable()();

  TextColumn get director => text().nullable()();

  TextColumn get reparto => text().nullable()();

  TextColumn get productora => text().nullable()();

  TextColumn get temp => text().nullable()();

  TextColumn get duracion => text().nullable()();

  TextColumn get capitulos => text().nullable()();

  DateTimeColumn get fecha_reg => dateTime().nullable()();

  TextColumn get externalId => text().nullable()();

  BoolColumn get isFavourite => boolean().clientDefault(() => false)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'audiovisualdb';
}

class LanguageTable extends Table {
  TextColumn get iso => text()();

  TextColumn get name => text()();
}

class CountryTable extends Table {
  TextColumn get iso => text()();

  TextColumn get name => text()();
}

class GenreTable extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get type => text()();
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'database.db'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [AudiovisualTable, LanguageTable, CountryTable, GenreTable])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

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

  // MOVIE & SERIES
  Future insertAudiovisual(AudiovisualTableData data) {
    return batch((b) {
      b.insert(
          audiovisualTable,
          data.copyWith(
            fecha_reg: DateTime.now(),
          ),
          mode: InsertMode.insertOrReplace);
    });
  }

  Future<AudiovisualTableData> getAudiovisualById(String id) async {
    final country = countryTable.name;
    final language = languageTable.name;
    final data = select(audiovisualTable)
      ..where((a) => a.id.equals(id))
      ..limit(1)
      ..join([
        leftOuterJoin(
          countryTable,
          audiovisualTable.pais.equalsExp(countryTable.iso),
        ),
        leftOuterJoin(
          languageTable,
          audiovisualTable.idioma.equalsExp(languageTable.iso),
        )
      ])
      ..addColumns([country, language]).map((row) {
        final d = row.readTable(audiovisualTable).copyWith(
              idioma: row.read(language),
              pais: row.read(country) ?? '-',
            );
        return d;
      });
    return data.getSingle();
  }

  Future toggleFavouriteAudiovisual(AudiovisualTableData data) {
    return update(audiovisualTable)
        .replace(data.copyWith(isFavourite: !data.isFavourite));
  }

  Future toggleFavouriteAudiovisualById(String id) async {
    final data = await getAudiovisualById(id);
    return update(audiovisualTable)
        .replace(data.copyWith(isFavourite: !data.isFavourite));
  }

  Future toggleDateReg(AudiovisualTableData data) {
    return update(audiovisualTable)
        .replace(data.copyWith(fecha_reg: DateTime.now()));
  }

  Future cleanAudiovisualData() {
    return delete(audiovisualTable).go();
  }

//  Future<AudiovisualTableData> getAudiovisualById(String id) async {
//    var query = select(audiovisualTable);
//    query.where((a) => a.id.equals(id));
//    return await query.getSingle();
//  }

  Future<AudiovisualTableData> getAudiovisualByTitle(String title) async {
    var query = select(audiovisualTable);
    query.where((a) => a.titulo.equals(title));
    return await query.getSingle();
  }

  Future<AudiovisualTableData> getAudiovisualByExternalId(
      String trendingId) async {
    try {
      var query = select(audiovisualTable);
      query.where((a) => a.externalId.equals(trendingId));
      return await query.getSingle();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Stream<List<AudiovisualTableData>> watchDashboard() {
    SimpleSelectStatement<$AudiovisualTableTable, AudiovisualTableData> query;
    query = select(audiovisualTable)
      ..limit(10)
      ..where((tbl) => tbl.image.like('N/A').not())
      ..orderBy([
        (r) => OrderingTerm(expression: r.fecha_reg, mode: OrderingMode.desc)
      ]);
    return query.watch();
  }

  Stream<List<AudiovisualTableData>> watchFavourites() {
    SimpleSelectStatement<$AudiovisualTableTable, AudiovisualTableData> query;
    query = select(audiovisualTable)
      ..where((tbl) => tbl.isFavourite.equals(true));
    return query.watch();
  }

  Stream<List<String>> watchFavouritesId() {
    final query = selectOnly(audiovisualTable)
      ..addColumns([audiovisualTable.id])
      ..where(audiovisualTable.isFavourite.equals(true));
    return query.map((r) => r.read(audiovisualTable.id)).watch();
  }

  Future<List<AudiovisualTableData>> getAllMovies() async {
    SimpleSelectStatement<$AudiovisualTableTable, AudiovisualTableData> query;
    query = select(audiovisualTable)
      ..limit(15)
      ..where((tbl) => tbl.image.like('N/A').not())
      ..orderBy([
        (r) => OrderingTerm(expression: r.fecha_reg, mode: OrderingMode.desc)
      ]);
    return query.get();
  }

  Future getFavouritesAudiovisual(String type) async {
    var query = select(audiovisualTable);

    query.where((a) => a.category.equals(type) & a.isFavourite.equals(true));
    return query.get();
  }

  Future getFavRandomWallpaper(String type) async {
    // SELECT * FROM table ORDER BY RANDOM() LIMIT 1;
    var query =
        customSelect('select image from ${audiovisualTable.actualTableName} '
            'where ${audiovisualTable.category.escapedName} = \'$type\' '
            'and ${audiovisualTable.isFavourite.escapedName} = 1 '
            'order by RANDOM() LIMIT 1');
    final result = await query.getSingle();
    return result.data['count'];
  }

  Future<bool> isAudiovisualFav(String id) async {
    var query = select(audiovisualTable);
    query.where((a) => a.id.equals(id));
    var av = await query.getSingle();
    if (av == null) return false;
    return av.isFavourite;
  }

  Future countFavouriteMovies(String type) async {
    var query = customSelect(
        'select count(*) as count from ${audiovisualTable.actualTableName} '
        'where ${audiovisualTable.category.escapedName} = \'$type\' '
        'and ${audiovisualTable.isFavourite.escapedName} = 1');
    final result = await query.getSingle();
    return result.data['count'];
  }

  Future insertCountries(List<CountryTableData> countries) async {
    await delete(countryTable).go();
    return batch((b) =>
        b.insertAll(countryTable, countries, mode: InsertMode.insertOrReplace));
  }

  Future<bool> existCountries() async {
    final count = countryTable.iso.count();
    final query = selectOnly(countryTable)..addColumns([count]);
    final result = await query.map((row) => row.read(count)).getSingle();
    return (result ?? 0) > 0;
  }

  Future insertLanguages(List<LanguageTableData> languages) async {
    await delete(languageTable).go();
    return batch((b) => b.insertAll(languageTable, languages,
        mode: InsertMode.insertOrReplace));
  }

  Future<bool> existLanguages() async {
    final count = languageTable.iso.count();
    final query = selectOnly(languageTable)..addColumns([count]);
    final result = await query.map((row) => row.read(count)).getSingle();
    return (result ?? 0) > 0;
  }

  Future insertGenres(List<GenreTableData> genres) async {
    await delete(genreTable).go();
    return batch((b) =>
        b.insertAll(genreTable, genres, mode: InsertMode.insertOrReplace));
  }

  Future<bool> existGenres() async {
    final count = genreTable.id.count();
    final query = selectOnly(genreTable)..addColumns([count]);
    final result = await query.map((row) => row.read(count)).getSingle();
    return (result ?? 0) > 0;
  }
}
