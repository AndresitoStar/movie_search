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
}
