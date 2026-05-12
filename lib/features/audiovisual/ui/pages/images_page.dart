import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:movie_search/common/model/media_image.dart';
import 'package:movie_search/common/ui/content_image.dart';
import 'package:movie_search/common/ui/icons.dart';
import 'package:movie_search/common/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ImagesPage extends StatelessWidget {
  static const String routeName = "/images";

  final String title;
  final Map<MediaImageType, List<MediaImage>> imagesMap;

  const ImagesPage({super.key, required this.title, required this.imagesMap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        forceMaterialTransparency: true,
        primary: true,
        titleSpacing: 0,
        elevation: 0,
        leading: IconButton(icon: Icon(MyIcons.arrow_left), onPressed: () => context.pop()),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(3),
        itemCount: imagesMap.length,
        itemBuilder: (ctx, i) {
          final mediaType = imagesMap.keys.elementAt(i);
          final isBackdrop = mediaType == MediaImageType.BACKDROP;
          final firstImagePath = imagesMap[mediaType] != null && imagesMap[mediaType]!.isNotEmpty
              ? imagesMap[mediaType]![0].filePath
              : null;
          return InkWell(
            onTap: () => context.push('/album', extra: {'type': mediaType, 'images': imagesMap[mediaType] ?? []}),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: _getImageProvider(firstImagePath, isBackdrop: isBackdrop),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              child: Chip(
                elevation: 0,
                backgroundColor: context.colors.primary,
                labelPadding: EdgeInsets.symmetric(horizontal: 10),
                label: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      mediaType.title,
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleSmall?.copyWith(color: context.colors.onPrimary),
                    ),
                    Text(
                      '${imagesMap[mediaType]?.length ?? 0} images',
                      textAlign: TextAlign.center,
                      style: context.textTheme.labelSmall?.copyWith(color: context.colors.onPrimary),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: context.calculateColumns(itemWidth: 200, minValue: 2, maxValue: 8),
          childAspectRatio: 1,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
        ),
      ),
    );
  }

  ImageProvider _getImageProvider(String? imagePath, {bool isBackdrop = false}) {
    if (imagePath == null || imagePath.isEmpty) {
      return AssetImage('assets/images/placeholder.jpg');
    }
    final baseUrl = isBackdrop ? URL_IMAGE_MEDIUM_BACKDROP : URL_IMAGE_MEDIUM;
    final fullUrl = '$baseUrl$imagePath';
    return CachedNetworkImageProvider(fullUrl);
  }
}

class AlbumPage extends StatelessWidget {
  final MediaImageType type;
  final List<MediaImage> images;

  const AlbumPage({super.key, required this.type, required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(type.title),
        forceMaterialTransparency: true,
        primary: true,
        titleSpacing: 0,
        elevation: 0,
        leading: IconButton(icon: Icon(MyIcons.arrow_left), onPressed: () => context.pop()),
      ),
      body: GridView.builder(
        itemCount: images.length,
        itemBuilder: (ctx, i) {
          final image = images[i];
          return ContentImageWidget(
            image.filePath,
            fit: BoxFit.cover,
            onSelectImage: context.isMobile && image.filePath == null
                ? null
                : () => launchUrlString(ContentImageWidget.getURL(image.filePath!)),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: getColumns(context),
          childAspectRatio: images.first.aspectRatio ?? aspectRatio,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
        ),
      ),
    );
  }

  int getColumns(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return (width ~/ widthForImage).clamp(1, 6);
  }

  double get aspectRatio {
    switch (type) {
      case MediaImageType.POSTER:
      case MediaImageType.PROFILES:
        return 0.667; // 2:3
      case MediaImageType.BACKDROP:
        return 1.778;
    }
  }

  int get widthForImage {
    switch (type) {
      case MediaImageType.POSTER:
        return 150;
      case MediaImageType.BACKDROP:
        return 500;
      case MediaImageType.PROFILES:
        return 185;
    }
  }
}
