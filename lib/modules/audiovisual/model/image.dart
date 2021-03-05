class MediaImage {
  double aspectRatio;
  String filePath;
  int height;
  double voteAverage;
  int voteCount;
  int width;

  MediaImage(
      {this.aspectRatio,
      this.filePath,
      this.height,
      this.voteAverage,
      this.voteCount,
      this.width});

  MediaImage.fromJson(Map<String, dynamic> json) {
    aspectRatio = json['aspect_ratio'];
    filePath = json['file_path'];
    height = json['height'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    width = json['width'];
  }

}
