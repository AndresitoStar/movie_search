import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_detail_viewmodel.dart';
import 'package:movie_search/modules/dialog_image/download_image_button.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/circular_button.dart';
import 'package:movie_search/ui/widgets/default_image.dart';
import 'package:movie_search/ui/widgets/dialog_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stacked/stacked.dart';

class DetailMainImage extends ViewModelWidget<ItemDetailViewModel> {
  final bool landscape;

  DetailMainImage({this.landscape = false});

  @override
  Widget build(BuildContext context, model) {
    final theme = Theme.of(context);
    return Container(
      color: Theme.of(context).primaryColor,
      child: GestureDetector(
        onTap: model.withImageList || model.withImage
            ? () {
                model.togglePauseTimer();
                DialogImage.showCarousel(
                  context: context,
                  currentImage: model.currentImage,
                  images: model.images
                      .map((e) => '${model.baseImageUrl}$e')
                      .toList(),
                ).then((value) => model.togglePauseTimer());
              }
            : null,
        child: Stack(
          fit: StackFit.expand,
          children: [
            model.withImageList
                ? ContentImageWidget(model.images[model.currentImage])
                : model.withImage
                    ? ContentImageWidget(model.image)
                    : Card(
                        child: PlaceholderImage(height: 250),
                      ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: landscape ? Alignment.centerLeft : Alignment.topCenter,
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
            Positioned(
              right: 55,
              top: 5,
              child: ImageDownloadButton(
                model.baseImageUrl + model.images[model.currentImage],
                DateTime.now().toString(),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: MyCircularButton(
                icon: Icon(MyIcons.quality),
                color: Colors.black54,
                onPressed: model.isHighQualityImage
                    ? null
                    : () => model.toggleHighQualityImage(),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent),
                  gradient: RadialGradient(
                    radius: 3,
                    focalRadius: 5,
                    colors: [
                      Colors.black26,
                      Colors.black26,
                      Colors.transparent,
                    ],
                  ),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: AnimatedSmoothIndicator(
                  activeIndex: model.currentImage,
                  count: model.images.length,
                  effect: ScrollingDotsEffect(
                    activeDotColor: theme.accentColor,
                    dotColor: Colors.white30,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ContentImageWidget extends ViewModelWidget<ItemDetailViewModel> {
  final String imagePath;

  ContentImageWidget(this.imagePath, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: CachedNetworkImage(
        imageUrl: '${model.baseImageUrl}$imagePath',
        placeholder: (_, __) => CachedNetworkImage(
          // width: double.infinity,
          fit: BoxFit.fitWidth,
          imageUrl: '$URL_IMAGE_SMALL$imagePath',
        ),
        errorWidget: (ctx, _, __) =>
            PlaceholderImage(height: MediaQuery.of(ctx).size.height * 0.6),
        fit: BoxFit.fitWidth,
        // width: double.infinity,
      ),
    );
  }
}
