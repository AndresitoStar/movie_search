import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search/modules/audiovisual/model/image.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/rest/resolver.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/dialog_image.dart';

import 'item_detail_main_image.dart';

class ItemImagesGroup extends StatelessWidget {
  static const String routeName = "/images";

  final String title;
  final Map<MediaImageType, List<MediaImage>> imagesMap;

  const ItemImagesGroup({super.key, required this.title, required this.imagesMap});

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
            onTap: () => context.push('/images/list', extra: {
              'type': mediaType,
              'images': imagesMap[mediaType] ?? [],
            }),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: _getImageProvider(firstImagePath, isBackdrop: isBackdrop),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListTile(
                title: Text(mediaType.title, textAlign: TextAlign.center),
                subtitle: Text('${imagesMap[mediaType]?.length ?? 0} images', textAlign: TextAlign.center),
              ),
              alignment: Alignment.center,
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: UIUtils.getColumns(context),
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

class ItemImagesPage extends StatelessWidget {
  final MediaImageType type;
  final List<MediaImage> images;

  const ItemImagesPage({super.key, required this.type, required this.images});

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
            // onSelectImage: () => onSelectImage(context, image.filePath),
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
        return 1.778; // 16:9
      default:
        return 1;
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
      default:
        return 500;
    }
  }
}
