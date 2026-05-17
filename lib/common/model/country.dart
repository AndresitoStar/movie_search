class Country {
  final String iso31661;
  final String name;
  final String nativeName;

  Country({
    required this.iso31661,
    required this.name,
    required this.nativeName,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      iso31661: json["iso_3166_1"],
      name: json["english_name"],
      nativeName: json["native_name"],
    );
  }

  Map<String, dynamic> toJson() => {
    "iso_3166_1": iso31661,
    "english_name": name,
    "native_name": nativeName,
  };
}

enum SortDirection {
  desc('desc', 'Descendente'),
  asc('asc', 'Ascendente');

  const SortDirection(this.value, this.label);

  final String value;
  final String label;
}

enum SortOrder {
  POPULARITY('popularity', 'Popularidad'),
  FIRST_AIR_DATE('first_air_date', 'Fecha de Primer Episodio'),
  NAME('name', 'Nombre'),
  RELEASE_DATE('release_date', 'Fecha de Lanzamiento'),
  PRIMARY_RELEASE_DATE('primary_release_date', 'Fecha de Lanzamiento'),
  REVENUE('revenue', 'Ingresos'),
  ORIGINAL_TITLE('original_title', 'Titulo Original'),
  TITLE('title', 'Titulo'),
  ORIGINAL_NAME('original_name', 'Nombre Original'),
  VOTE_AVERAGE('vote_average', 'Promedio de votos'),
  VOTE_COUNT('vote_count', 'Cantidad de Votos');

  const SortOrder(this.value, this.label);

  final String value;
  final String label;

  static List<SortOrder> movieSortOrders() {
    return [
      POPULARITY,
      PRIMARY_RELEASE_DATE,
      REVENUE,
      TITLE,
      VOTE_AVERAGE,
      VOTE_COUNT,
      ORIGINAL_TITLE,
    ];
  }

  static List<SortOrder> tvSortOrders() {
    return [
      FIRST_AIR_DATE,
      NAME,
      ORIGINAL_NAME,
      POPULARITY,
      VOTE_AVERAGE,
      VOTE_COUNT,
    ];
  }
}

