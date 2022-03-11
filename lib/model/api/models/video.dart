class Video {
  String? id;
  String? iso6391;
  String? iso31661;
  String? key;
  String? name;
  String? site;
  int? size;
  String? type;
  bool get isYoutube => site != null && site!.toLowerCase().trim() == 'youtube';

  Video({this.id, this.iso6391, this.iso31661, this.key, this.name, this.site, this.size, this.type});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iso6391 = json['iso_639_1'];
    iso31661 = json['iso_3166_1'];
    key = json['key'];
    name = json['name'];
    site = json['site'];
    size = json['size'];
    type = json['type'];
  }
}
