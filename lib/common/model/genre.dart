class Genre {
  // Campos del objeto Genre
  final int id;
  final String name;

  // Constructor
  Genre({required this.id, required this.name});

  /// Factory constructor para crear una instancia de Genre a partir de un Map (JSON)
  factory Genre.fromJson(Map<String, dynamic> json) {
    // Los campos 'id' y 'name' se extraen del JSON proporcionado [1, 2]
    return Genre(id: json['id'] as int, name: json['name'] as String);
  }

  // Opcional: Método para convertir la instancia de Dart de vuelta a un Map
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

// 2. Clase para el Objeto de Respuesta Completo (GenreListResponse)

class GenreListResponse {
  // Contiene la lista de géneros [1, 2]
  final List<Genre> genres;

  // Constructor
  GenreListResponse({required this.genres});

  /// Factory constructor para crear la instancia completa a partir del cuerpo de la respuesta JSON
  factory GenreListResponse.fromJson(Map<String, dynamic> json) {
    // El JSON principal contiene la clave 'genres' [1]
    final List<dynamic> genreListJson = json['genres'] as List<dynamic>;

    // Mapeamos cada elemento del array JSON a una instancia de la clase Genre
    return GenreListResponse(
      genres: genreListJson.map((item) => Genre.fromJson(item as Map<String, dynamic>)).toList(),
    );
  }
}
