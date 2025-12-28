class ExternalIdResponse {
  final int? id;
  final String? imdbId;
  final dynamic wikidataId;
  final String? facebookId;
  final dynamic instagramId;
  final dynamic twitterId;

  ExternalIdResponse({
    this.id,
    this.imdbId,
    this.wikidataId,
    this.facebookId,
    this.instagramId,
    this.twitterId,
  });

  factory ExternalIdResponse.fromJson(Map<String, dynamic> json) => ExternalIdResponse(
    id: json["id"],
    imdbId: json["imdb_id"],
    wikidataId: json["wikidata_id"],
    facebookId: json["facebook_id"],
    instagramId: json["instagram_id"],
    twitterId: json["twitter_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "imdb_id": imdbId,
    "wikidata_id": wikidataId,
    "facebook_id": facebookId,
    "instagram_id": instagramId,
    "twitter_id": twitterId,
  };
}

class ImdbRatingResponse {
  final String? imdbRating;

  ImdbRatingResponse({
    this.imdbRating,
  });

  factory ImdbRatingResponse.fromJson(Map<String, dynamic> json) => ImdbRatingResponse(
    imdbRating: json["imdbRating"],
  );
}