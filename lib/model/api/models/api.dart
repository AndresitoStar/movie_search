class ApiException implements Exception {
  final dynamic message;

  ApiException([this.message]);

  String toString() {
    Object? message = this.message;
    if (message == null) return ">>> ApiException";
    return ">>>>ApiException: $message";
  }
}

enum SortDirection {
  desc('desc'),
  asc('asc');

  const SortDirection(this.value);

  final String value;
}

enum SortOrder {
  POPULARITY('popularity', 'Popularidad'),
  RELEASE_DATE('release_date', 'Fecha de Lanzamiento'),
  REVENUE('revenue', 'Ingresos'),
  ORIGINAL_TITLE('original_title', 'Titulo Original'),
  VOTE_AVERAGE('vote_average', 'Promedio de votos'),
  VOTE_COUNT('vote_count', 'Cantidad de Votos');

  const SortOrder(this.value, this.label);

  final String value;
  final String label;
}
