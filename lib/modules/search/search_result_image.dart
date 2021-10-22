import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/default_image.dart';

class SearchResultItemImage extends StatelessWidget {
  final String heroTag;
  final String imagePath;

  const SearchResultItemImage(this.heroTag, this.imagePath, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxHeight: 120,
      child: imagePath == null
          ? PlaceholderImage()
          : Hero(
              tag: heroTag,
              child: Material(
                child: AspectRatio(
                    aspectRatio: 9 / 16,
                    child: FutureBuilder<String>(
                        future: _checkImageCachedQuality(),
                        initialData: URL_IMAGE_SMALL,
                        builder: (context, snapshot) {
                          return CachedNetworkImage(
                            imageUrl: '${snapshot.data}$imagePath',
                            placeholder: (_, __) =>
                                Container(color: Colors.transparent, child: Center(child: CircularProgressIndicator())),
                            errorWidget: (ctx, _, __) =>
                                Container(color: Colors.transparent, child: Center(child: Icon(MyIcons.default_image))),
                            fit: BoxFit.cover,
                          );
                        })),
              ),
            ),
    );
  }

  Future<String> _checkImageCachedQuality() async {
    if (await _checkImageCachedExist('$URL_IMAGE_BIG$imagePath')) {
      return URL_IMAGE_BIG;
    } else if (await _checkImageCachedExist('$URL_IMAGE_MEDIUM$imagePath')) {
      return URL_IMAGE_MEDIUM;
    }
    return URL_IMAGE_SMALL;
  }

  Future<bool> _checkImageCachedExist(String url) async {
    try {
      var file = await DefaultCacheManager().getFileFromCache(url);
      return file?.file?.exists() ?? false;
    } catch (e) {
      return false;
    }
  }
}
