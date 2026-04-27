class MediaImageResponse {
  List<MediaImage>? backdrops;
  List<MediaImage>? posters;
  List<MediaImage>? profiles;
  List<MediaImage>? logos;

  String get totalImages {
    int total = 0;
    if (backdrops != null) {
      total += backdrops!.length;
    }
    if (posters != null) {
      total += posters!.length;
    }
    if (profiles != null) {
      total += profiles!.length;
    }
    if (logos != null) {
      total += logos!.length;
    }
    // support 99+
    return total > 99 ? '99+' : total.toString();
  }

  MediaImageResponse({this.backdrops, this.posters, this.profiles, this.logos});

  MediaImageResponse.fromJson(Map<String, dynamic> json) {
    if (json['backdrops'] != null) {
      backdrops = <MediaImage>[];
      json['backdrops'].forEach((v) {
        backdrops!.add(MediaImage.fromJson(v));
      });
    }
    if (json['posters'] != null) {
      posters = <MediaImage>[];
      json['posters'].forEach((v) {
        posters!.add(MediaImage.fromJson(v));
      });
    }
    if (json['profiles'] != null) {
      profiles = <MediaImage>[];
      json['profiles'].forEach((v) {
        profiles!.add(MediaImage.fromJson(v));
      });
    }
    if (json['logos'] != null) {
      logos = <MediaImage>[];
      json['logos'].forEach((v) {
        logos!.add(MediaImage.fromJson(v));
      });
    }
  }

  Map<MediaImageType, List<MediaImage>> toMap() {
    return {
      if (backdrops != null) MediaImageType.BACKDROP: backdrops ?? [],
      if (posters != null) MediaImageType.POSTER: posters ?? [],
      if (profiles != null) MediaImageType.PROFILES: profiles ?? [],
    };
  }
}

class MediaImage {
  double? aspectRatio;
  String? filePath;
  int? height;
  double? voteAverage;
  int? voteCount;
  int? width;

  MediaImage({this.aspectRatio, this.filePath, this.height, this.voteAverage, this.voteCount, this.width});

  MediaImage.fromJson(Map<String, dynamic> json) {
    aspectRatio = json['aspect_ratio'];
    filePath = json['file_path'];
    height = json['height'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    width = json['width'];
  }
}

enum MediaImageType { POSTER, BACKDROP, PROFILES }

extension MediaImageTypeExtension on MediaImageType {
  String get title {
    if (this == MediaImageType.POSTER) {
      return 'Poster';
    } else if (this == MediaImageType.BACKDROP) {
      return 'Backdrop';
    } else if (this == MediaImageType.PROFILES) {
      return 'Profiles';
    }
    return toString();
  }
}
