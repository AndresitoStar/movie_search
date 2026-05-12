import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/common/ui/placeholder_image.dart';
import 'package:movie_search/common/utils.dart';

class ContentImageWidget extends StatelessWidget {
  final String? imagePath;
  final BoxFit fit;
  final bool ignorePointer;
  final bool isBackdrop;
  final bool withPlaceholder;
  final VoidCallback? onSelectImage;

  ContentImageWidget(
    this.imagePath, {
    this.fit = BoxFit.fitWidth,
    this.ignorePointer = false,
    this.isBackdrop = false,
    this.withPlaceholder = true,
    this.onSelectImage,
  }) : super(key: UniqueKey()) {
    placeholderBaseUrl = isBackdrop ? URL_IMAGE_SMALL_BACKDROP : URL_IMAGE_SMALL;
  }

  late String placeholderBaseUrl;

  bool get _isOutsideTMDB => imagePath != null && imagePath!.startsWith('https://');

  static String getURL(String imagePath) {
    return '$URL_IMAGE_BIG$imagePath';
  }

  @override
  Widget build(BuildContext context) {
    if (imagePath == null || imagePath!.isEmpty) return PlaceholderImage();
    final imageUrl = !_isOutsideTMDB ? '$URL_IMAGE_BIG$imagePath' : imagePath!;

    // Para desktop, usa Image.network con filterQuality alto
    if (defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: GestureDetector(
          onTap: ignorePointer ? null : onSelectImage ?? () => DialogImage.show(context: context, imageUrl: imageUrl),
          child: Image.network(
            imageUrl,
            fit: fit,
            filterQuality: FilterQuality.high, // Mejora la calidad de rendering
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return withPlaceholder && !_isOutsideTMDB
                  ? Image.network('$placeholderBaseUrl$imagePath', fit: fit, filterQuality: FilterQuality.high)
                  : DefaultPlaceholder();
            },
            errorBuilder: (ctx, _, __) => PlaceholderImage(height: MediaQuery.of(ctx).size.height * 0.6),
          ),
        ),
      );
    }

    // Para mobile, mantiene CachedNetworkImage
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: GestureDetector(
        onTap: ignorePointer ? null : onSelectImage ?? () => DialogImage.show(context: context, imageUrl: imageUrl),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: fit,
          placeholder: (_, __) => withPlaceholder && !_isOutsideTMDB
              ? CachedNetworkImage(imageUrl: '$placeholderBaseUrl$imagePath', fit: fit)
              : DefaultPlaceholder(),
          errorWidget: (ctx, _, __) => PlaceholderImage(height: MediaQuery.of(ctx).size.height * 0.6),
        ),
      ),
    );
  }
}

// DialogImage page
class DialogImage {
  static void show({required BuildContext context, required String imageUrl, String baseUrl = URL_IMAGE_BIG}) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: CachedNetworkImage(
            imageUrl: '$baseUrl$imageUrl',
            placeholder: (context, _) => DefaultPlaceholder(),
            errorWidget: (ctx, _, __) => PlaceholderImage(height: MediaQuery.of(ctx).size.height * 0.6),
            fit: BoxFit.contain,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
