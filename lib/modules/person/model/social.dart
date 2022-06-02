class Social {
  int? id;
  String? imdbId;
  String? facebookId;
  String? instagramId;
  String? twitterId;

  Social({this.id, this.imdbId, this.facebookId, this.instagramId, this.twitterId});

  Social.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imdbId = json['imdb_id'];
    facebookId = json['facebook_id'];
    instagramId = json['instagram_id'];
    twitterId = json['twitter_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imdb_id'] = this.imdbId;
    data['facebook_id'] = this.facebookId;
    data['instagram_id'] = this.instagramId;
    data['twitter_id'] = this.twitterId;
    return data;
  }
}
