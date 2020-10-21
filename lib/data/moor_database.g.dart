// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class AudiovisualTableData extends DataClass
    implements Insertable<AudiovisualTableData> {
  final String id;
  final String titulo;
  final String sinopsis;
  final String category;
  final String image;
  final String genre;
  final String anno;
  final String pais;
  final String score;
  final String idioma;
  final String director;
  final String reparto;
  final String productora;
  final String temp;
  final String duracion;
  final String capitulos;
  final DateTime fecha_reg;
  final String externalId;
  final bool isFavourite;
  AudiovisualTableData(
      {@required this.id,
      @required this.titulo,
      @required this.sinopsis,
      this.category,
      this.image,
      @required this.genre,
      this.anno,
      this.pais,
      this.score,
      this.idioma,
      this.director,
      this.reparto,
      this.productora,
      this.temp,
      this.duracion,
      this.capitulos,
      this.fecha_reg,
      this.externalId,
      @required this.isFavourite});
  factory AudiovisualTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return AudiovisualTableData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      titulo:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}titulo']),
      sinopsis: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}sinopsis']),
      category: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}category']),
      image:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}image']),
      genre:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}genre']),
      anno: stringType.mapFromDatabaseResponse(data['${effectivePrefix}anno']),
      pais: stringType.mapFromDatabaseResponse(data['${effectivePrefix}pais']),
      score:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}score']),
      idioma:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}idioma']),
      director: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}director']),
      reparto:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}reparto']),
      productora: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}productora']),
      temp: stringType.mapFromDatabaseResponse(data['${effectivePrefix}temp']),
      duracion: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}duracion']),
      capitulos: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}capitulos']),
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
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || titulo != null) {
      map['titulo'] = Variable<String>(titulo);
    }
    if (!nullToAbsent || sinopsis != null) {
      map['sinopsis'] = Variable<String>(sinopsis);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    if (!nullToAbsent || genre != null) {
      map['genre'] = Variable<String>(genre);
    }
    if (!nullToAbsent || anno != null) {
      map['anno'] = Variable<String>(anno);
    }
    if (!nullToAbsent || pais != null) {
      map['pais'] = Variable<String>(pais);
    }
    if (!nullToAbsent || score != null) {
      map['score'] = Variable<String>(score);
    }
    if (!nullToAbsent || idioma != null) {
      map['idioma'] = Variable<String>(idioma);
    }
    if (!nullToAbsent || director != null) {
      map['director'] = Variable<String>(director);
    }
    if (!nullToAbsent || reparto != null) {
      map['reparto'] = Variable<String>(reparto);
    }
    if (!nullToAbsent || productora != null) {
      map['productora'] = Variable<String>(productora);
    }
    if (!nullToAbsent || temp != null) {
      map['temp'] = Variable<String>(temp);
    }
    if (!nullToAbsent || duracion != null) {
      map['duracion'] = Variable<String>(duracion);
    }
    if (!nullToAbsent || capitulos != null) {
      map['capitulos'] = Variable<String>(capitulos);
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

  AudiovisualTableCompanion toCompanion(bool nullToAbsent) {
    return AudiovisualTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      titulo:
          titulo == null && nullToAbsent ? const Value.absent() : Value(titulo),
      sinopsis: sinopsis == null && nullToAbsent
          ? const Value.absent()
          : Value(sinopsis),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      genre:
          genre == null && nullToAbsent ? const Value.absent() : Value(genre),
      anno: anno == null && nullToAbsent ? const Value.absent() : Value(anno),
      pais: pais == null && nullToAbsent ? const Value.absent() : Value(pais),
      score:
          score == null && nullToAbsent ? const Value.absent() : Value(score),
      idioma:
          idioma == null && nullToAbsent ? const Value.absent() : Value(idioma),
      director: director == null && nullToAbsent
          ? const Value.absent()
          : Value(director),
      reparto: reparto == null && nullToAbsent
          ? const Value.absent()
          : Value(reparto),
      productora: productora == null && nullToAbsent
          ? const Value.absent()
          : Value(productora),
      temp: temp == null && nullToAbsent ? const Value.absent() : Value(temp),
      duracion: duracion == null && nullToAbsent
          ? const Value.absent()
          : Value(duracion),
      capitulos: capitulos == null && nullToAbsent
          ? const Value.absent()
          : Value(capitulos),
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

  factory AudiovisualTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return AudiovisualTableData(
      id: serializer.fromJson<String>(json['id']),
      titulo: serializer.fromJson<String>(json['titulo']),
      sinopsis: serializer.fromJson<String>(json['sinopsis']),
      category: serializer.fromJson<String>(json['category']),
      image: serializer.fromJson<String>(json['image']),
      genre: serializer.fromJson<String>(json['genre']),
      anno: serializer.fromJson<String>(json['anno']),
      pais: serializer.fromJson<String>(json['pais']),
      score: serializer.fromJson<String>(json['score']),
      idioma: serializer.fromJson<String>(json['idioma']),
      director: serializer.fromJson<String>(json['director']),
      reparto: serializer.fromJson<String>(json['reparto']),
      productora: serializer.fromJson<String>(json['productora']),
      temp: serializer.fromJson<String>(json['temp']),
      duracion: serializer.fromJson<String>(json['duracion']),
      capitulos: serializer.fromJson<String>(json['capitulos']),
      fecha_reg: serializer.fromJson<DateTime>(json['fecha_reg']),
      externalId: serializer.fromJson<String>(json['externalId']),
      isFavourite: serializer.fromJson<bool>(json['isFavourite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'titulo': serializer.toJson<String>(titulo),
      'sinopsis': serializer.toJson<String>(sinopsis),
      'category': serializer.toJson<String>(category),
      'image': serializer.toJson<String>(image),
      'genre': serializer.toJson<String>(genre),
      'anno': serializer.toJson<String>(anno),
      'pais': serializer.toJson<String>(pais),
      'score': serializer.toJson<String>(score),
      'idioma': serializer.toJson<String>(idioma),
      'director': serializer.toJson<String>(director),
      'reparto': serializer.toJson<String>(reparto),
      'productora': serializer.toJson<String>(productora),
      'temp': serializer.toJson<String>(temp),
      'duracion': serializer.toJson<String>(duracion),
      'capitulos': serializer.toJson<String>(capitulos),
      'fecha_reg': serializer.toJson<DateTime>(fecha_reg),
      'externalId': serializer.toJson<String>(externalId),
      'isFavourite': serializer.toJson<bool>(isFavourite),
    };
  }

  AudiovisualTableData copyWith(
          {String id,
          String titulo,
          String sinopsis,
          String category,
          String image,
          String genre,
          String anno,
          String pais,
          String score,
          String idioma,
          String director,
          String reparto,
          String productora,
          String temp,
          String duracion,
          String capitulos,
          DateTime fecha_reg,
          String externalId,
          bool isFavourite}) =>
      AudiovisualTableData(
        id: id ?? this.id,
        titulo: titulo ?? this.titulo,
        sinopsis: sinopsis ?? this.sinopsis,
        category: category ?? this.category,
        image: image ?? this.image,
        genre: genre ?? this.genre,
        anno: anno ?? this.anno,
        pais: pais ?? this.pais,
        score: score ?? this.score,
        idioma: idioma ?? this.idioma,
        director: director ?? this.director,
        reparto: reparto ?? this.reparto,
        productora: productora ?? this.productora,
        temp: temp ?? this.temp,
        duracion: duracion ?? this.duracion,
        capitulos: capitulos ?? this.capitulos,
        fecha_reg: fecha_reg ?? this.fecha_reg,
        externalId: externalId ?? this.externalId,
        isFavourite: isFavourite ?? this.isFavourite,
      );
  @override
  String toString() {
    return (StringBuffer('AudiovisualTableData(')
          ..write('id: $id, ')
          ..write('titulo: $titulo, ')
          ..write('sinopsis: $sinopsis, ')
          ..write('category: $category, ')
          ..write('image: $image, ')
          ..write('genre: $genre, ')
          ..write('anno: $anno, ')
          ..write('pais: $pais, ')
          ..write('score: $score, ')
          ..write('idioma: $idioma, ')
          ..write('director: $director, ')
          ..write('reparto: $reparto, ')
          ..write('productora: $productora, ')
          ..write('temp: $temp, ')
          ..write('duracion: $duracion, ')
          ..write('capitulos: $capitulos, ')
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
          titulo.hashCode,
          $mrjc(
              sinopsis.hashCode,
              $mrjc(
                  category.hashCode,
                  $mrjc(
                      image.hashCode,
                      $mrjc(
                          genre.hashCode,
                          $mrjc(
                              anno.hashCode,
                              $mrjc(
                                  pais.hashCode,
                                  $mrjc(
                                      score.hashCode,
                                      $mrjc(
                                          idioma.hashCode,
                                          $mrjc(
                                              director.hashCode,
                                              $mrjc(
                                                  reparto.hashCode,
                                                  $mrjc(
                                                      productora.hashCode,
                                                      $mrjc(
                                                          temp.hashCode,
                                                          $mrjc(
                                                              duracion.hashCode,
                                                              $mrjc(
                                                                  capitulos
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      fecha_reg
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          externalId
                                                                              .hashCode,
                                                                          isFavourite
                                                                              .hashCode)))))))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is AudiovisualTableData &&
          other.id == this.id &&
          other.titulo == this.titulo &&
          other.sinopsis == this.sinopsis &&
          other.category == this.category &&
          other.image == this.image &&
          other.genre == this.genre &&
          other.anno == this.anno &&
          other.pais == this.pais &&
          other.score == this.score &&
          other.idioma == this.idioma &&
          other.director == this.director &&
          other.reparto == this.reparto &&
          other.productora == this.productora &&
          other.temp == this.temp &&
          other.duracion == this.duracion &&
          other.capitulos == this.capitulos &&
          other.fecha_reg == this.fecha_reg &&
          other.externalId == this.externalId &&
          other.isFavourite == this.isFavourite);
}

class AudiovisualTableCompanion extends UpdateCompanion<AudiovisualTableData> {
  final Value<String> id;
  final Value<String> titulo;
  final Value<String> sinopsis;
  final Value<String> category;
  final Value<String> image;
  final Value<String> genre;
  final Value<String> anno;
  final Value<String> pais;
  final Value<String> score;
  final Value<String> idioma;
  final Value<String> director;
  final Value<String> reparto;
  final Value<String> productora;
  final Value<String> temp;
  final Value<String> duracion;
  final Value<String> capitulos;
  final Value<DateTime> fecha_reg;
  final Value<String> externalId;
  final Value<bool> isFavourite;
  const AudiovisualTableCompanion({
    this.id = const Value.absent(),
    this.titulo = const Value.absent(),
    this.sinopsis = const Value.absent(),
    this.category = const Value.absent(),
    this.image = const Value.absent(),
    this.genre = const Value.absent(),
    this.anno = const Value.absent(),
    this.pais = const Value.absent(),
    this.score = const Value.absent(),
    this.idioma = const Value.absent(),
    this.director = const Value.absent(),
    this.reparto = const Value.absent(),
    this.productora = const Value.absent(),
    this.temp = const Value.absent(),
    this.duracion = const Value.absent(),
    this.capitulos = const Value.absent(),
    this.fecha_reg = const Value.absent(),
    this.externalId = const Value.absent(),
    this.isFavourite = const Value.absent(),
  });
  AudiovisualTableCompanion.insert({
    @required String id,
    @required String titulo,
    @required String sinopsis,
    this.category = const Value.absent(),
    this.image = const Value.absent(),
    @required String genre,
    this.anno = const Value.absent(),
    this.pais = const Value.absent(),
    this.score = const Value.absent(),
    this.idioma = const Value.absent(),
    this.director = const Value.absent(),
    this.reparto = const Value.absent(),
    this.productora = const Value.absent(),
    this.temp = const Value.absent(),
    this.duracion = const Value.absent(),
    this.capitulos = const Value.absent(),
    this.fecha_reg = const Value.absent(),
    this.externalId = const Value.absent(),
    this.isFavourite = const Value.absent(),
  })  : id = Value(id),
        titulo = Value(titulo),
        sinopsis = Value(sinopsis),
        genre = Value(genre);
  static Insertable<AudiovisualTableData> custom({
    Expression<String> id,
    Expression<String> titulo,
    Expression<String> sinopsis,
    Expression<String> category,
    Expression<String> image,
    Expression<String> genre,
    Expression<String> anno,
    Expression<String> pais,
    Expression<String> score,
    Expression<String> idioma,
    Expression<String> director,
    Expression<String> reparto,
    Expression<String> productora,
    Expression<String> temp,
    Expression<String> duracion,
    Expression<String> capitulos,
    Expression<DateTime> fecha_reg,
    Expression<String> externalId,
    Expression<bool> isFavourite,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (titulo != null) 'titulo': titulo,
      if (sinopsis != null) 'sinopsis': sinopsis,
      if (category != null) 'category': category,
      if (image != null) 'image': image,
      if (genre != null) 'genre': genre,
      if (anno != null) 'anno': anno,
      if (pais != null) 'pais': pais,
      if (score != null) 'score': score,
      if (idioma != null) 'idioma': idioma,
      if (director != null) 'director': director,
      if (reparto != null) 'reparto': reparto,
      if (productora != null) 'productora': productora,
      if (temp != null) 'temp': temp,
      if (duracion != null) 'duracion': duracion,
      if (capitulos != null) 'capitulos': capitulos,
      if (fecha_reg != null) 'fecha_reg': fecha_reg,
      if (externalId != null) 'external_id': externalId,
      if (isFavourite != null) 'is_favourite': isFavourite,
    });
  }

  AudiovisualTableCompanion copyWith(
      {Value<String> id,
      Value<String> titulo,
      Value<String> sinopsis,
      Value<String> category,
      Value<String> image,
      Value<String> genre,
      Value<String> anno,
      Value<String> pais,
      Value<String> score,
      Value<String> idioma,
      Value<String> director,
      Value<String> reparto,
      Value<String> productora,
      Value<String> temp,
      Value<String> duracion,
      Value<String> capitulos,
      Value<DateTime> fecha_reg,
      Value<String> externalId,
      Value<bool> isFavourite}) {
    return AudiovisualTableCompanion(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      sinopsis: sinopsis ?? this.sinopsis,
      category: category ?? this.category,
      image: image ?? this.image,
      genre: genre ?? this.genre,
      anno: anno ?? this.anno,
      pais: pais ?? this.pais,
      score: score ?? this.score,
      idioma: idioma ?? this.idioma,
      director: director ?? this.director,
      reparto: reparto ?? this.reparto,
      productora: productora ?? this.productora,
      temp: temp ?? this.temp,
      duracion: duracion ?? this.duracion,
      capitulos: capitulos ?? this.capitulos,
      fecha_reg: fecha_reg ?? this.fecha_reg,
      externalId: externalId ?? this.externalId,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (titulo.present) {
      map['titulo'] = Variable<String>(titulo.value);
    }
    if (sinopsis.present) {
      map['sinopsis'] = Variable<String>(sinopsis.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (genre.present) {
      map['genre'] = Variable<String>(genre.value);
    }
    if (anno.present) {
      map['anno'] = Variable<String>(anno.value);
    }
    if (pais.present) {
      map['pais'] = Variable<String>(pais.value);
    }
    if (score.present) {
      map['score'] = Variable<String>(score.value);
    }
    if (idioma.present) {
      map['idioma'] = Variable<String>(idioma.value);
    }
    if (director.present) {
      map['director'] = Variable<String>(director.value);
    }
    if (reparto.present) {
      map['reparto'] = Variable<String>(reparto.value);
    }
    if (productora.present) {
      map['productora'] = Variable<String>(productora.value);
    }
    if (temp.present) {
      map['temp'] = Variable<String>(temp.value);
    }
    if (duracion.present) {
      map['duracion'] = Variable<String>(duracion.value);
    }
    if (capitulos.present) {
      map['capitulos'] = Variable<String>(capitulos.value);
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
    return (StringBuffer('AudiovisualTableCompanion(')
          ..write('id: $id, ')
          ..write('titulo: $titulo, ')
          ..write('sinopsis: $sinopsis, ')
          ..write('category: $category, ')
          ..write('image: $image, ')
          ..write('genre: $genre, ')
          ..write('anno: $anno, ')
          ..write('pais: $pais, ')
          ..write('score: $score, ')
          ..write('idioma: $idioma, ')
          ..write('director: $director, ')
          ..write('reparto: $reparto, ')
          ..write('productora: $productora, ')
          ..write('temp: $temp, ')
          ..write('duracion: $duracion, ')
          ..write('capitulos: $capitulos, ')
          ..write('fecha_reg: $fecha_reg, ')
          ..write('externalId: $externalId, ')
          ..write('isFavourite: $isFavourite')
          ..write(')'))
        .toString();
  }
}

class $AudiovisualTableTable extends AudiovisualTable
    with TableInfo<$AudiovisualTableTable, AudiovisualTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $AudiovisualTableTable(this._db, [this._alias]);
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

  final VerificationMeta _tituloMeta = const VerificationMeta('titulo');
  GeneratedTextColumn _titulo;
  @override
  GeneratedTextColumn get titulo => _titulo ??= _constructTitulo();
  GeneratedTextColumn _constructTitulo() {
    return GeneratedTextColumn(
      'titulo',
      $tableName,
      false,
    );
  }

  final VerificationMeta _sinopsisMeta = const VerificationMeta('sinopsis');
  GeneratedTextColumn _sinopsis;
  @override
  GeneratedTextColumn get sinopsis => _sinopsis ??= _constructSinopsis();
  GeneratedTextColumn _constructSinopsis() {
    return GeneratedTextColumn(
      'sinopsis',
      $tableName,
      false,
    );
  }

  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  GeneratedTextColumn _category;
  @override
  GeneratedTextColumn get category => _category ??= _constructCategory();
  GeneratedTextColumn _constructCategory() {
    return GeneratedTextColumn(
      'category',
      $tableName,
      true,
    );
  }

  final VerificationMeta _imageMeta = const VerificationMeta('image');
  GeneratedTextColumn _image;
  @override
  GeneratedTextColumn get image => _image ??= _constructImage();
  GeneratedTextColumn _constructImage() {
    return GeneratedTextColumn(
      'image',
      $tableName,
      true,
    );
  }

  final VerificationMeta _genreMeta = const VerificationMeta('genre');
  GeneratedTextColumn _genre;
  @override
  GeneratedTextColumn get genre => _genre ??= _constructGenre();
  GeneratedTextColumn _constructGenre() {
    return GeneratedTextColumn(
      'genre',
      $tableName,
      false,
    );
  }

  final VerificationMeta _annoMeta = const VerificationMeta('anno');
  GeneratedTextColumn _anno;
  @override
  GeneratedTextColumn get anno => _anno ??= _constructAnno();
  GeneratedTextColumn _constructAnno() {
    return GeneratedTextColumn(
      'anno',
      $tableName,
      true,
    );
  }

  final VerificationMeta _paisMeta = const VerificationMeta('pais');
  GeneratedTextColumn _pais;
  @override
  GeneratedTextColumn get pais => _pais ??= _constructPais();
  GeneratedTextColumn _constructPais() {
    return GeneratedTextColumn(
      'pais',
      $tableName,
      true,
    );
  }

  final VerificationMeta _scoreMeta = const VerificationMeta('score');
  GeneratedTextColumn _score;
  @override
  GeneratedTextColumn get score => _score ??= _constructScore();
  GeneratedTextColumn _constructScore() {
    return GeneratedTextColumn(
      'score',
      $tableName,
      true,
    );
  }

  final VerificationMeta _idiomaMeta = const VerificationMeta('idioma');
  GeneratedTextColumn _idioma;
  @override
  GeneratedTextColumn get idioma => _idioma ??= _constructIdioma();
  GeneratedTextColumn _constructIdioma() {
    return GeneratedTextColumn(
      'idioma',
      $tableName,
      true,
    );
  }

  final VerificationMeta _directorMeta = const VerificationMeta('director');
  GeneratedTextColumn _director;
  @override
  GeneratedTextColumn get director => _director ??= _constructDirector();
  GeneratedTextColumn _constructDirector() {
    return GeneratedTextColumn(
      'director',
      $tableName,
      true,
    );
  }

  final VerificationMeta _repartoMeta = const VerificationMeta('reparto');
  GeneratedTextColumn _reparto;
  @override
  GeneratedTextColumn get reparto => _reparto ??= _constructReparto();
  GeneratedTextColumn _constructReparto() {
    return GeneratedTextColumn(
      'reparto',
      $tableName,
      true,
    );
  }

  final VerificationMeta _productoraMeta = const VerificationMeta('productora');
  GeneratedTextColumn _productora;
  @override
  GeneratedTextColumn get productora => _productora ??= _constructProductora();
  GeneratedTextColumn _constructProductora() {
    return GeneratedTextColumn(
      'productora',
      $tableName,
      true,
    );
  }

  final VerificationMeta _tempMeta = const VerificationMeta('temp');
  GeneratedTextColumn _temp;
  @override
  GeneratedTextColumn get temp => _temp ??= _constructTemp();
  GeneratedTextColumn _constructTemp() {
    return GeneratedTextColumn(
      'temp',
      $tableName,
      true,
    );
  }

  final VerificationMeta _duracionMeta = const VerificationMeta('duracion');
  GeneratedTextColumn _duracion;
  @override
  GeneratedTextColumn get duracion => _duracion ??= _constructDuracion();
  GeneratedTextColumn _constructDuracion() {
    return GeneratedTextColumn(
      'duracion',
      $tableName,
      true,
    );
  }

  final VerificationMeta _capitulosMeta = const VerificationMeta('capitulos');
  GeneratedTextColumn _capitulos;
  @override
  GeneratedTextColumn get capitulos => _capitulos ??= _constructCapitulos();
  GeneratedTextColumn _constructCapitulos() {
    return GeneratedTextColumn(
      'capitulos',
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
        titulo,
        sinopsis,
        category,
        image,
        genre,
        anno,
        pais,
        score,
        idioma,
        director,
        reparto,
        productora,
        temp,
        duracion,
        capitulos,
        fecha_reg,
        externalId,
        isFavourite
      ];
  @override
  $AudiovisualTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'audiovisualdb';
  @override
  final String actualTableName = 'audiovisualdb';
  @override
  VerificationContext validateIntegrity(
      Insertable<AudiovisualTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('titulo')) {
      context.handle(_tituloMeta,
          titulo.isAcceptableOrUnknown(data['titulo'], _tituloMeta));
    } else if (isInserting) {
      context.missing(_tituloMeta);
    }
    if (data.containsKey('sinopsis')) {
      context.handle(_sinopsisMeta,
          sinopsis.isAcceptableOrUnknown(data['sinopsis'], _sinopsisMeta));
    } else if (isInserting) {
      context.missing(_sinopsisMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category'], _categoryMeta));
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image'], _imageMeta));
    }
    if (data.containsKey('genre')) {
      context.handle(
          _genreMeta, genre.isAcceptableOrUnknown(data['genre'], _genreMeta));
    } else if (isInserting) {
      context.missing(_genreMeta);
    }
    if (data.containsKey('anno')) {
      context.handle(
          _annoMeta, anno.isAcceptableOrUnknown(data['anno'], _annoMeta));
    }
    if (data.containsKey('pais')) {
      context.handle(
          _paisMeta, pais.isAcceptableOrUnknown(data['pais'], _paisMeta));
    }
    if (data.containsKey('score')) {
      context.handle(
          _scoreMeta, score.isAcceptableOrUnknown(data['score'], _scoreMeta));
    }
    if (data.containsKey('idioma')) {
      context.handle(_idiomaMeta,
          idioma.isAcceptableOrUnknown(data['idioma'], _idiomaMeta));
    }
    if (data.containsKey('director')) {
      context.handle(_directorMeta,
          director.isAcceptableOrUnknown(data['director'], _directorMeta));
    }
    if (data.containsKey('reparto')) {
      context.handle(_repartoMeta,
          reparto.isAcceptableOrUnknown(data['reparto'], _repartoMeta));
    }
    if (data.containsKey('productora')) {
      context.handle(
          _productoraMeta,
          productora.isAcceptableOrUnknown(
              data['productora'], _productoraMeta));
    }
    if (data.containsKey('temp')) {
      context.handle(
          _tempMeta, temp.isAcceptableOrUnknown(data['temp'], _tempMeta));
    }
    if (data.containsKey('duracion')) {
      context.handle(_duracionMeta,
          duracion.isAcceptableOrUnknown(data['duracion'], _duracionMeta));
    }
    if (data.containsKey('capitulos')) {
      context.handle(_capitulosMeta,
          capitulos.isAcceptableOrUnknown(data['capitulos'], _capitulosMeta));
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
  AudiovisualTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return AudiovisualTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $AudiovisualTableTable createAlias(String alias) {
    return $AudiovisualTableTable(_db, alias);
  }
}

class GameTableData extends DataClass implements Insertable<GameTableData> {
  final String id;
  final String titulo;
  final String sinopsis;
  final String category;
  final String image;
  final String genre;
  final String plataformas;
  final DateTime fechaLanzamiento;
  final String score;
  final String empresa;
  final String fecha_reg;
  final String fecha_act;
  final bool isFavourite;
  GameTableData(
      {@required this.id,
      @required this.titulo,
      @required this.sinopsis,
      this.category,
      this.image,
      @required this.genre,
      @required this.plataformas,
      this.fechaLanzamiento,
      this.score,
      this.empresa,
      this.fecha_reg,
      this.fecha_act,
      @required this.isFavourite});
  factory GameTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return GameTableData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      titulo:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}titulo']),
      sinopsis: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}sinopsis']),
      category: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}category']),
      image:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}image']),
      genre:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}genre']),
      plataformas: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}plataformas']),
      fechaLanzamiento: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}fecha_lanzamiento']),
      score:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}score']),
      empresa:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}empresa']),
      fecha_reg: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}fecha_reg']),
      fecha_act: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}fecha_act']),
      isFavourite: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_favourite']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || titulo != null) {
      map['titulo'] = Variable<String>(titulo);
    }
    if (!nullToAbsent || sinopsis != null) {
      map['sinopsis'] = Variable<String>(sinopsis);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    if (!nullToAbsent || genre != null) {
      map['genre'] = Variable<String>(genre);
    }
    if (!nullToAbsent || plataformas != null) {
      map['plataformas'] = Variable<String>(plataformas);
    }
    if (!nullToAbsent || fechaLanzamiento != null) {
      map['fecha_lanzamiento'] = Variable<DateTime>(fechaLanzamiento);
    }
    if (!nullToAbsent || score != null) {
      map['score'] = Variable<String>(score);
    }
    if (!nullToAbsent || empresa != null) {
      map['empresa'] = Variable<String>(empresa);
    }
    if (!nullToAbsent || fecha_reg != null) {
      map['fecha_reg'] = Variable<String>(fecha_reg);
    }
    if (!nullToAbsent || fecha_act != null) {
      map['fecha_act'] = Variable<String>(fecha_act);
    }
    if (!nullToAbsent || isFavourite != null) {
      map['is_favourite'] = Variable<bool>(isFavourite);
    }
    return map;
  }

  GameTableCompanion toCompanion(bool nullToAbsent) {
    return GameTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      titulo:
          titulo == null && nullToAbsent ? const Value.absent() : Value(titulo),
      sinopsis: sinopsis == null && nullToAbsent
          ? const Value.absent()
          : Value(sinopsis),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      genre:
          genre == null && nullToAbsent ? const Value.absent() : Value(genre),
      plataformas: plataformas == null && nullToAbsent
          ? const Value.absent()
          : Value(plataformas),
      fechaLanzamiento: fechaLanzamiento == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaLanzamiento),
      score:
          score == null && nullToAbsent ? const Value.absent() : Value(score),
      empresa: empresa == null && nullToAbsent
          ? const Value.absent()
          : Value(empresa),
      fecha_reg: fecha_reg == null && nullToAbsent
          ? const Value.absent()
          : Value(fecha_reg),
      fecha_act: fecha_act == null && nullToAbsent
          ? const Value.absent()
          : Value(fecha_act),
      isFavourite: isFavourite == null && nullToAbsent
          ? const Value.absent()
          : Value(isFavourite),
    );
  }

  factory GameTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return GameTableData(
      id: serializer.fromJson<String>(json['id']),
      titulo: serializer.fromJson<String>(json['titulo']),
      sinopsis: serializer.fromJson<String>(json['sinopsis']),
      category: serializer.fromJson<String>(json['category']),
      image: serializer.fromJson<String>(json['image']),
      genre: serializer.fromJson<String>(json['genre']),
      plataformas: serializer.fromJson<String>(json['plataformas']),
      fechaLanzamiento: serializer.fromJson<DateTime>(json['fechaLanzamiento']),
      score: serializer.fromJson<String>(json['score']),
      empresa: serializer.fromJson<String>(json['empresa']),
      fecha_reg: serializer.fromJson<String>(json['fecha_reg']),
      fecha_act: serializer.fromJson<String>(json['fecha_act']),
      isFavourite: serializer.fromJson<bool>(json['isFavourite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'titulo': serializer.toJson<String>(titulo),
      'sinopsis': serializer.toJson<String>(sinopsis),
      'category': serializer.toJson<String>(category),
      'image': serializer.toJson<String>(image),
      'genre': serializer.toJson<String>(genre),
      'plataformas': serializer.toJson<String>(plataformas),
      'fechaLanzamiento': serializer.toJson<DateTime>(fechaLanzamiento),
      'score': serializer.toJson<String>(score),
      'empresa': serializer.toJson<String>(empresa),
      'fecha_reg': serializer.toJson<String>(fecha_reg),
      'fecha_act': serializer.toJson<String>(fecha_act),
      'isFavourite': serializer.toJson<bool>(isFavourite),
    };
  }

  GameTableData copyWith(
          {String id,
          String titulo,
          String sinopsis,
          String category,
          String image,
          String genre,
          String plataformas,
          DateTime fechaLanzamiento,
          String score,
          String empresa,
          String fecha_reg,
          String fecha_act,
          bool isFavourite}) =>
      GameTableData(
        id: id ?? this.id,
        titulo: titulo ?? this.titulo,
        sinopsis: sinopsis ?? this.sinopsis,
        category: category ?? this.category,
        image: image ?? this.image,
        genre: genre ?? this.genre,
        plataformas: plataformas ?? this.plataformas,
        fechaLanzamiento: fechaLanzamiento ?? this.fechaLanzamiento,
        score: score ?? this.score,
        empresa: empresa ?? this.empresa,
        fecha_reg: fecha_reg ?? this.fecha_reg,
        fecha_act: fecha_act ?? this.fecha_act,
        isFavourite: isFavourite ?? this.isFavourite,
      );
  @override
  String toString() {
    return (StringBuffer('GameTableData(')
          ..write('id: $id, ')
          ..write('titulo: $titulo, ')
          ..write('sinopsis: $sinopsis, ')
          ..write('category: $category, ')
          ..write('image: $image, ')
          ..write('genre: $genre, ')
          ..write('plataformas: $plataformas, ')
          ..write('fechaLanzamiento: $fechaLanzamiento, ')
          ..write('score: $score, ')
          ..write('empresa: $empresa, ')
          ..write('fecha_reg: $fecha_reg, ')
          ..write('fecha_act: $fecha_act, ')
          ..write('isFavourite: $isFavourite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          titulo.hashCode,
          $mrjc(
              sinopsis.hashCode,
              $mrjc(
                  category.hashCode,
                  $mrjc(
                      image.hashCode,
                      $mrjc(
                          genre.hashCode,
                          $mrjc(
                              plataformas.hashCode,
                              $mrjc(
                                  fechaLanzamiento.hashCode,
                                  $mrjc(
                                      score.hashCode,
                                      $mrjc(
                                          empresa.hashCode,
                                          $mrjc(
                                              fecha_reg.hashCode,
                                              $mrjc(
                                                  fecha_act.hashCode,
                                                  isFavourite
                                                      .hashCode)))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is GameTableData &&
          other.id == this.id &&
          other.titulo == this.titulo &&
          other.sinopsis == this.sinopsis &&
          other.category == this.category &&
          other.image == this.image &&
          other.genre == this.genre &&
          other.plataformas == this.plataformas &&
          other.fechaLanzamiento == this.fechaLanzamiento &&
          other.score == this.score &&
          other.empresa == this.empresa &&
          other.fecha_reg == this.fecha_reg &&
          other.fecha_act == this.fecha_act &&
          other.isFavourite == this.isFavourite);
}

class GameTableCompanion extends UpdateCompanion<GameTableData> {
  final Value<String> id;
  final Value<String> titulo;
  final Value<String> sinopsis;
  final Value<String> category;
  final Value<String> image;
  final Value<String> genre;
  final Value<String> plataformas;
  final Value<DateTime> fechaLanzamiento;
  final Value<String> score;
  final Value<String> empresa;
  final Value<String> fecha_reg;
  final Value<String> fecha_act;
  final Value<bool> isFavourite;
  const GameTableCompanion({
    this.id = const Value.absent(),
    this.titulo = const Value.absent(),
    this.sinopsis = const Value.absent(),
    this.category = const Value.absent(),
    this.image = const Value.absent(),
    this.genre = const Value.absent(),
    this.plataformas = const Value.absent(),
    this.fechaLanzamiento = const Value.absent(),
    this.score = const Value.absent(),
    this.empresa = const Value.absent(),
    this.fecha_reg = const Value.absent(),
    this.fecha_act = const Value.absent(),
    this.isFavourite = const Value.absent(),
  });
  GameTableCompanion.insert({
    @required String id,
    @required String titulo,
    @required String sinopsis,
    this.category = const Value.absent(),
    this.image = const Value.absent(),
    @required String genre,
    @required String plataformas,
    this.fechaLanzamiento = const Value.absent(),
    this.score = const Value.absent(),
    this.empresa = const Value.absent(),
    this.fecha_reg = const Value.absent(),
    this.fecha_act = const Value.absent(),
    this.isFavourite = const Value.absent(),
  })  : id = Value(id),
        titulo = Value(titulo),
        sinopsis = Value(sinopsis),
        genre = Value(genre),
        plataformas = Value(plataformas);
  static Insertable<GameTableData> custom({
    Expression<String> id,
    Expression<String> titulo,
    Expression<String> sinopsis,
    Expression<String> category,
    Expression<String> image,
    Expression<String> genre,
    Expression<String> plataformas,
    Expression<DateTime> fechaLanzamiento,
    Expression<String> score,
    Expression<String> empresa,
    Expression<String> fecha_reg,
    Expression<String> fecha_act,
    Expression<bool> isFavourite,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (titulo != null) 'titulo': titulo,
      if (sinopsis != null) 'sinopsis': sinopsis,
      if (category != null) 'category': category,
      if (image != null) 'image': image,
      if (genre != null) 'genre': genre,
      if (plataformas != null) 'plataformas': plataformas,
      if (fechaLanzamiento != null) 'fecha_lanzamiento': fechaLanzamiento,
      if (score != null) 'score': score,
      if (empresa != null) 'empresa': empresa,
      if (fecha_reg != null) 'fecha_reg': fecha_reg,
      if (fecha_act != null) 'fecha_act': fecha_act,
      if (isFavourite != null) 'is_favourite': isFavourite,
    });
  }

  GameTableCompanion copyWith(
      {Value<String> id,
      Value<String> titulo,
      Value<String> sinopsis,
      Value<String> category,
      Value<String> image,
      Value<String> genre,
      Value<String> plataformas,
      Value<DateTime> fechaLanzamiento,
      Value<String> score,
      Value<String> empresa,
      Value<String> fecha_reg,
      Value<String> fecha_act,
      Value<bool> isFavourite}) {
    return GameTableCompanion(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      sinopsis: sinopsis ?? this.sinopsis,
      category: category ?? this.category,
      image: image ?? this.image,
      genre: genre ?? this.genre,
      plataformas: plataformas ?? this.plataformas,
      fechaLanzamiento: fechaLanzamiento ?? this.fechaLanzamiento,
      score: score ?? this.score,
      empresa: empresa ?? this.empresa,
      fecha_reg: fecha_reg ?? this.fecha_reg,
      fecha_act: fecha_act ?? this.fecha_act,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (titulo.present) {
      map['titulo'] = Variable<String>(titulo.value);
    }
    if (sinopsis.present) {
      map['sinopsis'] = Variable<String>(sinopsis.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (genre.present) {
      map['genre'] = Variable<String>(genre.value);
    }
    if (plataformas.present) {
      map['plataformas'] = Variable<String>(plataformas.value);
    }
    if (fechaLanzamiento.present) {
      map['fecha_lanzamiento'] = Variable<DateTime>(fechaLanzamiento.value);
    }
    if (score.present) {
      map['score'] = Variable<String>(score.value);
    }
    if (empresa.present) {
      map['empresa'] = Variable<String>(empresa.value);
    }
    if (fecha_reg.present) {
      map['fecha_reg'] = Variable<String>(fecha_reg.value);
    }
    if (fecha_act.present) {
      map['fecha_act'] = Variable<String>(fecha_act.value);
    }
    if (isFavourite.present) {
      map['is_favourite'] = Variable<bool>(isFavourite.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GameTableCompanion(')
          ..write('id: $id, ')
          ..write('titulo: $titulo, ')
          ..write('sinopsis: $sinopsis, ')
          ..write('category: $category, ')
          ..write('image: $image, ')
          ..write('genre: $genre, ')
          ..write('plataformas: $plataformas, ')
          ..write('fechaLanzamiento: $fechaLanzamiento, ')
          ..write('score: $score, ')
          ..write('empresa: $empresa, ')
          ..write('fecha_reg: $fecha_reg, ')
          ..write('fecha_act: $fecha_act, ')
          ..write('isFavourite: $isFavourite')
          ..write(')'))
        .toString();
  }
}

class $GameTableTable extends GameTable
    with TableInfo<$GameTableTable, GameTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $GameTableTable(this._db, [this._alias]);
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

  final VerificationMeta _tituloMeta = const VerificationMeta('titulo');
  GeneratedTextColumn _titulo;
  @override
  GeneratedTextColumn get titulo => _titulo ??= _constructTitulo();
  GeneratedTextColumn _constructTitulo() {
    return GeneratedTextColumn(
      'titulo',
      $tableName,
      false,
    );
  }

  final VerificationMeta _sinopsisMeta = const VerificationMeta('sinopsis');
  GeneratedTextColumn _sinopsis;
  @override
  GeneratedTextColumn get sinopsis => _sinopsis ??= _constructSinopsis();
  GeneratedTextColumn _constructSinopsis() {
    return GeneratedTextColumn(
      'sinopsis',
      $tableName,
      false,
    );
  }

  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  GeneratedTextColumn _category;
  @override
  GeneratedTextColumn get category => _category ??= _constructCategory();
  GeneratedTextColumn _constructCategory() {
    return GeneratedTextColumn(
      'category',
      $tableName,
      true,
    );
  }

  final VerificationMeta _imageMeta = const VerificationMeta('image');
  GeneratedTextColumn _image;
  @override
  GeneratedTextColumn get image => _image ??= _constructImage();
  GeneratedTextColumn _constructImage() {
    return GeneratedTextColumn(
      'image',
      $tableName,
      true,
    );
  }

  final VerificationMeta _genreMeta = const VerificationMeta('genre');
  GeneratedTextColumn _genre;
  @override
  GeneratedTextColumn get genre => _genre ??= _constructGenre();
  GeneratedTextColumn _constructGenre() {
    return GeneratedTextColumn(
      'genre',
      $tableName,
      false,
    );
  }

  final VerificationMeta _plataformasMeta =
      const VerificationMeta('plataformas');
  GeneratedTextColumn _plataformas;
  @override
  GeneratedTextColumn get plataformas =>
      _plataformas ??= _constructPlataformas();
  GeneratedTextColumn _constructPlataformas() {
    return GeneratedTextColumn(
      'plataformas',
      $tableName,
      false,
    );
  }

  final VerificationMeta _fechaLanzamientoMeta =
      const VerificationMeta('fechaLanzamiento');
  GeneratedDateTimeColumn _fechaLanzamiento;
  @override
  GeneratedDateTimeColumn get fechaLanzamiento =>
      _fechaLanzamiento ??= _constructFechaLanzamiento();
  GeneratedDateTimeColumn _constructFechaLanzamiento() {
    return GeneratedDateTimeColumn(
      'fecha_lanzamiento',
      $tableName,
      true,
    );
  }

  final VerificationMeta _scoreMeta = const VerificationMeta('score');
  GeneratedTextColumn _score;
  @override
  GeneratedTextColumn get score => _score ??= _constructScore();
  GeneratedTextColumn _constructScore() {
    return GeneratedTextColumn(
      'score',
      $tableName,
      true,
    );
  }

  final VerificationMeta _empresaMeta = const VerificationMeta('empresa');
  GeneratedTextColumn _empresa;
  @override
  GeneratedTextColumn get empresa => _empresa ??= _constructEmpresa();
  GeneratedTextColumn _constructEmpresa() {
    return GeneratedTextColumn(
      'empresa',
      $tableName,
      true,
    );
  }

  final VerificationMeta _fecha_regMeta = const VerificationMeta('fecha_reg');
  GeneratedTextColumn _fecha_reg;
  @override
  GeneratedTextColumn get fecha_reg => _fecha_reg ??= _constructFechaReg();
  GeneratedTextColumn _constructFechaReg() {
    return GeneratedTextColumn(
      'fecha_reg',
      $tableName,
      true,
    );
  }

  final VerificationMeta _fecha_actMeta = const VerificationMeta('fecha_act');
  GeneratedTextColumn _fecha_act;
  @override
  GeneratedTextColumn get fecha_act => _fecha_act ??= _constructFechaAct();
  GeneratedTextColumn _constructFechaAct() {
    return GeneratedTextColumn(
      'fecha_act',
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
        titulo,
        sinopsis,
        category,
        image,
        genre,
        plataformas,
        fechaLanzamiento,
        score,
        empresa,
        fecha_reg,
        fecha_act,
        isFavourite
      ];
  @override
  $GameTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'game';
  @override
  final String actualTableName = 'game';
  @override
  VerificationContext validateIntegrity(Insertable<GameTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('titulo')) {
      context.handle(_tituloMeta,
          titulo.isAcceptableOrUnknown(data['titulo'], _tituloMeta));
    } else if (isInserting) {
      context.missing(_tituloMeta);
    }
    if (data.containsKey('sinopsis')) {
      context.handle(_sinopsisMeta,
          sinopsis.isAcceptableOrUnknown(data['sinopsis'], _sinopsisMeta));
    } else if (isInserting) {
      context.missing(_sinopsisMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category'], _categoryMeta));
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image'], _imageMeta));
    }
    if (data.containsKey('genre')) {
      context.handle(
          _genreMeta, genre.isAcceptableOrUnknown(data['genre'], _genreMeta));
    } else if (isInserting) {
      context.missing(_genreMeta);
    }
    if (data.containsKey('plataformas')) {
      context.handle(
          _plataformasMeta,
          plataformas.isAcceptableOrUnknown(
              data['plataformas'], _plataformasMeta));
    } else if (isInserting) {
      context.missing(_plataformasMeta);
    }
    if (data.containsKey('fecha_lanzamiento')) {
      context.handle(
          _fechaLanzamientoMeta,
          fechaLanzamiento.isAcceptableOrUnknown(
              data['fecha_lanzamiento'], _fechaLanzamientoMeta));
    }
    if (data.containsKey('score')) {
      context.handle(
          _scoreMeta, score.isAcceptableOrUnknown(data['score'], _scoreMeta));
    }
    if (data.containsKey('empresa')) {
      context.handle(_empresaMeta,
          empresa.isAcceptableOrUnknown(data['empresa'], _empresaMeta));
    }
    if (data.containsKey('fecha_reg')) {
      context.handle(_fecha_regMeta,
          fecha_reg.isAcceptableOrUnknown(data['fecha_reg'], _fecha_regMeta));
    }
    if (data.containsKey('fecha_act')) {
      context.handle(_fecha_actMeta,
          fecha_act.isAcceptableOrUnknown(data['fecha_act'], _fecha_actMeta));
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
  GameTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return GameTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $GameTableTable createAlias(String alias) {
    return $GameTableTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $AudiovisualTableTable _audiovisualTable;
  $AudiovisualTableTable get audiovisualTable =>
      _audiovisualTable ??= $AudiovisualTableTable(this);
  $GameTableTable _gameTable;
  $GameTableTable get gameTable => _gameTable ??= $GameTableTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [audiovisualTable, gameTable];
}
