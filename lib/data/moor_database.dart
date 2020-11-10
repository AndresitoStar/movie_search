import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'moor_database.g.dart';

class AudiovisualTable extends Table {
  TextColumn get id => text()();

  TextColumn get titulo => text()();

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

class GameTable extends Table {
  TextColumn get id => text()();

  TextColumn get titulo => text()();

  TextColumn get sinopsis => text()();

  TextColumn get category => text().nullable()();

  TextColumn get image => text().nullable()();

  TextColumn get genre => text()();

  TextColumn get plataformas => text()();

  DateTimeColumn get fechaLanzamiento => dateTime().nullable()();

  TextColumn get score => text().nullable()();

  TextColumn get empresa => text().nullable()();

  TextColumn get fecha_reg => text().nullable()();

  TextColumn get fecha_act => text().nullable()();

  BoolColumn get isFavourite => boolean().clientDefault(() => false)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'game';
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

@UseMoor(tables: [AudiovisualTable, GameTable])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // MOVIE & SERIES
  Future insertAudiovisual(AudiovisualTableData data) {
    return batch((b) {
      b.insert(audiovisualTable, data.copyWith(fecha_reg: DateTime.now()),
          mode: InsertMode.insertOrReplace);
    });
  }

  Future updateAudiovisual(AudiovisualTableData data) {
    update(audiovisualTable).replace(data);
  }

  Future<AudiovisualTableData> getAudiovisualById(String id) async {
    var query = select(audiovisualTable);
    query.where((a) => a.id.equals(id));
    return await query.getSingle();
  }

  Future<AudiovisualTableData> getAudiovisualByTitle(String title) async {
    var query = select(audiovisualTable);
    query.where((a) => a.titulo.equals(title));
    return await query.getSingle();
  }

  Future<AudiovisualTableData> getAudiovisualByExternalId(String trendingId) async {
    try {
      var query = select(audiovisualTable);
      query.where((a) => a.externalId.equals(trendingId));
      return await query.getSingle();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<AudiovisualTableData>> getAllMovies() async {
    SimpleSelectStatement<$AudiovisualTableTable, AudiovisualTableData> query;
    query = select(audiovisualTable)..limit(15)
      ..where((tbl) => tbl.image.like('N/A').not())
      ..orderBy([(r) => OrderingTerm(expression: r.fecha_reg, mode: OrderingMode.desc)])
        ;
    return query.get();
  }

  Future getFavouritesAudiovisual(String type) async {
    var query = select(audiovisualTable);

    query.where((a) => a.category.equals(type) & a.isFavourite.equals(true));
    return query.get();
  }

  Future getFavRandomWallpaper(String type) async {
    // SELECT * FROM table ORDER BY RANDOM() LIMIT 1;
    var query = customSelect('select image from ${audiovisualTable.actualTableName} '
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
    var query = customSelect('select count(*) as count from ${audiovisualTable.actualTableName} '
            'where ${audiovisualTable.category.escapedName} = \'$type\' '
            'and ${audiovisualTable.isFavourite.escapedName} = 1');
    final result = await query.getSingle();
    return result.data['count'];
  }

  // GAMES
  Future insertGame(GameTableData data) {
    return batch((b) {
      b.insert(gameTable, data, mode: InsertMode.insertOrReplace);
    });
  }

  Future getGameById(String id) async {
    var query = select(gameTable);
    query.where((a) => a.id.equals(id));
    return await query.getSingle();
  }

  Future updateGame(GameTableData data) {
    update(gameTable).replace(data);
  }

  Future getFavouritesGames() async {
    var query = select(gameTable);
    query.where((a) => a.isFavourite.equals(true));
    return query.get();
  }

  Future countFavouriteGames() async {
    var query = customSelect('select count(*) as count from ${gameTable.actualTableName} '
        'where ${gameTable.isFavourite.escapedName} = 1');
    final result = await query.getSingle();
    return result.data['count'];
  }
}
