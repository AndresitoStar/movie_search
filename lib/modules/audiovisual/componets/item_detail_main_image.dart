import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_detail_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/widgets/default_image.dart';
import 'package:movie_search/ui/widgets/dialog_image.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:stacked/stacked.dart';

class DetailMainImage extends ViewModelWidget<ItemDetailViewModel> {
  final bool landscape;

  DetailMainImage({this.landscape = false});

  @override
  Widget build(BuildContext context, model) {
    // final theme = Theme.of(context);
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        fit: StackFit.expand,
        children: [
          model.withImage ? ContentImageWidget(model.posterImageUrl) : Card(child: PlaceholderImage(height: 250)),
          if (!landscape)
            IgnorePointer(
              ignoring: true,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: landscape ? Alignment.centerLeft : Alignment.topCenter,
                    end: landscape ? Alignment.centerRight : Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                      Theme.of(context).scaffoldBackgroundColor
                    ],
                  ),
                  border: Border.all(color: Theme.of(context).scaffoldBackgroundColor),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ContentImageWidget extends StatefulWidget {
  final String? imagePath;
  final BoxFit fit;
  final bool ignorePointer;
  final bool isBackdrop;

  ContentImageWidget(
    this.imagePath, {
    Key? key,
    this.fit = BoxFit.fitWidth,
    this.ignorePointer = false,
    this.isBackdrop = false,
  }) : super(key: key);

  @override
  _ContentImageWidgetState createState() => _ContentImageWidgetState();
}

class _ContentImageWidgetState extends State<ContentImageWidget> {
  late String baseUrl;

  @override
  void initState() {
    baseUrl = widget.isBackdrop ? URL_IMAGE_MEDIUM_BACKDROP : URL_IMAGE_MEDIUM;
    // _checkImageCachedQuality();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imagePath == null || widget.imagePath!.isEmpty) return PlaceholderImage();
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: GestureDetector(
        onTap: widget.ignorePointer
            ? null
            : () => DialogImage.show(context: context, imageUrl: widget.imagePath!, baseUrl: baseUrl)
                .then((value) => _checkImageCachedQuality),
        child: CachedNetworkImage(
          imageUrl: '$baseUrl${widget.imagePath}',
          placeholder: (_, __) => CachedNetworkImage(
            fit: widget.fit,
            imageUrl: '${widget.isBackdrop ? URL_IMAGE_SMALL_BACKDROP : URL_IMAGE_SMALL}${widget.imagePath}',
            placeholder: (context, _) => DefaultPlaceholder(),
          ),
          errorWidget: (ctx, _, __) => PlaceholderImage(/*height: MediaQuery.of(ctx).size.height * 0.6*/),
          fit: widget.fit,
          // width: double.infinity,
        ),
      ),
    );
  }

  Future _checkImageCachedQuality() async {
    String result;
    if (await _checkImageCachedExist('$URL_IMAGE_BIG${widget.imagePath}')) {
      result = URL_IMAGE_BIG;
    } else {
      result = widget.isBackdrop ? URL_IMAGE_MEDIUM : URL_IMAGE_MEDIUM_BACKDROP;
    }
    if (mounted) {
      setState(() => baseUrl = result);
    }
  }

  Future<bool> _checkImageCachedExist(String url) async {
    try {
      final FileInfo? fileInfo = await DefaultCacheManager().getFileFromCache(url);
      return await fileInfo?.file.exists() ?? false;
    } catch (e) {
      return false;
    }
  }
}
