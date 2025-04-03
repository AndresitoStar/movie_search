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
          model.withImage
              ? ContentImageWidget(
                  landscape ? model.backDropImageUrl : model.posterImageUrl,
                  isBackdrop: landscape)
              : Card(child: PlaceholderImage(height: 250)),
          if (!landscape)
            IgnorePointer(
              ignoring: true,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin:
                        landscape ? Alignment.centerLeft : Alignment.topCenter,
                    end: landscape
                        ? Alignment.centerRight
                        : Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                      Theme.of(context).scaffoldBackgroundColor
                    ],
                  ),
                  border: Border.all(
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ContentImageWidget extends StackedView<ContentImageViewModel> {
  final String? imagePath;
  final BoxFit fit;
  final bool ignorePointer;
  final bool isBackdrop;
  final VoidCallback? onSelectImage;

  ContentImageWidget(
    this.imagePath, {
    this.fit = BoxFit.fitWidth,
    this.ignorePointer = false,
    this.isBackdrop = false,
    this.onSelectImage,
  }) : super(key: UniqueKey()) {
    placeholderBaseUrl =
        isBackdrop ? URL_IMAGE_SMALL_BACKDROP : URL_IMAGE_SMALL;
  }

  late String placeholderBaseUrl;

  bool get _isOutsideTMDB =>
      imagePath != null && imagePath!.startsWith('https://');

  @override
  ContentImageViewModel viewModelBuilder(BuildContext context) {
    return ContentImageViewModel(imagePath: imagePath, isBackdrop: isBackdrop);
  }

  @override
  void onViewModelReady(ContentImageViewModel viewModel) {
    viewModel.checkImageCachedQuality();
  }

  @override
  Widget builder(
      BuildContext context, ContentImageViewModel model, Widget? child) {
    if (imagePath == null || imagePath!.isEmpty) return PlaceholderImage();
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      // constraints: BoxConstraints(maxHeight: 10.h),
      child: GestureDetector(
        onTap: ignorePointer
            ? null
            : onSelectImage != null
                ? () => onSelectImage!.call()
                : () => DialogImage.show(
                      context: context,
                      imageUrl: imagePath!,
                      baseUrl: URL_IMAGE_BIG,
                    ),
        child: CachedNetworkImage(
          imageUrl:
              !_isOutsideTMDB ? '$URL_IMAGE_BIG${imagePath}' : imagePath!,
          placeholder: (_, __) => !_isOutsideTMDB
              ? CachedNetworkImage(
                  fit: fit,
                  imageUrl: '$placeholderBaseUrl${imagePath}',
                  placeholder: (context, _) => DefaultPlaceholder(),
                )
              : DefaultPlaceholder(),
          errorWidget: (ctx, _, __) =>
              PlaceholderImage(height: MediaQuery.of(ctx).size.height * 0.6),
          fit: fit,
          // width: double.infinity,
        ),
      ),
    );
  }
}

class ContentImageViewModel extends BaseViewModel {
  final String? imagePath;
  final bool isBackdrop;
  late String baseUrl;

  ContentImageViewModel({required this.imagePath, required this.isBackdrop}) {
    baseUrl = isBackdrop ? URL_IMAGE_MEDIUM_BACKDROP : URL_IMAGE_MEDIUM;
  }

  Future checkImageCachedQuality() async {
    if (await _checkImageCachedExist('$URL_IMAGE_BIG${imagePath}')) {
      baseUrl = URL_IMAGE_BIG;
    } else {
      baseUrl = isBackdrop ? URL_IMAGE_MEDIUM : URL_IMAGE_MEDIUM_BACKDROP;
    }
    notifyListeners();
  }

  Future<bool> _checkImageCachedExist(String url) async {
    try {
      final FileInfo? fileInfo =
          await DefaultCacheManager().getFileFromCache(url);
      return await fileInfo?.file.exists() ?? false;
    } catch (e) {
      return false;
    }
  }
}
