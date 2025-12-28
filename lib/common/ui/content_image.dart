import 'package:cached_network_image/cached_network_image.dart';
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

  @override
  Widget build(BuildContext context) {
    if (imagePath == null || imagePath!.isEmpty) return PlaceholderImage();
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      // constraints: BoxConstraints(maxHeight: 10.h),
      child: GestureDetector(
        onTap: ignorePointer
            ? null
            : onSelectImage != null
            ? () => onSelectImage!.call()
            : () => DialogImage.show(context: context, imageUrl: imagePath!, baseUrl: URL_IMAGE_BIG),
        child: CachedNetworkImage(
          imageUrl: !_isOutsideTMDB ? '$URL_IMAGE_BIG$imagePath' : imagePath!,
          placeholder: (_, __) => withPlaceholder && !_isOutsideTMDB
              ? CachedNetworkImage(
                  fit: fit,
                  imageUrl: '$placeholderBaseUrl$imagePath',
                  placeholder: (context, _) => DefaultPlaceholder(),
                )
              : DefaultPlaceholder(),
          errorWidget: (ctx, _, __) => PlaceholderImage(height: MediaQuery.of(ctx).size.height * 0.6),
          fit: fit,
          // width: double.infinity,
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