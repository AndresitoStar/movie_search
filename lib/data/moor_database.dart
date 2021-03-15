import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'moor_database.g.dart';

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

@DataClassName("Movie")
class MovieTable extends Table {
  IntColumn get id => integer()();

  TextColumn get backdropPath => text().nullable()();

  TextColumn get genres => text().nullable()();

  TextColumn get homepage => text().nullable()();

  TextColumn get imdbId => text().nullable()();

  TextColumn get originalLanguage => text().nullable()();

  TextColumn get originalTitle => text().nullable()();

  TextColumn get overview => text().nullable()();

  RealColumn get popularity => real().nullable()();

  TextColumn get posterPath => text().nullable()();

  TextColumn get productionCompanies => text().nullable()();

  TextColumn get productionCountries => text().nullable()();

  TextColumn get releaseDate => text().nullable()();

  RealColumn get runtime => real().nullable()();

  TextColumn get spokenLanguages => text().nullable()();

  TextColumn get status => text().nullable()();

  TextColumn get tagline => text().nullable()();

  TextColumn get title => text().nullable()();

  BoolColumn get video => boolean().nullable()();

  DateTimeColumn get fecha_reg => dateTime().nullable()();

  TextColumn get externalId => text().nullable()();

  BoolColumn get isFavourite => boolean().clientDefault(() => false)();

  Set<Column> get primaryKey => {id};
}

@DataClassName("TvShow")
class TvShowTable extends Table {
  IntColumn get id => integer()();

  TextColumn get backdropPath => text().nullable()();

  TextColumn get createdBy => text().nullable()();

  IntColumn get episodeRunTime => integer().nullable()();

  TextColumn get firstAirDate => text().nullable()();

  TextColumn get genres => text().nullable()();

  TextColumn get languages => text().nullable()();

  TextColumn get name => text().nullable()();

  IntColumn get numberOfEpisodes => integer().nullable()();

  IntColumn get numberOfSeasons => integer().nullable()();

  TextColumn get originCountry => text().nullable()();

  TextColumn get originalLanguage => text().nullable()();

  TextColumn get originalName => text().nullable()();

  TextColumn get overview => text().nullable()();

  RealColumn get popularity => real().nullable()();

  TextColumn get posterPath => text().nullable()();

  TextColumn get productionCountries => text().nullable()();

  TextColumn get productionCompanies => text().nullable()();

  TextColumn get spokenLanguages => text().nullable()();

  TextColumn get status => text().nullable()();

  TextColumn get tagline => text().nullable()();

  TextColumn get type => text().nullable()();

  DateTimeColumn get fecha_reg => dateTime().nullable()();

  TextColumn get externalId => text().nullable()();

  BoolColumn get isFavourite => boolean().clientDefault(() => false)();

  Set<Column> get primaryKey => {id};
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

@UseMoor(tables: [
  LanguageTable,
  CountryTable,
  GenreTable,
  PersonTable,
  TvShowTable,
  MovieTable,
])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 5;

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

  //region Movie
  Future<Movie> getMovieById(int id) async {
    return (select(movieTable)..where((m) => m.id.equals(id))).getSingleOrNull();
  }

  Future insertMovie(Movie data) {
    return batch((b) {
      b.insert(movieTable, data.copyWith(fecha_reg: DateTime.now()),
          mode: InsertMode.insertOrReplace);
    });
  }

  Stream<List<int>> watchFavouritesMovieId() {
    final query = selectOnly(movieTable)
      ..addColumns([movieTable.id])
      ..where(movieTable.isFavourite.equals(true));
    return query.map((r) => r.read(movieTable.id)).watch();
  }

  Stream<List<Movie>> watchFavouritesMovie() {
    final query = select(movieTable)..where((m) => m.isFavourite);
    return query.watch();
  }

  Future toggleFavouriteMovie(int id) async {
    final data = await getMovieById(id);
    return update(movieTable)
        .replace(data.copyWith(isFavourite: !data.isFavourite));
  }

  //endregion

  //region Tv Show
  Future<TvShow> getTvShowById(int id) async {
    return (select(tvShowTable)
          ..where((m) => m.id.equals(id))
          ..limit(1))
        .getSingleOrNull();
  }

  Future insertTvShow(TvShow data) {
    return batch((b) {
      b.insert(
          tvShowTable,
          data.copyWith(
            fecha_reg: DateTime.now(),
          ),
          mode: InsertMode.insertOrReplace);
    });
  }

  Stream<List<int>> watchFavouritesTvShowId() {
    final query = selectOnly(tvShowTable)
      ..addColumns([tvShowTable.id])
      ..where(tvShowTable.isFavourite.equals(true));
    return query.map((r) => r.read(tvShowTable.id)).watch();
  }

  Future toggleFavouriteTvShow(int id) async {
    final data = await getTvShowById(id);
    return update(tvShowTable)
        .replace(data.copyWith(isFavourite: !data.isFavourite));
  }

  Stream<List<TvShow>> watchFavouritesTvShow() {
    final query = select(tvShowTable)..where((m) => m.isFavourite);
    return query.watch();
  }

  //endregion

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

  Stream<List<int>> watchFavouritesPersonId() {
    final query = selectOnly(personTable)
      ..addColumns([personTable.id])
      ..where(personTable.isFavourite.equals(true));
    return query.map((r) => r.read(personTable.id)).watch();
  }

  Future toggleFavouritePerson(int id) async {
    final data = await getPersonById(id);
    return update(personTable)
        .replace(data.copyWith(isFavourite: !data.isFavourite));
  }

  Stream<List<Person>> watchFavouritesPerson() {
    final query = select(personTable)..where((m) => m.isFavourite);
    return query.watch();
  }

  //endregion

  //region Countries
  Future insertCountries(List<CountryTableData> countries) async {
    await delete(countryTable).go();
    return batch((b) =>
        b.insertAll(countryTable, countries, mode: InsertMode.insertOrReplace));
  }

  Future<bool> existCountries() async {
    final count = countryTable.iso.count();
    final query = selectOnly(countryTable)..addColumns([count]);
    final result = await query.map((row) => row.read(count)).getSingleOrNull();
    return (result ?? 0) > 0;
  }

  //endregion

  //region Languages
  Future insertLanguages(List<LanguageTableData> languages) async {
    await delete(languageTable).go();
    return batch((b) => b.insertAll(languageTable, languages,
        mode: InsertMode.insertOrReplace));
  }

  Future<bool> existLanguages() async {
    final count = languageTable.iso.count();
    final query = selectOnly(languageTable)..addColumns([count]);
    final result = await query.map((row) => row.read(count)).getSingleOrNull();
    return (result ?? 0) > 0;
  }

  //endregion

  //region Genres
  Future insertGenres(List<GenreTableData> genres) async {
    await delete(genreTable).go();
    return batch((b) =>
        b.insertAll(genreTable, genres, mode: InsertMode.insertOrReplace));
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
