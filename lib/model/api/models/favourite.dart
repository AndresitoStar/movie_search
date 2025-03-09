class BaseFavouriteItem {
  final int id;
  final String type;
  final String json;

  BaseFavouriteItem({required this.id, required this.type, required this.json});

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'type': this.type,
      'json': this.json,
    };
  }

  factory BaseFavouriteItem.fromJson(Map<String, dynamic> json) {
    return BaseFavouriteItem(
      id: json['id'] as int,
      type: json['type'] as String,
      json: json['json'] as String,
    );
  }
}
